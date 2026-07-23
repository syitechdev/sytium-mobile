import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/requests/application/requests_providers.dart';
import 'package:sytium_mobile/features/requests/presentation/leave_form_sheet.dart';
import 'package:sytium_mobile/features/requests/presentation/permission_form_sheet.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/leave_card.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/permission_card.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/shared/widgets/minimal_tabs.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// The two panes of the requests screen.
enum RequestTab { leaves, permissions }

const _kSkeletonCards = 3;
const _kSkeletonCardHeight = 120.0;

class RequestsScreen extends ConsumerStatefulWidget {
  const RequestsScreen({super.key});

  @override
  ConsumerState<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends ConsumerState<RequestsScreen> {
  RequestTab _tab = RequestTab.leaves;

  Future<void> _create() async {
    // Capture tab before await so context is used synchronously.
    final tab = _tab;
    final bool? changed;
    if (tab == RequestTab.leaves) {
      changed = await showLeaveFormSheet(context);
    } else {
      changed = await showPermissionFormSheet(context);
    }
    if (!mounted || !(changed ?? false)) return;
    if (tab == RequestTab.leaves) {
      ref.invalidate(leavesProvider);
    } else {
      ref.invalidate(permissionsProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes congés & permissions')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _create,
        icon: const Icon(Icons.add),
        label: Text(
          _tab == RequestTab.leaves ? 'Déposer un congé' : 'Nouvelle demande',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Tokens.space16,
              Tokens.space16,
              Tokens.space16,
              0,
            ),
            child: MinimalTabs<RequestTab>(
              selected: _tab,
              onSelected: (t) => setState(() => _tab = t),
              tabs: const [
                MinimalTab(value: RequestTab.leaves, label: 'Congés'),
                MinimalTab(value: RequestTab.permissions, label: 'Permissions'),
              ],
            ),
          ),
          Expanded(
            child: _tab == RequestTab.leaves
                ? const _LeavesPane()
                : const _PermissionsPane(),
          ),
        ],
      ),
    );
  }
}

class _LeavesPane extends ConsumerWidget {
  const _LeavesPane();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(leavesProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(leavesProvider),
      child: async.when(
        loading: () => const _RequestsSkeleton(),
        error: (e, _) => ListView(
          children: [
            const SizedBox(height: Tokens.space48),
            ErrorState(
              message: 'Impossible de charger vos congés.',
              onRetry: () => ref.invalidate(leavesProvider),
            ),
          ],
        ),
        data: (leaves) {
          if (leaves.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: Tokens.space48),
                Center(child: Text('Aucune demande de congé.')),
              ],
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(Tokens.space16),
            itemCount: leaves.length,
            separatorBuilder: (_, __) => const SizedBox(height: Tokens.space12),
            itemBuilder: (context, i) {
              final leave = leaves[i];
              return LeaveCard(
                leave: leave,
                onCancel: leave.statut.isCancellable
                    ? () => _cancel(context, ref, leave.id)
                    : null,
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref, String id) async {
    final result = await ref.read(requestsRepositoryProvider).cancelLeave(id);
    if (!context.mounted) return;
    result.fold(
      (_) => ref.invalidate(leavesProvider),
      (f) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: context.colors.danger,
          content: Text(_cancelMessage(f)),
        ),
      ),
    );
  }

  String _cancelMessage(Failure f) {
    if (f is RequestFailure && f.code == 'CONFLICT') {
      return f.message ?? 'Cette demande a déjà été traitée.';
    }
    return f.message ?? 'Annulation impossible.';
  }
}

class _PermissionsPane extends ConsumerWidget {
  const _PermissionsPane();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(permissionsProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(permissionsProvider),
      child: async.when(
        loading: () => const _RequestsSkeleton(),
        error: (e, _) => ListView(
          children: [
            const SizedBox(height: Tokens.space48),
            ErrorState(
              message: 'Impossible de charger vos permissions.',
              onRetry: () => ref.invalidate(permissionsProvider),
            ),
          ],
        ),
        data: (permissions) {
          if (permissions.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: Tokens.space48),
                Center(child: Text('Aucune permission ou mission.')),
              ],
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(Tokens.space16),
            itemCount: permissions.length,
            separatorBuilder: (_, __) => const SizedBox(height: Tokens.space12),
            itemBuilder: (context, i) =>
                PermissionCard(permission: permissions[i]),
          );
        },
      ),
    );
  }
}

/// Skeleton mirroring the card list while a pane loads.
class _RequestsSkeleton extends StatelessWidget {
  const _RequestsSkeleton();

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
