import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_module.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/features/explorer/presentation/widgets/module_tile.dart';
import 'package:sytium_mobile/shared/widgets/confirm_dialog.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

class ExplorerScreen extends ConsumerWidget {
  const ExplorerScreen({super.key});

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) {
    return showConfirmDialog(
      context,
      title: 'Déconnexion',
      message: 'Voulez-vous vraiment vous déconnecter de votre compte ?',
      confirmLabel: 'Se déconnecter',
      destructive: true,
      onConfirm: () => ref.read(authControllerProvider.notifier).logout(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    final auth = ref.watch(authControllerProvider).valueOrNull;
    final modules = auth is Authenticated
        ? auth.session.capabilities.modules
        : const <MobileModule>[];

    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        Text('Mes modules', style: theme.titleSmall),
        const SizedBox(height: Tokens.space12),
        if (modules.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Tokens.space24),
              child: Center(
                child: Text(
                  'Aucun module disponible pour le moment.',
                  style: theme.bodySmall?.copyWith(
                    color: context.colors.textMuted,
                  ),
                ),
              ),
            ),
          )
        else
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: Tokens.space12,
            crossAxisSpacing: Tokens.space12,
            childAspectRatio: 0.95,
            children: [
              for (final m in modules)
                ModuleTile(
                  label: m.label,
                  icon: moduleIcon(m.icon),
                  onTap: () => navigateForModule(context, m.featureKey),
                ),
            ],
          ),
        const SizedBox(height: Tokens.space32),
        Text('Paramètres', style: theme.titleSmall),
        const SizedBox(height: Tokens.space12),
        OutlinedButton.icon(
          onPressed: () => _confirmLogout(context, ref),
          icon: const Icon(Icons.logout),
          label: const Text('Déconnexion'),
        ),
      ],
    );
  }
}
