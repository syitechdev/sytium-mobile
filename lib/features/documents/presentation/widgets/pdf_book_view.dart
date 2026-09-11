import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/documents/application/document_viewer_providers.dart';
import 'package:sytium_mobile/features/documents/data/pdf_renderer.dart';
import 'package:sytium_mobile/features/documents/domain/document_file.dart';
import 'package:sytium_mobile/features/documents/presentation/document_viewer_screen.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// À partir de ce nombre de pages, le lecteur passe en mode livre : la règle
/// `minPages` du bouton FlipBook du web. En dessous, un simple défilement.
const kBookMinPages = 3;

/// Inclinaison maximale d'une page qui tourne, et profondeur de perspective.
const _kMaxTurnAngle = math.pi / 2.4;
const _kPerspective = 0.0012;

/// Pages gardées en mémoire : la courante et ses voisines, pas le document.
const _kImageCacheSize = 6;

/// Au-delà, le gain de netteté ne vaut pas la mémoire consommée.
const _kMaxRenderPixelRatio = 2.5;
const _kMaxZoom = 4.0;
const _kZoomEpsilon = 1.01;

/// Lecteur PDF : pages rendues à la demande, zoom au pincement (double tap
/// pour revenir), et effet de page qui tourne en mode livre.
class PdfBookView extends ConsumerStatefulWidget {
  const PdfBookView({required this.file, super.key});

  final DocumentFile file;

  @override
  ConsumerState<PdfBookView> createState() => _PdfBookViewState();
}

class _PdfBookViewState extends ConsumerState<PdfBookView> {
  PdfBook? _book;
  Object? _error;
  bool _loading = true;

  /// Ordre d'insertion conservé : les premières clés sont les plus anciennes.
  final _images = <int, Uint8List>{};
  final _pending = <int, Future<Uint8List?>>{};

  final _controller = PageController();
  int _current = 0;
  bool _zoomed = false;

  @override
  void initState() {
    super.initState();
    unawaited(_open());
  }

  Future<void> _open() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final book = await ref.read(pdfOpenerProvider).open(widget.file.path);
      if (!mounted) {
        await book.close();
        return;
      }
      setState(() {
        _book = book;
        _loading = false;
      });
    } on Object catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    unawaited(_book?.close());
    super.dispose();
  }

  /// Rendu d'une page, mémorisé : la même page n'est jamais rendue deux fois
  /// en parallèle, et les plus anciennes sortent du cache.
  Future<Uint8List?> _render(int index, double width) {
    final cached = _images.remove(index);
    if (cached != null) {
      _images[index] = cached;
      return Future.value(cached);
    }

    final book = _book;
    if (book == null) return Future.value();

    return _pending[index] ??= book
        .renderPage(index, width: width)
        .then(
          (bytes) {
            _pending.remove(index);
            if (bytes != null) {
              _images[index] = bytes;
              while (_images.length > _kImageCacheSize) {
                _images.remove(_images.keys.first);
              }
            }
            return bytes;
          },
          onError: (Object e, StackTrace s) {
            _pending.remove(index);
            Error.throwWithStackTrace(e, s);
          },
        );
  }

  void _setZoomed({required bool zoomed}) {
    if (zoomed != _zoomed) setState(() => _zoomed = zoomed);
  }

  @override
  Widget build(BuildContext context) {
    final book = _book;

    if (_loading) return const _PagePlaceholderFrame();
    if (_error != null || book == null) {
      return Center(
        child: ErrorState(
          message: 'Ce PDF ne peut pas être affiché.',
          onRetry: _open,
        ),
      );
    }
    if (book.pageCount == 0) {
      return Center(
        child: Text(
          'Ce document ne contient aucune page.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: context.colors.textMuted),
        ),
      );
    }

    final media = MediaQuery.of(context);
    final pageWidth = media.size.width - 2 * Tokens.space16;
    final renderWidth =
        pageWidth * math.min(media.devicePixelRatio, _kMaxRenderPixelRatio);

    Widget page(int index) => _ZoomablePage(
      onZoomChanged: (zoomed) => _setZoomed(zoomed: zoomed),
      child: _PdfPage(
        key: ValueKey(index),
        index: index,
        load: () => _render(index, renderWidth),
      ),
    );

    if (book.pageCount < kBookMinPages) {
      return Scrollbar(
        child: ListView.separated(
          physics: _zoomed ? const NeverScrollableScrollPhysics() : null,
          padding: const EdgeInsets.all(Tokens.space16),
          itemCount: book.pageCount,
          separatorBuilder: (_, _) => const SizedBox(height: Tokens.space16),
          itemBuilder: (_, index) => page(index),
        ),
      );
    }

    final reduceMotion = media.disableAnimations;

    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          physics: _zoomed ? const NeverScrollableScrollPhysics() : null,
          itemCount: book.pageCount,
          onPageChanged: (index) => setState(() => _current = index),
          itemBuilder: (_, index) => _TurningPage(
            controller: _controller,
            index: index,
            enabled: !reduceMotion,
            child: Padding(
              padding: const EdgeInsets.all(Tokens.space16),
              child: Center(child: page(index)),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: Tokens.space16,
          child: Center(
            child: _PageIndicator(
              current: _current + 1,
              total: book.pageCount,
            ),
          ),
        ),
      ],
    );
  }
}

