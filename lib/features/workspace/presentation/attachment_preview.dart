import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders a single message attachment inside a bubble: an inline image
/// thumbnail (tap → fullscreen) for images, or a tappable file card (tap →
/// open in the system) for everything else.
class AttachmentView extends StatelessWidget {
  const AttachmentView({
    required this.attachment,
    required this.onBrand,
    super.key,
  });

  final Attachment attachment;
  final bool onBrand;

  @override
  Widget build(BuildContext context) {
    // Still uploading: the file only exists on this device, so render it from
    // disk rather than waiting for a signed URL that does not exist yet.
    final local = attachment.localPath;
    if (attachment.isImage && local != null && local.isNotEmpty) {
      return _LocalImageAttachment(path: local);
    }
    if (attachment.isImage && (attachment.url?.isNotEmpty ?? false)) {
      return _ImageAttachment(attachment: attachment);
    }
    // Note vocale / audio : lecteur inline (play/pause + progression), au lieu
    // d'ouvrir un fichier. Le média est en m4a/AAC, lu nativement iOS + Android.
    final audioSrc = attachment.url ?? attachment.downloadUrl;
    if (attachment.isAudio && (audioSrc?.isNotEmpty ?? false)) {
      return _AudioAttachment(attachment: attachment, onBrand: onBrand);
    }
    return _FileAttachment(attachment: attachment, onBrand: onBrand);
  }
}

/// An image being uploaded, read straight from the device. No tap target: the
/// message is not persisted yet, so there is nothing to open full screen.
class _LocalImageAttachment extends StatelessWidget {
  const _LocalImageAttachment({required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Tokens.radiusSm),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220, maxWidth: 260),
        child: Image.file(File(path), fit: BoxFit.cover),
      ),
    );
  }
}

class _ImageAttachment extends StatelessWidget {
  const _ImageAttachment({required this.attachment});
  final Attachment attachment;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => _openFullscreen(context, attachment.url!, attachment.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Tokens.radiusSm),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 220, maxWidth: 260),
          child: CachedNetworkImage(
            imageUrl: attachment.url!,
            // Cache by the stable attachment id: the backend rotates the signed
            // URL on every fetch, so keying by URL would re-download and flicker
            // on each poll. Keying by id serves from cache instead.
            cacheKey: attachment.id,
            fit: BoxFit.cover,
            placeholder: (context, _) => Container(
              width: 180,
              height: 140,
              color: colors.background,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
            errorWidget: (context, _, __) =>
                _FileAttachment(attachment: attachment, onBrand: false),
          ),
        ),
      ),
    );
  }
}

class _FileAttachment extends StatelessWidget {
  const _FileAttachment({required this.attachment, required this.onBrand});
  final Attachment attachment;
  final bool onBrand;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fg = onBrand ? colors.onChrome : colors.textPrimary;
    final muted = onBrand
        ? colors.onChrome.withValues(alpha: 0.8)
        : colors.textMuted;
    return InkWell(
      onTap: () => _openExternal(context, attachment),
      borderRadius: BorderRadius.circular(Tokens.radiusSm),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 240),
        padding: const EdgeInsets.all(Tokens.space8),
        decoration: BoxDecoration(
          color: (onBrand ? colors.onChrome : colors.textMuted).withValues(
            alpha: 0.08,
          ),
          borderRadius: BorderRadius.circular(Tokens.radiusSm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_iconFor(attachment.mimeType), color: fg),
            const SizedBox(width: Tokens.space8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    attachment.fileName.isEmpty
                        ? 'Fichier'
                        : attachment.fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: fg, fontWeight: FontWeight.w600),
                  ),
                  if (attachment.sizeBytes > 0)
                    Text(
                      _humanSize(attachment.sizeBytes),
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: muted),
                    ),
                ],
              ),
            ),
            const SizedBox(width: Tokens.space4),
            Icon(Icons.download_outlined, size: 18, color: muted),
          ],
        ),
      ),
    );
  }
}

/// Lecteur audio inline (play/pause + progression + durée) pour les notes
/// vocales. Chargement paresseux : le flux n'est ouvert qu'au premier appui.
/// Lecture m4a/AAC, native sur iOS et Android.
class _AudioAttachment extends ConsumerStatefulWidget {
  const _AudioAttachment({required this.attachment, required this.onBrand});
  final Attachment attachment;
  final bool onBrand;

  @override
  ConsumerState<_AudioAttachment> createState() => _AudioAttachmentState();
}

