import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_statuses.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/theme/branding.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';
import 'package:video_player/video_player.dart';

/// Palette de fonds pour un statut texte (esprit data-viz Sytium + neutres).
const _kStatusColors = <String>[
  '#0A1730',
  '#13B98A',
  '#6D5EF6',
  '#F59E0B',
  '#DC2626',
  '#2563EB',
  '#EC4899',
  '#0F172A',
];

/// Ouvre le choix de création d'un statut (Texte / Photo / Vidéo), façon
/// WhatsApp. Le média est choisi depuis la galerie.
Future<void> openNewStatus(BuildContext context) async {
  await showAppSheet<void>(
    context,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.title),
            title: const Text('Statut texte'),
            subtitle: const Text('Fond coloré'),
            onTap: () {
              Navigator.of(sheetContext).pop();
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const StatusTextComposer(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Photo'),
            onTap: () async {
              Navigator.of(sheetContext).pop();
              final file = await ImagePicker().pickImage(
                source: ImageSource.gallery,
                imageQuality: 80,
                maxWidth: 1920,
                maxHeight: 1920,
              );
              if (file != null && context.mounted) {
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        StatusMediaComposer(path: file.path, isVideo: false),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_library_outlined),
            title: const Text('Vidéo'),
            onTap: () async {
              Navigator.of(sheetContext).pop();
              final file = await ImagePicker().pickVideo(
                source: ImageSource.gallery,
                maxDuration: const Duration(seconds: 30),
              );
              if (file != null && context.mounted) {
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        StatusMediaComposer(path: file.path, isVideo: true),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}

/// Éditeur de statut texte : fond coloré (palette), texte centré, publication.
class StatusTextComposer extends ConsumerStatefulWidget {
  const StatusTextComposer({super.key});

  @override
  ConsumerState<StatusTextComposer> createState() => _StatusTextComposerState();
}

class _StatusTextComposerState extends ConsumerState<StatusTextComposer> {
  final _controller = TextEditingController();
  String _bg = _kStatusColors.first;
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    final result = await ref
        .read(workspaceRepositoryProvider)
        .createStatus(content: text, bgColor: _bg);
    if (!mounted) return;
    setState(() => _sending = false);
    result.fold(
      (_) {
        ref.invalidate(statusGroupsProvider);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Statut publié.')));
      },
      (f) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(f.message ?? 'Publication impossible.')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = parseHexColor(_bg) ?? Tokens.navy;
    final onBg = bg.computeLuminance() > 0.6 ? Colors.black87 : Colors.white;
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: onBg),
        actions: [
          if (_sending)
            const Padding(
              padding: EdgeInsets.all(Tokens.space16),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _publish,
              child: Text(
                'Publier',
                style: TextStyle(color: onBg, fontWeight: FontWeight.w700),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(Tokens.space24),
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  maxLines: null,
                  cursorColor: onBg,
                  style: TextStyle(
                    color: onBg,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tapez un statut…',
                    hintStyle: TextStyle(color: onBg.withValues(alpha: 0.6)),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: SizedBox(
              height: 56,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: Tokens.space16),
                itemCount: _kStatusColors.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: Tokens.space12),
                itemBuilder: (context, i) {
                  final hex = _kStatusColors[i];
                  final c = parseHexColor(hex) ?? Tokens.navy;
                  final selected = hex == _bg;
                  return GestureDetector(
                    onTap: () => setState(() => _bg = hex),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected ? onBg : Colors.white24,
                          width: selected ? 3 : 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Aperçu d'un statut média (photo/vidéo) + légende, avant publication.
class StatusMediaComposer extends ConsumerStatefulWidget {
  const StatusMediaComposer({
    required this.path,
    required this.isVideo,
    super.key,
  });

  final String path;
  final bool isVideo;

  @override
  ConsumerState<StatusMediaComposer> createState() =>
      _StatusMediaComposerState();
}

class _StatusMediaComposerState extends ConsumerState<StatusMediaComposer> {
  final _caption = TextEditingController();
  VideoPlayerController? _video;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      final c = VideoPlayerController.file(File(widget.path));
      _video = c;
      c.initialize().then((_) {
        if (!mounted) return;
        c
          ..setLooping(true)
          ..play();
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _caption.dispose();
    _video?.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    if (_sending) return;
    setState(() => _sending = true);
    final caption = _caption.text.trim();
    final result = await ref
        .read(workspaceRepositoryProvider)
        .createStatus(
          mediaPath: widget.path,
          content: caption.isEmpty ? null : caption,
        );
    if (!mounted) return;
    setState(() => _sending = false);
    result.fold(
      (_) {
        ref.invalidate(statusGroupsProvider);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Statut publié.')));
      },
      (f) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(f.message ?? 'Publication impossible.')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final v = _video;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: widget.isVideo
                  ? (v != null && v.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: v.value.aspectRatio <= 0
                                ? 9 / 16
                                : v.value.aspectRatio,
                            child: VideoPlayer(v),
                          )
                        : const CircularProgressIndicator())
                  : Image.file(File(widget.path), fit: BoxFit.contain),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(Tokens.space12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _caption,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Ajouter une légende…',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Tokens.radiusPill,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Tokens.space16,
                          vertical: Tokens.space8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Tokens.space8),
                  FloatingActionButton(
                    onPressed: _sending ? null : _publish,
                    backgroundColor: context.colors.brand,
                    foregroundColor: context.colors.onBrand,
                    child: _sending
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
