import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/pointage/application/pointage_providers.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/history_tile.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Déclenche le chargement de la page suivante avant d'atteindre le bas.
const _kLoadMoreThreshold = 200.0;

const _kHandleWidth = 44.0;
const _kHandleHeight = 5.0;

/// Bandeau d'état affiché en tête du sheet, résumant le verdict de zone.
class ZoneBanner extends StatelessWidget {
  const ZoneBanner({
    required this.color,
    required this.icon,
    required this.label,
    this.detail,
    super.key,
  });

  final Color color;
  final IconData icon;
  final String label;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: Tokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (detail != null)
                  Text(
                    detail!,
                    style: theme.bodySmall?.copyWith(
                      color: context.colors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Sheet flottant posé sur la carte : verdict, action de pointage, historique.
///
/// Redimensionnable à la main et défilant à l'intérieur — l'historique peut
/// être long sans jamais pousser la carte hors de l'écran.
class PointerSheet extends ConsumerStatefulWidget {
  const PointerSheet({
    required this.header,
    required this.punch,
    required this.minSize,
    required this.initialSize,
    required this.maxSize,
    super.key,
  });

  /// Bandeau de verdict, construit par l'écran qui connaît l'état.
  final Widget header;

  /// Bloc d'action, construit par l'écran (bouton, refus, confirmation).
  final Widget punch;

  final double minSize;
  final double initialSize;
  final double maxSize;

  @override
  ConsumerState<PointerSheet> createState() => _PointerSheetState();
}

class _PointerSheetState extends ConsumerState<PointerSheet> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final historyAsync = ref.watch(pointageHistoryProvider);
    final historyNotifier = ref.read(pointageHistoryProvider.notifier);

    return DraggableScrollableSheet(
      minChildSize: widget.minSize,
      initialChildSize: widget.initialSize,
      maxChildSize: widget.maxSize,
      builder: (context, scrollController) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            final metrics = notification.metrics;
            if (metrics.pixels >= metrics.maxScrollExtent - _kLoadMoreThreshold) {
              historyNotifier.loadMore();
            }
            return false;
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(Tokens.radiusLg),
              ),
              border: Border.all(color: colors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.22),
                  blurRadius: 20,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Tokens.space16,
                      Tokens.space12,
                      Tokens.space16,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: _kHandleWidth,
                            height: _kHandleHeight,
                            decoration: BoxDecoration(
                              color: colors.border,
                              borderRadius: BorderRadius.circular(
                                Tokens.radiusPill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Tokens.space16),
                        widget.header,
                        const SizedBox(height: Tokens.space16),
                        widget.punch,
                        const SizedBox(height: Tokens.space24),
                        Text('Historique', style: theme.titleSmall),
                        const SizedBox(height: Tokens.space8),
                      ],
                    ),
                  ),
                ),
                historyAsync.when(
                  loading: () => const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(Tokens.space24),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  error: (e, _) => SliverToBoxAdapter(
                    child: ErrorState(
                      message: 'Historique indisponible.',
                      onRetry: () => ref.invalidate(pointageHistoryProvider),
                    ),
                  ),
                  data: (entries) {
                    if (entries.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(Tokens.space24),
                          child: Center(
                            child: Text('Aucun pointage pour le moment.'),
                          ),
                        ),
                      );
                    }

                    final hasMore = historyNotifier.hasMore;
                    return SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        Tokens.space16,
                        0,
                        Tokens.space16,
                        Tokens.space24,
                      ),
                      sliver: SliverList.builder(
                        itemCount: entries.length + (hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == entries.length) {
                            return const Padding(
                              padding: EdgeInsets.all(Tokens.space16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          return HistoryTile(entry: entries[index]);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