class _AudioAttachmentState extends ConsumerState<_AudioAttachment> {
  final AudioPlayer _player = AudioPlayer();
  bool _prepared = false;
  bool _loading = false;
  bool _failed = false;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  /// Télécharge le média via le Dio AUTHENTIFIÉ dans un fichier temporaire puis
  /// le lit en local. Plus robuste que streamer l'URL distante : gère l'auth de
  /// la route `download_url` et évite les soucis de requêtes range/redirections
  /// (c'est ce qui donnait « Lecture impossible »).
  Future<void> _prepare() async {
    final src = widget.attachment.downloadUrl ?? widget.attachment.url;
    if (src == null || src.isEmpty) {
      throw StateError('no source');
    }
    final res = await ref
        .read(workspaceRepositoryProvider)
        .downloadAttachment(src);
    final bytes = res.valueOrNull;
    if (bytes == null || bytes.isEmpty) {
      throw StateError('download failed');
    }
    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/sytium_audio_${widget.attachment.id}${_audioExt(widget.attachment)}',
    );
    await file.writeAsBytes(bytes, flush: true);
    await _player.setFilePath(file.path);
    _prepared = true;
  }

  Future<void> _toggle() async {
    try {
      if (!_prepared) {
        setState(() {
          _loading = true;
          _failed = false;
        });
        await _prepare();
        if (!mounted) return;
        setState(() => _loading = false);
      }
      if (_player.playing) {
        await _player.pause();
      } else {
        if (_player.processingState == ProcessingState.completed) {
          await _player.seek(Duration.zero);
        }
        await _player.play();
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _failed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final muted = widget.onBrand
        ? colors.onChrome.withValues(alpha: 0.8)
        : colors.textMuted;
    final accent = widget.onBrand ? colors.onChrome : colors.brand;

    return Container(
      constraints: const BoxConstraints(maxWidth: 260),
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space4,
        vertical: Tokens.space4,
      ),
      decoration: BoxDecoration(
        color: (widget.onBrand ? colors.onChrome : colors.textMuted).withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(Tokens.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<PlayerState>(
            stream: _player.playerStateStream,
            builder: (context, snap) {
              final playing = snap.data?.playing ?? false;
              final completed =
                  snap.data?.processingState == ProcessingState.completed;
              final showPause = playing && !completed;
              return IconButton(
                onPressed: _loading ? null : _toggle,
                iconSize: 30,
                color: accent,
                icon: _loading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: accent,
                        ),
                      )
                    : Icon(
                        showPause
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: accent,
                      ),
              );
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<Duration>(
                  stream: _player.positionStream,
                  builder: (context, posSnap) {
                    final pos = posSnap.data ?? Duration.zero;
                    final dur = _player.duration ?? Duration.zero;
                    final frac = dur.inMilliseconds == 0
                        ? 0.0
                        : (pos.inMilliseconds / dur.inMilliseconds).clamp(
                            0.0,
                            1.0,
                          );
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(Tokens.radiusPill),
                      child: LinearProgressIndicator(
                        value: _failed ? 0 : frac,
                        minHeight: 4,
                        backgroundColor: muted.withValues(alpha: 0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(accent),
                      ),
                    );
                  },
                ),
                const SizedBox(height: Tokens.space4),
                StreamBuilder<Duration>(
                  stream: _player.positionStream,
                  builder: (context, posSnap) {
                    if (_failed) {
                      return Text(
                        'Lecture impossible',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.danger,
                        ),
                      );
                    }
                    final pos = posSnap.data ?? Duration.zero;
                    final dur = _player.duration;
                    final label = dur == null
                        ? _fmtDuration(pos)
                        : '${_fmtDuration(pos)} / ${_fmtDuration(dur)}';
                    return Text(
                      label,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: muted),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: Tokens.space4),
        ],
      ),
    );
  }
}

String _fmtDuration(Duration d) {
  final m = d.inMinutes;
  final s = d.inSeconds % 60;
  return '$m:${s.toString().padLeft(2, '0')}';
}

/// Extension du fichier temporaire : iOS/AVPlayer choisit son décodeur d'après
/// l'extension. On la déduit du nom d'origine, sinon du MIME (défaut m4a/AAC).
String _audioExt(Attachment a) {
  final name = a.fileName.toLowerCase();
  for (final ext in ['.m4a', '.mp3', '.aac', '.wav', '.caf']) {
    if (name.endsWith(ext)) return ext;
  }
  if (name.endsWith('.mp4')) return '.m4a';
  final mime = a.mimeType ?? '';
  if (mime.contains('mpeg') || mime.contains('mp3')) return '.mp3';
  if (mime.contains('aac')) return '.aac';
  if (mime.contains('wav')) return '.wav';
  return '.m4a';
}

Future<void> _openExternal(BuildContext context, Attachment a) async {
  // Ouvrir l'URL SIGNÉE (`url`) en priorité : elle est accessible sans jeton
  // (comme pour l'affichage des images). `downloadUrl` route par l'API et exige
  // un Bearer que le navigateur externe n'a pas → il affichait « non
  // authentifié ». On garde downloadUrl en repli si l'URL signée manque.
  final target = a.url ?? a.downloadUrl;
  if (target == null || target.isEmpty) return;
  final ok = await launchUrl(
    Uri.parse(target),
    mode: LaunchMode.externalApplication,
  );
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Impossible d'ouvrir le fichier.")),
    );
  }
}

void _openFullscreen(BuildContext context, String url, String cacheKey) {
  Navigator.of(context).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.black,
      pageBuilder: (_, __, ___) =>
          _FullscreenImage(url: url, cacheKey: cacheKey),
    ),
  );
}

class _FullscreenImage extends StatelessWidget {
  const _FullscreenImage({required this.url, required this.cacheKey});
  final String url;
  final String cacheKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              maxScale: 4,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: url,
                  cacheKey: cacheKey,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + Tokens.space8,
            right: Tokens.space8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

IconData _iconFor(String? mime) {
  final m = mime ?? '';
  if (m.contains('pdf')) return Icons.picture_as_pdf_outlined;
  if (m.startsWith('video/')) return Icons.videocam_outlined;
  if (m.startsWith('audio/')) return Icons.audiotrack_outlined;
  if (m.contains('sheet') || m.contains('excel') || m.contains('csv')) {
    return Icons.table_chart_outlined;
  }
  if (m.contains('word') || m.contains('document')) {
    return Icons.description_outlined;
  }
  return Icons.insert_drive_file_outlined;
}

String _humanSize(int bytes) {
  if (bytes < 1024) return '$bytes o';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} Ko';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} Mo';
}
