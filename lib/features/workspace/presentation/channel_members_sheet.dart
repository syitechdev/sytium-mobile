import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Ouvre la feuille « Membres (n) » d'un canal : liste avec présence + rôles,
/// et — pour un owner/admin — l'ajout de membres.
Future<void> showChannelMembersSheet(
  BuildContext context, {
  required Conversation conversation,
}) {
  return showAppSheet<void>(
    context,
    builder: (_) => _ChannelMembersSheet(conversation: conversation),
  );
}

class _ChannelMembersSheet extends ConsumerWidget {
  const _ChannelMembersSheet({required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rosterAsync = ref.watch(channelRosterProvider(conversation.id));
    final online = ref.watch(onlineByUserProvider).valueOrNull ?? const {};
    final me = ref.watch(currentUserIdProvider);

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
          child: Text(
            rosterAsync.maybeWhen(
              data: (m) => 'Membres (${m.length})',
              orElse: () => 'Membres',
            ),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Flexible(
          child: rosterAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(Tokens.space24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => Padding(
              padding: const EdgeInsets.all(Tokens.space16),
              child: ErrorState(
                message: 'Impossible de charger les membres.',
                onRetry: () =>
                    ref.invalidate(channelRosterProvider(conversation.id)),
              ),
            ),
            data: (members) {
              final canManage = members.any(
                (m) => m.userId == me && m.canManage,
              );
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (canManage)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Tokens.space16,
                        0,
                        Tokens.space16,
                        Tokens.space8,
                      ),
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.person_add_alt_1, size: 18),
                        label: const Text('Ajouter des membres'),
                        onPressed: () => _openAddMembers(context, members),
                      ),
                    ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: Tokens.space16),
                      itemCount: members.length,
                      itemBuilder: (context, i) {
                        final m = members[i];
                        final isOnline = online[m.userId] ?? false;
                        return ListTile(
                          leading: _AvatarWithDot(member: m, online: isOnline),
                          title: Text(
                            m.userId == me
                                ? '${m.fullName} (vous)'
                                : m.fullName,
                          ),
                          subtitle: (m.poste?.isNotEmpty ?? false)
                              ? Text(m.poste!)
                              : null,
                          trailing: _RoleChip(role: m.role),
                          dense: true,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _openAddMembers(
    BuildContext context,
    List<Member> existing,
  ) async {
    Navigator.of(context).pop();
    await showAppSheet<void>(
      context,
      builder: (_) => _AddMembersSheet(
        channelId: conversation.id,
        existingUserIds: existing.map((m) => m.userId).toSet(),
      ),
    );
  }
}

/// Avatar avec pastille de présence en surimpression.
class _AvatarWithDot extends StatelessWidget {
  const _AvatarWithDot({required this.member, required this.online});

  final Member member;
  final bool online;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        children: [
          AppAvatar(
            name: member.fullName,
            imageUrl: member.avatarUrl,
            radius: 18,
          ),
          if (online)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: colors.brand,
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.card, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Puce de rôle (Owner/Admin) ; rien pour un membre standard.
class _RoleChip extends StatelessWidget {
  const _RoleChip({required this.role});

  final String? role;

  @override
  Widget build(BuildContext context) {
    final label = switch (role) {
      'owner' => 'Propriétaire',
      'admin' => 'Admin',
      _ => null,
    };
    if (label == null) return const SizedBox.shrink();
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: colors.brand.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: colors.brand,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Sélecteur multi-membres à ajouter au canal. Le roster de l'organisation moins
/// les membres déjà présents ; confirme via `addMembers` (403 → message clair).
class _AddMembersSheet extends ConsumerStatefulWidget {
  const _AddMembersSheet({
    required this.channelId,
    required this.existingUserIds,
  });

  final String channelId;
  final Set<String> existingUserIds;

  @override
  ConsumerState<_AddMembersSheet> createState() => _AddMembersSheetState();
}

class _AddMembersSheetState extends ConsumerState<_AddMembersSheet> {
  final Set<String> _selected = {};
  String _query = '';
  bool _submitting = false;

  Future<void> _submit() async {
    if (_selected.isEmpty || _submitting) return;
    setState(() => _submitting = true);
    final result = await ref
        .read(workspaceRepositoryProvider)
        .addMembers(widget.channelId, _selected.toList());
    if (!mounted) return;
    setState(() => _submitting = false);
    result.fold(
      (_) {
        ref
          ..invalidate(channelRosterProvider(widget.channelId))
          ..invalidate(conversationsProvider);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Membres ajoutés.')));
      },
      (f) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(f.message ?? 'Ajout impossible.'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rosterAsync = ref.watch(orgMembersProvider);
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
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Rechercher un collaborateur…',
              prefixIcon: Icon(Icons.search),
              isDense: true,
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Flexible(
          child: rosterAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(Tokens.space24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const Padding(
              padding: EdgeInsets.all(Tokens.space16),
              child: Text('Impossible de charger les collaborateurs.'),
            ),
            data: (all) {
              final q = _query.toLowerCase();
              final candidates = all
                  .where((m) => !widget.existingUserIds.contains(m.userId))
                  .where((m) => m.fullName.toLowerCase().contains(q))
                  .toList();
              if (candidates.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(Tokens.space16),
                  child: Text('Aucun collaborateur à ajouter.'),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: candidates.length,
                itemBuilder: (context, i) {
                  final m = candidates[i];
                  final checked = _selected.contains(m.userId);
                  return CheckboxListTile(
                    value: checked,
                    dense: true,
                    secondary: AppAvatar(
                      name: m.fullName,
                      imageUrl: m.avatarUrl,
                      radius: 16,
                    ),
                    title: Text(m.fullName),
                    subtitle: (m.poste?.isNotEmpty ?? false)
                        ? Text(m.poste!)
                        : null,
                    onChanged: (v) => setState(() {
                      if (v ?? false) {
                        _selected.add(m.userId);
                      } else {
                        _selected.remove(m.userId);
                      }
                    }),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Tokens.space16),
          child: FilledButton(
            onPressed: _selected.isEmpty || _submitting ? null : _submit,
            child: _submitting
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    _selected.isEmpty
                        ? 'Ajouter'
                        : 'Ajouter (${_selected.length})',
                  ),
          ),
        ),
      ],
    );
  }
}
