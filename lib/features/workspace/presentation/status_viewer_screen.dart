import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/theme/branding.dart';
import 'package:sytium_mobile/theme/tokens.dart';
import 'package:video_player/video_player.dart';

/// Durée d'affichage d'un statut texte/image avant auto-avance.
const _kStatusDuration = Duration(seconds: 5);

/// Visionneuse plein écran type stories : barres de progression segmentées,
/// auto-avance, tap gauche/droite pour naviguer (à travers les auteurs), appui
/// long pour mettre en pause. Chaque statut affiché est marqué « vu ».
class StatusViewerScreen extends ConsumerStatefulWidget {
  const StatusViewerScreen({
    required this.groups,
    required this.initialGroup,
    super.key,
  });

  final List<StatusAuthorGroup> groups;
  final int initialGroup;

  @override
  ConsumerState<StatusViewerScreen> createState() => _StatusViewerScreenState();
}

class _StatusViewerScreenState extends ConsumerState<StatusViewerScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progress;
  VideoPlayerController? _video;
  late int _groupIndex;
  int _statusIndex = 0;
  bool _paused = false;
  final Set<String> _viewed = {};

  @override
  void initState() {
    super.initState();
    _groupIndex = widget.initialGroup;
    _progress = AnimationController(vsync: this, duration: _kStatusDuration)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) _next();
      });
    WidgetsBinding.instance.addPostFrameCallback((_) => _startCurrent());
  }

  @override
  void dispose() {
    _progress.dispose();
    _video?.dispose();
    super.dispose();
  }

  StatusAuthorGroup get _group => widget.groups[_groupIndex];
  WorkspaceStatus get _current => _group.statuses[_statusIndex];

  Future<void> _startCurrent() async {
    _progress
      ..stop()
      ..reset();
    await _video?.dispose();
    _video = null;

    // Marquer vu (une fois par statut affiché).
    final id = _current.id;
    if (_viewed.add(id)) {
      unawaited(ref.read(workspaceRepositoryProvider).viewStatus(id));
    }

    if (_current.kind == StatusKind.video &&
        (_current.mediaUrl?.isNotEmpty ?? false)) {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(_current.mediaUrl!),
      );
      _video = controller;
      try {
        await controller.initialize();
        if (!mounted) return;
        controller.addListener(_onVideoTick);
        await controller.play();
        setState(() {});
      } catch (_) {
        // Média illisible : on enchaîne comme un statut texte de 5 s.
        _video = null;
        if (mounted) unawaited(_progress.forward());
      }
    } else {
      if (mounted) {
        setState(() {});
        unawaited(_progress.forward());
      }
    }
  }

  void _onVideoTick() {
    final v = _video?.value;
    if (v == null || !v.isInitialized) return;
    if (v.position >= v.duration && v.duration > Duration.zero) {
      _next();
    } else {
      setState(() {}); // met à jour la barre de progression vidéo
    }
  }

  void _next() {
    if (_statusIndex < _group.statuses.length - 1) {
      setState(() => _statusIndex++);
    } else if (_groupIndex < widget.groups.length - 1) {
      setState(() {
        _groupIndex++;
        _statusIndex = 0;
      });
    } else {
      Navigator.of(context).maybePop();
      return;
    }
    _startCurrent();
  }

  void _prev() {
    if (_statusIndex > 0) {
      setState(() => _statusIndex--);
    } else if (_groupIndex > 0) {
      setState(() {
        _groupIndex--;
        _statusIndex = widget.groups[_groupIndex].statuses.length - 1;
      });
    } else {
      _startCurrent(); // déjà au premier : on rejoue
      return;
    }
    _startCurrent();
  }

  void _setPaused(bool paused) {
    if (_paused == paused) return;
    setState(() => _paused = paused);
    if (paused) {
      _progress.stop();
      final v = _video;
      if (v != null) unawaited(v.pause());
    } else {
      if (_video != null) {
        unawaited(_video!.play());
      } else if (_progress.status != AnimationStatus.completed) {
        unawaited(_progress.forward());
      }
    }
  }

  double _valueFor(int j) {
    if (j < _statusIndex) return 1;
    if (j > _statusIndex) return 0;
    final v = _video?.value;
    if (v != null && v.isInitialized && v.duration > Duration.zero) {
      return (v.position.inMilliseconds / v.duration.inMilliseconds).clamp(
        0.0,
        1.0,
      );
    }
    return _progress.value;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: (d) {
          if (d.globalPosition.dx < size.width * 0.33) {
            _prev();
          } else {
            _next();
          }
        },
        onLongPressStart: (_) => _setPaused(true),
        onLongPressEnd: (_) => _setPaused(false),
        onVerticalDragEnd: (d) {
          if ((d.primaryVelocity ?? 0) > 200) Navigator.of(context).maybePop();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: _StatusContent(status: _current, video: _video),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + Tokens.space8,
              left: Tokens.space8,
              right: Tokens.space8,
              child: Column(
                children: [
                  Row(
                    children: [
                      for (var j = 0; j < _group.statuses.length; j++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: AnimatedBuilder(
                              animation: _progress,
                              builder: (context, _) => ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Tokens.radiusPill,
                                ),
                                child: LinearProgressIndicator(
                                  value: _valueFor(j),
                                  minHeight: 3,
                                  backgroundColor: Colors.white24,
                                  valueColor: const AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: Tokens.space8),
                  _Header(
                    group: _group,
                    createdAt: _current.createdAt,
                    onClose: () => Navigator.of(context).maybePop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Rendu du contenu selon le type : texte coloré, image, ou vidéo.
class _StatusContent extends StatelessWidget {
  const _StatusContent({required this.status, required this.video});
  final WorkspaceStatus status;
  final VideoPlayerController? video;

  @override
  Widget build(BuildContext context) {
    switch (status.kind) {
      case StatusKind.text:
        final bg = parseHexColor(status.bgColor) ?? Tokens.navy;
        final onBg = bg.computeLuminance() > 0.6
            ? Colors.black87
            : Colors.white;
        return Container(
          color: bg,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(Tokens.space32),
          child: Text(
            status.content ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: onBg,
              fontSize: 26,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        );
      case StatusKind.image:
        final url = status.mediaUrl;
        if (url == null || url.isEmpty) return const _Broken();
        return Center(
          child: CachedNetworkImage(
            imageUrl: url,
            cacheKey: status.id,
            fit: BoxFit.contain,
            placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (_, __, ___) => const _Broken(),
          ),
        );
      case StatusKind.video:
        final v = video;
        if (v != null && v.value.isInitialized) {
          return Center(
            child: AspectRatio(
              aspectRatio: v.value.aspectRatio <= 0
                  ? 9 / 16
                  : v.value.aspectRatio,
              child: VideoPlayer(v),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
    }
  }
}

class _Broken extends StatelessWidget {
  const _Broken();
  @override
  Widget build(BuildContext context) => const Center(
    child: Icon(Icons.broken_image_outlined, color: Colors.white54, size: 48),
  );
}

class _Header extends StatelessWidget {
  const _Header({
    required this.group,
    required this.createdAt,
    required this.onClose,
  });
  final StatusAuthorGroup group;
  final DateTime? createdAt;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(
          name: group.authorName.isEmpty ? '?' : group.authorName,
          imageUrl: group.authorAvatarUrl,
          radius: 18,
        ),
        const SizedBox(width: Tokens.space8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.isMine ? 'Vous' : group.authorName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _relative(createdAt),
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: onClose,
        ),
      ],
    );
  }
}

String _relative(DateTime? at) {
  if (at == null) return '';
  final d = DateTime.now().difference(at.toLocal());
  if (d.inMinutes < 1) return "à l'instant";
  if (d.inMinutes < 60) return 'il y a ${d.inMinutes} min';
  if (d.inHours < 24) return 'il y a ${d.inHours} h';
  return 'il y a ${d.inDays} j';
}
