import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Opens the « Nouveau canal » sheet; resolves to the created [Conversation].
Future<Conversation?> showCreateChannelSheet(BuildContext context) {
  return showModalBottomSheet<Conversation>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _CreateChannelSheet(),
  );
}

enum _ChannelKind { public, private }

class _CreateChannelSheet extends ConsumerStatefulWidget {
  const _CreateChannelSheet();

  @override
  ConsumerState<_CreateChannelSheet> createState() => _CreateChannelSheetState();
}

class _CreateChannelSheetState extends ConsumerState<_CreateChannelSheet> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  _ChannelKind _kind = _ChannelKind.public;
  bool _submitting = false;
  String? _nameError;
  String? _banner;

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _name.text.trim();
    setState(() {
      _nameError = name.isEmpty ? 'Nom du canal requis.' : null;
      _banner = null;
    });
    if (name.isEmpty) return;

    setState(() => _submitting = true);
    final result = await ref.read(workspaceRepositoryProvider).createChannel(
          name: name,
          type: _kind == _ChannelKind.public ? 'public' : 'private',
          description: _description.text.trim(),
        );
    if (!mounted) return;
    setState(() => _submitting = false);
    result.fold(
      (convo) => Navigator.of(context).pop(convo),
      (f) => setState(
        () => _banner = f.message ?? 'Création impossible. Réessayez.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(Tokens.radiusPill),
                ),
              ),
            ),
            const SizedBox(height: Tokens.space16),
            Text('Nouveau canal', style: theme.titleLarge),
            const SizedBox(height: Tokens.space24),
            if (_banner != null) ...[
              Container(
                padding: const EdgeInsets.all(Tokens.space12),
                decoration: BoxDecoration(
                  color: colors.danger.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(Tokens.radiusSm),
                  border: Border.all(color: colors.danger.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: colors.danger, size: 20),
                    const SizedBox(width: Tokens.space8),
                    Expanded(child: Text(_banner!)),
                  ],
                ),
              ),
              const SizedBox(height: Tokens.space16),
            ],
            AppTextField(
              controller: _name,
              label: 'Nom du canal',
              hint: 'Ex : direction, chantier-abidjan…',
              prefixIcon: Icons.tag,
              errorText: _nameError,
            ),
            const SizedBox(height: Tokens.space16),
            Text('Visibilité', style: theme.labelLarge),
            const SizedBox(height: Tokens.space8),
            SegmentedButton<_ChannelKind>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: _ChannelKind.public,
                  label: Text('Public'),
                  icon: Icon(Icons.tag),
                ),
                ButtonSegment(
                  value: _ChannelKind.private,
                  label: Text('Privé'),
                  icon: Icon(Icons.lock_outline),
                ),
              ],
              selected: {_kind},
              onSelectionChanged: (s) => setState(() => _kind = s.first),
            ),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _description,
              label: 'Description (optionnel)',
              hint: 'À quoi sert ce canal ?',
              maxLines: 2,
            ),
            const SizedBox(height: Tokens.space24),
            AppPrimaryButton(
              label: 'Créer le canal',
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
