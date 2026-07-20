import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/approvals/application/approvals_providers.dart';
import 'package:sytium_mobile/features/approvals/domain/approval_models.dart';
import 'package:sytium_mobile/features/approvals/presentation/permission_pay_sheet.dart';
import 'package:sytium_mobile/features/approvals/presentation/reject_reason_sheet.dart';
import 'package:sytium_mobile/features/approvals/presentation/widgets/approval_card.dart';
import 'package:sytium_mobile/features/notifications/application/notifications_providers.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kSkeletonCards = 3;
const _kSkeletonCardHeight = 180.0;

/// The filter chips. `null` type = Tous.
enum _Filter { tous, conges, permissions, objectifs }

extension on _Filter {
  ApprovalType? get type => switch (this) {
    _Filter.tous => null,
    _Filter.conges => ApprovalType.leave,
    _Filter.permissions => ApprovalType.permission,
    _Filter.objectifs => ApprovalType.objective,
  };
  String get label => switch (this) {
    _Filter.tous => 'Tous',
    _Filter.conges => 'Congés',
    _Filter.permissions => 'Permissions',
    _Filter.objectifs => 'Objectifs',
  };
}

class ApprovalsScreen extends ConsumerStatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  ConsumerState<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends ConsumerState<ApprovalsScreen> {
  _Filter _filter = _Filter.tous;

  // Local optimistic state, seeded from the provider's first data emission.
  List<ApprovalItem>? _items;
  ApprovalCounts _counts = const ApprovalCounts();
  final Set<String> _busy = {};

  void _seed(PendingApprovals p) {
    _items ??= List.of(p.items);
    // Keep counts in sync on first seed only (optimistic edits own them after).
    if (_items!.length == p.items.length && _counts.total == 0) {
      _counts = p.counts;
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _items = null;
      _counts = const ApprovalCounts();
    });
    ref.invalidate(pendingApprovalsProvider);
  }

  Future<void> _approve(ApprovalItem item) async {
    // Le N+1 tranche la rémunération d'une permission avant d'approuver ; on
    // ne l'envoie que dans ce cas (pas sur mission, pas aux paliers RH /
    // Direction, jamais sur un refus).
    bool? isPaid;
    if (item.requiresPayDecision) {
      isPaid = await showPermissionPaySheet(context);
      if (isPaid == null || !mounted) return; // annulé
    }
    setState(() => _busy.add(item.id));
    final repo = ref.read(approvalsRepositoryProvider);
    final result = switch (item.type) {
      ApprovalType.leave => await repo.approveLeave(item.id),
      ApprovalType.permission => await repo.approvePermission(
        item.id,
        isPaid: isPaid,
      ),
      ApprovalType.objective => await repo.validateObjective(item.id),
      ApprovalType.unknown => const Err<void>(UnknownFailure()),
    };
    _handle(item, result, successMsg: 'Demande traitée.');
  }

  Future<void> _reject(ApprovalItem item) async {
    final comment = await showRejectReasonSheet(
      context,
      reasonRequired: item.action.rejectRequiresReason,
    );
    if (comment == null || !mounted) return; // cancelled
    setState(() => _busy.add(item.id));
    final repo = ref.read(approvalsRepositoryProvider);
    final c = comment.isEmpty ? null : comment;
    final result = switch (item.type) {
      ApprovalType.leave => await repo.rejectLeave(item.id, commentaire: c),
      ApprovalType.permission =>
        await repo.rejectPermission(item.id, commentaire: c),
      ApprovalType.objective =>
        await repo.validateObjective(item.id, rejetMotif: comment),
      ApprovalType.unknown => const Err<void>(UnknownFailure()),
    };
    _handle(item, result, successMsg: 'Demande refusée.');
  }

  void _handle(
    ApprovalItem item,
    Result<void> result, {
    required String successMsg,
  }) {
    if (!mounted) return;
    result.fold(
      (_) {
        HapticFeedback.lightImpact();
        _remove(item);
        ref.read(unreadCountProvider.notifier).decrement();
        _toast(successMsg, error: false);
      },
      (f) {
        setState(() => _busy.remove(item.id));
        if (f is ApprovalFailure && f.code == 'STALE') {
          _remove(item);
          _toast(f.message ?? 'Cette demande a déjà été traitée.', error: true);
        } else {
          _toast(_message(f), error: true);
        }
      },
    );
  }

  void _remove(ApprovalItem item) {
    setState(() {
      _busy.remove(item.id);
      _items = (_items ?? []).where((i) => i.id != item.id).toList();
      _counts = _counts.decrement(item.type);
    });
  }

  String _message(Failure f) {
    if (f is ApprovalFailure && f.code == 'MISSION_PROOF_REQUIRED') {
      return f.message ??
          'Pièce justificative requise — utilisez le web pour cette mission.';
    }
    return f.message ?? 'Action impossible.';
  }

  void _toast(String message, {required bool error}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error
            ? context.colors.danger
            : context.colors.success,
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(pendingApprovalsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Approbations')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: async.when(
          loading: () => const _ApprovalsSkeleton(),
          error: (e, _) => ListView(
            children: [
              const SizedBox(height: Tokens.space48),
              ErrorState(
                message: 'Impossible de charger les approbations.',
                onRetry: () => ref.invalidate(pendingApprovalsProvider),
              ),
            ],
          ),
          data: (pending) {
            _seed(pending);
            final items = _items ?? const <ApprovalItem>[];
            final filtered = _filter.type == null
                ? items
                : items.where((i) => i.type == _filter.type).toList();

            return ListView(
              padding: const EdgeInsets.all(Tokens.space16),
              children: [
                _Filters(
                  selected: _filter,
                  counts: _counts,
                  total: items.length,
                  onSelected: (f) => setState(() => _filter = f),
                ),
                const SizedBox(height: Tokens.space16),
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: Tokens.space48),
                    child: Center(
                      child: Text('Aucune approbation en attente.'),
                    ),
                  )
                else
                  for (final item in filtered) ...[
                    ApprovalCard(
                      item: item,
                      busy: _busy.contains(item.id),
                      onApprove: () => _approve(item),
                      onReject: () => _reject(item),
                    ),
                    const SizedBox(height: Tokens.space12),
                  ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    required this.selected,
    required this.counts,
    required this.total,
    required this.onSelected,
  });

  final _Filter selected;
  final ApprovalCounts counts;
  final int total;
  final ValueChanged<_Filter> onSelected;

  int _count(_Filter f) =>
      f.type == null ? total : counts.forType(f.type!);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: Tokens.space8,
      children: [
        for (final f in _Filter.values)
          ChoiceChip(
            label: Text('${f.label} (${_count(f)})'),
            selected: selected == f,
            selectedColor: colors.brand.withValues(alpha: 0.16),
            onSelected: (_) => onSelected(f),
          ),
      ],
    );
  }
}

/// Skeleton mirroring the card list while approvals load.
class _ApprovalsSkeleton extends StatelessWidget {
  const _ApprovalsSkeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        for (var i = 0; i < _kSkeletonCards; i++) ...[
          Container(
            height: _kSkeletonCardHeight,
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(Tokens.radiusMd),
            ),
          ),
          const SizedBox(height: Tokens.space12),
        ],
      ],
    );
  }
}
