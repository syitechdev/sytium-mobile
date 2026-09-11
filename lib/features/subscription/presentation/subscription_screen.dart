import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/utils/app_dates.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/subscription/application/subscription_providers.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_models.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/shared/widgets/settings_list.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kOfferSkeletonHeight = 168.0;
const _kLabelLetterSpacing = 1.2;

/// Abonnement de l'organisation : l'offre en cours, son renouvellement, les
/// moyens de paiement et l'historique de facturation. Reserve aux
/// administrateurs — Explorer n'y mene qu'eux, et le serveur refuse les autres.
///
/// Perimetre mobile arbitre le 11/09 : consulter, renouveler, choisir le moyen
/// par defaut. Ajouter ou supprimer un moyen de paiement reste sur le web, et
/// le renouvellement automatique n'existe pas encore cote serveur.
class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  bool _renewing = false;

  void _toast(String message, {required bool error}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error ? context.colors.danger : context.colors.success,
        content: Text(message),
      ),
    );
  }

  Future<void> _renew() async {
    setState(() => _renewing = true);
    final result = await ref.read(subscriptionRepositoryProvider).renew();
    if (!mounted) return;

    await result.fold(
      (uri) async {
        final ouvert = await ref.read(urlOpenerProvider)(uri);
        if (!mounted) return;
        if (!ouvert) {
          _toast('Impossible d’ouvrir la page de paiement.', error: true);
        }
        // Au retour, l'etat a pu changer (paiement en attente, puis paye).
        ref.invalidate(subscriptionOverviewProvider);
      },
      (f) async =>
          _toast(f.message ?? 'Renouvellement impossible. Réessayez.', error: true),
    );

    if (mounted) setState(() => _renewing = false);
  }

  Future<void> _setDefault(OrgPaymentMethod method) async {
    if (method.isDefault) return;
    final echec = await ref
        .read(paymentMethodsControllerProvider.notifier)
        .setDefault(method.id);
    if (!mounted) return;
    if (echec == null) {
      await HapticFeedback.selectionClick();
      return;
    }
    _toast(echec.message ?? 'Enregistrement impossible. Réessayez.', error: true);
  }

  Future<void> _refresh() async {
    ref
      ..invalidate(subscriptionOverviewProvider)
      ..invalidate(subscriptionInvoicesProvider)
      ..invalidate(paymentMethodsControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final overview = ref.watch(subscriptionOverviewProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Abonnement')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: overview.when(
          skipLoadingOnRefresh: true,
          loading: () => const _Skeleton(),
          error: (_, _) => ListView(
            children: [
              const SizedBox(height: Tokens.space48),
              ErrorState(
                message: 'Impossible de charger votre abonnement.',
                onRetry: () => ref.invalidate(subscriptionOverviewProvider),
              ),
            ],
          ),
          data: (summary) => ListView(
            padding: const EdgeInsets.all(Tokens.space16),
            children: [
              _OfferCard(summary: summary),
              if (summary.status.demandeAction && summary.message != null) ...[
                const SizedBox(height: Tokens.space12),
                _Warning(message: summary.message!),
              ],
              const SizedBox(height: Tokens.space16),
              AppPrimaryButton(
                label: 'Renouveler maintenant',
                isLoading: _renewing,
                onPressed: _renew,
              ),
              const SizedBox(height: Tokens.space8),
              Text(
                'La page de paiement s’ouvre dans votre navigateur. Revenez ici '
                'une fois le paiement effectué.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.colors.textMuted,
                ),
              ),
              const SizedBox(height: Tokens.space24),
              _PaymentMethodsSection(onSelect: _setDefault),
              const _InvoicesSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.summary});

  final SubscriptionSummary summary;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final surBrand = colors.onBrand;
    final users = summary.users;
    final usage = users == null
        ? ''
        : '$users utilisateur${users == 1 ? '' : 's'} actif${users == 1 ? '' : 's'}';
    final fin = summary.endsAt;

    return Container(
      padding: const EdgeInsets.all(Tokens.space16),
      decoration: BoxDecoration(
        color: colors.brand,
        borderRadius: BorderRadius.circular(Tokens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.diamond, size: Tokens.space16, color: surBrand),
              const SizedBox(width: Tokens.space8),
              Expanded(
                child: Text(
                  'OFFRE ACTUELLE',
                  style: theme.labelSmall?.copyWith(
                    color: surBrand,
                    fontWeight: FontWeight.w600,
                    letterSpacing: _kLabelLetterSpacing,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Tokens.space8,
                  vertical: Tokens.space4,
                ),
                decoration: BoxDecoration(
                  color: surBrand.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(Tokens.radiusPill),
                ),
                child: Text(
                  summary.status.label.toUpperCase(),
                  style: theme.labelSmall?.copyWith(
                    color: surBrand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Tokens.space12),
          Text(
            summary.packName ?? summary.packCode?.toUpperCase() ?? 'Offre',
            style: theme.titleLarge?.copyWith(
              color: surBrand,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (summary.monthlyPrice != null)
            Text(
              '${Money.fcfa(summary.monthlyPrice!)} / mois',
              style: theme.titleMedium?.copyWith(color: surBrand),
            ),
          if (usage.isNotEmpty || fin != null) const SizedBox(height: Tokens.space12),
          if (usage.isNotEmpty)
            Text(
              usage,
              style: theme.bodySmall?.copyWith(
                color: surBrand.withValues(alpha: 0.85),
              ),
            ),
          if (fin != null)
            Text(
              'Prochain renouvellement : ${AppDates.long(fin)}',
              style: theme.bodySmall?.copyWith(
                color: surBrand.withValues(alpha: 0.85),
              ),
            ),
        ],
      ),
    );
  }
}

/// Message du serveur quand l'abonnement demande une action (delai de grace,
/// paiement non finalise) : c'est la raison d'etre du bouton qui suit.
class _Warning extends StatelessWidget {
  const _Warning({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, size: Tokens.space16, color: colors.warning),
          const SizedBox(width: Tokens.space8),
          Expanded(
            child: Text(message, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodsSection extends ConsumerWidget {
  const _PaymentMethodsSection({required this.onSelect});

  final Future<void> Function(OrgPaymentMethod) onSelect;

  IconData _icon(String type) => switch (type) {
    'card' => Icons.credit_card,
    'mobile_money' => Icons.phone_android,
    'bank_transfer' => Icons.account_balance_outlined,
    _ => Icons.payments_outlined,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final async = ref.watch(paymentMethodsControllerProvider);
    const pied = 'L’ajout et la suppression se font depuis la version web.';

    return async.when(
      skipLoadingOnRefresh: true,
      loading: () => const SettingsSection(
        title: 'Moyens de paiement',
        children: [SettingsMessageRow('Chargement…')],
      ),
      error: (_, _) => SettingsSection(
        title: 'Moyens de paiement',
        children: [
          SettingsTile(
            icon: Icons.refresh,
            title: 'Impossible de charger les moyens de paiement',
            subtitle: 'Toucher pour réessayer',
            accent: colors.danger,
            onTap: () => ref.invalidate(paymentMethodsControllerProvider),
          ),
        ],
      ),
      data: (methods) => SettingsSection(
        title: 'Moyens de paiement',
        footer: pied,
        children: methods.isEmpty
            ? const [SettingsMessageRow('Aucun moyen de paiement enregistré.')]
            : [
                for (final m in methods)
                  SettingsTile(
                    icon: _icon(m.type),
                    title: m.label,
                    subtitle: m.isDefault
                        ? '${m.typeLabel} · par défaut'
                        : m.typeLabel,
                    trailing: Icon(
                      m.isDefault
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: m.isDefault ? colors.brand : colors.textMuted,
                    ),
                    onTap: () => onSelect(m),
                  ),
              ],
      ),
    );
  }
}

class _InvoicesSection extends ConsumerWidget {
  const _InvoicesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final async = ref.watch(subscriptionInvoicesProvider);
    final mois = DateFormat('MMMM yyyy', 'fr_FR');

    return async.when(
      skipLoadingOnRefresh: true,
      loading: () => const SettingsSection(
        title: 'Historique de facturation',
        children: [SettingsMessageRow('Chargement…')],
      ),
      error: (_, _) => SettingsSection(
        title: 'Historique de facturation',
        children: [
          SettingsTile(
            icon: Icons.refresh,
            title: 'Impossible de charger les factures',
            subtitle: 'Toucher pour réessayer',
            accent: colors.danger,
            onTap: () => ref.invalidate(subscriptionInvoicesProvider),
          ),
        ],
      ),
      data: (invoices) => SettingsSection(
        title: 'Historique de facturation',
        children: invoices.isEmpty
            ? const [SettingsMessageRow('Aucune facture pour le moment.')]
            : [
                for (final f in invoices)
                  SettingsTile(
                    icon: Icons.receipt_long_outlined,
                    title: [
                      f.pack?.replaceAll(RegExp('[_-]'), ' ').toUpperCase() ??
                          'Abonnement',
                      if (f.periodStart != null) mois.format(f.periodStart!),
                    ].join(' — '),
                    subtitle: [
                      if ((f.paidAt ?? f.periodStart) != null)
                        AppDates.short((f.paidAt ?? f.periodStart)!),
                      if (f.paymentMethod != null && f.paymentMethod!.isNotEmpty)
                        f.paymentMethod!,
                      f.statusLabel,
                    ].where((p) => p.isNotEmpty).join(' · '),
                    trailing: f.total == null
                        ? null
                        : Text(
                            Money.fcfa(f.total!),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                          ),
                  ),
              ],
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);

    return ListView(
      padding: const EdgeInsets.all(Tokens.space16),
      children: [
        Container(
          height: _kOfferSkeletonHeight,
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(Tokens.radiusLg),
          ),
        ),
        const SizedBox(height: Tokens.space16),
        Container(
          height: Tokens.space48,
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(Tokens.radiusMd),
          ),
        ),
      ],
    );
  }
}
