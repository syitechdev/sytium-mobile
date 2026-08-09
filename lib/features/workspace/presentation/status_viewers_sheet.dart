import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_statuses.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Feuille « Vu par » d'un de mes statuts.
Future<void> showStatusViewers(BuildContext context, String statusId) {
  return showAppSheet<void>(
    context,
    builder: (_) => _StatusViewersSheet(statusId: statusId),
  );
}

class _StatusViewersSheet extends ConsumerWidget {
  const _StatusViewersSheet({required this.statusId});
  final String statusId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final async = ref.watch(statusViewersProvider(statusId));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Tokens.space16,
            0,
            Tokens.space16,
            Tokens.space8,
          ),
          child: Row(
            children: [
              Icon(
                Icons.visibility_outlined,
                size: 18,
                color: colors.textMuted,
              ),
              const SizedBox(width: Tokens.space8),
              Text(
                async.maybeWhen(
                  data: (v) => 'Vu par ${v.length}',
                  orElse: () => 'Vu par',
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Flexible(
          child: async.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(Tokens.space24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => Padding(
              padding: const EdgeInsets.all(Tokens.space16),
              child: Text(
                'Impossible de charger les vues.',
                style: TextStyle(color: colors.textMuted),
              ),
            ),
            data: (viewers) {
              if (viewers.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(Tokens.space16),
                  child: Text('Personne n’a encore vu ce statut.'),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: Tokens.space16),
                itemCount: viewers.length,
                itemBuilder: (context, i) {
                  final v = viewers[i];
                  return ListTile(
                    dense: true,
                    leading: AppAvatar(name: v.fullName, radius: 16),
                    title: Text(v.fullName.isEmpty ? 'Membre' : v.fullName),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
