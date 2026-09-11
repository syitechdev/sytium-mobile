import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/app/currency/currency_controller.dart';
import 'package:sytium_mobile/app/theme/theme_mode_controller.dart';
import 'package:sytium_mobile/core/utils/app_dates.dart';
import 'package:sytium_mobile/core/utils/currency.dart';
import 'package:sytium_mobile/features/account/presentation/change_password_screen.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_module.dart';
import 'package:sytium_mobile/features/devices/presentation/connected_devices_screen.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/features/explorer/presentation/widgets/module_tile.dart';
import 'package:sytium_mobile/features/settings/presentation/notification_preferences_screen.dart';
import 'package:sytium_mobile/features/subscription/application/subscription_providers.dart';
import 'package:sytium_mobile/features/subscription/presentation/subscription_screen.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/shared/widgets/confirm_dialog.dart';
import 'package:sytium_mobile/shared/widgets/settings_list.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kHeaderAvatarRadius = 32.0;

/// Cible tactile minimale d'un choix de devise (accessibilite, CLAUDE.md §6).
const _kMinTouchTarget = 44.0;

/// Statuts d'abonnement qui demandent une action de l'administrateur.
const _kStatutsARenouveler = {
  'en_grace',
  'payment_pending',
  'expire_bloque',
  'suspended',
};