/// Une page qui pivote sur sa tranche en quittant l'écran, comme une feuille
/// qu'on tourne. Désactivé si l'utilisateur a demandé moins d'animations.
class _TurningPage extends StatelessWidget {
  const _TurningPage({
    required this.controller,
    required this.index,
    required this.enabled,
    required this.child,
  });

  final PageController controller;
  final int index;
  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return AnimatedBuilder(
      animation: controller,
      child: child,
      builder: (context, child) {
        var page = index.toDouble();
        if (controller.hasClients && controller.position.hasContentDimensions) {
          page = controller.page ?? page;
        }
        final delta = (index - page).clamp(-1.0, 1.0);
        if (delta == 0) return child!;

        return Transform(
          // La page de gauche pivote sur son bord droit, celle de droite sur
          // son bord gauche : les deux se rejoignent sur la « reliure ».
          alignment: delta < 0 ? Alignment.centerRight : Alignment.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, _kPerspective)
            ..rotateY(delta * _kMaxTurnAngle),
          child: child,
        );
      },
    );
  }
}

/// Zoom au pincement ; le déplacement n'est actif qu'une fois zoomé, pour que
/// le glissement tourne les pages le reste du temps. Double tap : retour.
class _ZoomablePage extends StatefulWidget {
  const _ZoomablePage({required this.onZoomChanged, required this.child});

  final ValueChanged<bool> onZoomChanged;
  final Widget child;

  @override
  State<_ZoomablePage> createState() => _ZoomablePageState();
}

class _ZoomablePageState extends State<_ZoomablePage> {
  final _transform = TransformationController();
  bool _zoomed = false;

  @override
  void initState() {
    super.initState();
    _transform.addListener(_onTransform);
  }

  void _onTransform() {
    final zoomed = _transform.value.getMaxScaleOnAxis() > _kZoomEpsilon;
    if (zoomed == _zoomed) return;
    setState(() => _zoomed = zoomed);
    widget.onZoomChanged(zoomed);
  }

  @override
  void dispose() {
    _transform
      ..removeListener(_onTransform)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => _transform.value = Matrix4.identity(),
      child: InteractiveViewer(
        transformationController: _transform,
        maxScale: _kMaxZoom,
        panEnabled: _zoomed,
        child: widget.child,
      ),
    );
  }
}

class _PdfPage extends StatefulWidget {
  const _PdfPage({required this.index, required this.load, super.key});

  final int index;
  final Future<Uint8List?> Function() load;

  @override
  State<_PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<_PdfPage> {
  late Future<Uint8List?> _future = widget.load();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return FutureBuilder<Uint8List?>(
      future: _future,
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) {
          return _PagePlaceholder(
            failed: snapshot.hasError ||
                snapshot.connectionState == ConnectionState.done,
            onRetry: () => setState(() => _future = widget.load()),
          );
        }
        return DecoratedBox(
          decoration: BoxDecoration(border: Border.all(color: colors.border)),
          child: Image.memory(
            bytes,
            fit: BoxFit.contain,
            gaplessPlayback: true,
            semanticLabel: 'Page ${widget.index + 1}',
          ),
        );
      },
    );
  }
}

class _PagePlaceholder extends StatelessWidget {
  const _PagePlaceholder({required this.failed, required this.onRetry});

  final bool failed;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AspectRatio(
      aspectRatio: kA4Ratio,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.border.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(Tokens.radiusSm),
        ),
        child: failed
            ? Center(
                child: IconButton(
                  tooltip: 'Réessayer',
                  onPressed: onRetry,
                  icon: Icon(Icons.refresh, color: colors.textMuted),
                ),
              )
            : null,
      ),
    );
  }
}

/// Squelette pleine page pendant l'ouverture du PDF.
class _PagePlaceholderFrame extends StatelessWidget {
  const _PagePlaceholderFrame();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Tokens.space24),
      child: Center(
        child: _PagePlaceholder(failed: false, onRetry: () {}),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      liveRegion: true,
      label: 'Page $current sur $total',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Tokens.space12,
          vertical: Tokens.space4,
        ),
        decoration: BoxDecoration(
          color: colors.card,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(Tokens.radiusPill),
        ),
        child: Text(
          '$current / $total',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
    );
  }
}