/// Onglet Explorer, a la forme de la page Profil demandee par le client : une
/// carte d'identite en tete, puis des sections en liste — Mes modules,
/// Entreprise, Preferences, Securite.
///
/// Les lignes Abonnement et Moyens de paiement ne s'affichent qu'aux
/// administrateurs : le serveur refuse ces donnees aux autres, les montrer
/// promettrait un ecran qui repondrait « acces refuse ».
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

  void _open(BuildContext context, Widget screen) => Navigator.of(
    context,
  ).push(MaterialPageRoute<void>(builder: (_) => screen));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider).valueOrNull;
    final session = auth is Authenticated ? auth.session : null;
    final user = session?.user;
    final modules = session?.capabilities.modules ?? const <MobileModule>[];
    final regime = session?.fiscal.regime;
    // Meme regle que le serveur (assertOrganizationBillingAdmin).
    final estAdmin =
        user?.roles.any((r) => r == 'admin' || r == 'super_admin') ?? false;
    final colors = context.colors;

    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        if (user != null) ...[
          _ProfileHeader(user: user),
          const SizedBox(height: Tokens.space24),
        ],
        SettingsSection(
          title: 'Mes modules',
          children: modules.isEmpty
              ? const [
                  SettingsMessageRow('Aucun module disponible pour le moment.'),
                ]
              : [
                  for (final m in modules)
                    SettingsTile(
                      icon: moduleIcon(m.icon),
                      title: m.label,
                      onTap: () => navigateForModule(context, m.featureKey),
                    ),
                ],
        ),
        SettingsSection(
          title: 'Entreprise',
          children: [
            SettingsTile(
              icon: Icons.apartment_outlined,
              title: user?.organizationName ?? 'Organisation',
              subtitle: [
                'Organisation',
                if (regime != null && regime.isNotEmpty)
                  regime.replaceAll('_', ' ').toUpperCase(),
                // XOF est la devise pivot de toute la comptabilite ; la devise
                // d'AFFICHAGE, elle, se regle dans les preferences.
                AppCurrency.xof.code,
              ].join(' · '),
            ),
            if (estAdmin && user != null) ...[
              _SubscriptionTile(
                user: user,
                onTap: () => _open(context, const SubscriptionScreen()),
              ),
              _PaymentMethodsTile(
                onTap: () => _open(context, const SubscriptionScreen()),
              ),
            ],
          ],
        ),
        SettingsSection(
          title: 'Préférences',
          children: [
            const _DarkModeTile(),
            const _CurrencyTile(),
            SettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Rappels de pointage, heures de silence',
              onTap: () =>
                  _open(context, const NotificationPreferencesScreen()),
            ),
          ],
        ),
        SettingsSection(
          title: 'Sécurité',
          children: [
            SettingsTile(
              icon: Icons.key_outlined,
              title: 'Mot de passe',
              subtitle: 'Modifier votre mot de passe',
              onTap: () => _open(context, const ChangePasswordScreen()),
            ),
            SettingsTile(
              icon: Icons.devices_outlined,
              title: 'Appareils connectés',
              subtitle: 'Sessions ouvertes sur votre compte',
              onTap: () => _open(context, const ConnectedDevicesScreen()),
            ),
            SettingsTile(
              icon: Icons.logout,
              title: 'Déconnexion',
              accent: colors.danger,
              titleColor: colors.danger,
              trailing: const SizedBox.shrink(),
              onTap: () => _confirmLogout(context, ref),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final offre = user.organizationPackName;
    final ligne = [
      user.roleLabel,
      if (user.organizationName != null) user.organizationName!,
    ].join(' · ');

    return Container(
      padding: const EdgeInsets.all(Tokens.space16),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(Tokens.radiusLg),
      ),
      child: Row(
        children: [
          AppAvatar(
            name: user.name,
            imageUrl: user.photoUrl,
            radius: _kHeaderAvatarRadius,
          ),
          const SizedBox(width: Tokens.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: theme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  ligne,
                  style: theme.bodySmall?.copyWith(color: colors.textMuted),
                ),
                if (offre != null && offre.isNotEmpty) ...[
                  const SizedBox(height: Tokens.space8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Tokens.space8,
                      vertical: Tokens.space4,
                    ),
                    decoration: BoxDecoration(
                      color: colors.brand.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(Tokens.radiusPill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.diamond,
                          size: Tokens.space12,
                          color: colors.brand,
                        ),
                        const SizedBox(width: Tokens.space4),
                        Text(
                          offre,
                          style: theme.labelMedium?.copyWith(
                            color: colors.brand,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Ligne Abonnement : l'offre et la date de renouvellement viennent de la
/// session, sans appel supplementaire.
class _SubscriptionTile extends StatelessWidget {
  const _SubscriptionTile({required this.user, required this.onTap});

  final AuthUser user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fin = user.subscriptionEndsAt;
    final aRenouveler = _kStatutsARenouveler.contains(user.subscriptionStatus);

    return SettingsTile(
      icon: Icons.diamond_outlined,
      title: 'Abonnement',
      subtitle: aRenouveler
          ? 'À renouveler'
          : [
              user.organizationPackName ?? 'Votre offre',
              if (fin != null) 'renouvellement le ${AppDates.short(fin)}',
            ].join(' · '),
      subtitleColor: aRenouveler ? context.colors.danger : null,
      onTap: onTap,
    );
  }
}

class _PaymentMethodsTile extends ConsumerWidget {
  const _PaymentMethodsTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methodes = ref.watch(paymentMethodsControllerProvider).valueOrNull;
    final resume = methodes == null || methodes.isEmpty
        ? 'Moyen de paiement par défaut'
        : [
            for (final m in methodes)
              m.isDefault ? '${m.label} (défaut)' : m.label,
          ].join(' · ');

    return SettingsTile(
      icon: Icons.credit_card,
      title: 'Moyens de paiement',
      subtitle: resume,
      onTap: onTap,
    );
  }
}

class _DarkModeTile extends ConsumerWidget {
  const _DarkModeTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lu sur le theme REELLEMENT affiche, pour que le mode « systeme » se
    // resolve comme le bouton de la barre d'application.
    final sombre = Theme.of(context).brightness == Brightness.dark;

    void basculer({required bool actif}) {
      HapticFeedback.selectionClick();
      ref
          .read(themeModeControllerProvider.notifier)
          .setMode(actif ? ThemeMode.dark : ThemeMode.light);
    }

    return SettingsTile(
      icon: Icons.dark_mode_outlined,
      title: 'Mode sombre',
      subtitle: sombre ? 'Activé' : 'Désactivé',
      trailing: Switch(
        value: sombre,
        onChanged: (v) => basculer(actif: v),
      ),
      onTap: () => basculer(actif: !sombre),
    );
  }
}

class _CurrencyTile extends ConsumerWidget {
  const _CurrencyTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final courante = ref.watch(currencyControllerProvider);

    return SettingsTile(
      icon: Icons.currency_exchange,
      title: 'Devise d’affichage',
      subtitle: courante == AppCurrency.xof
          ? '${courante.code} (pivot comptable)'
          : '${courante.code} · converti depuis le XOF',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final c in AppCurrency.values)
            Semantics(
              button: true,
              selected: c == courante,
              label: 'Afficher en ${c.label}',
              child: InkWell(
                borderRadius: BorderRadius.circular(Tokens.radiusSm),
                onTap: () {
                  HapticFeedback.selectionClick();
                  ref.read(currencyControllerProvider.notifier).setCurrency(c);
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: _kMinTouchTarget,
                    minHeight: _kMinTouchTarget,
                  ),
                  child: Center(
                    child: Text(
                      c.code,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: c == courante ? colors.brand : colors.textMuted,
                        fontWeight: c == courante
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
