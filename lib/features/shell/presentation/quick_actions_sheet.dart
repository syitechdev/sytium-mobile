import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/cash/presentation/cash_movement_sheet.dart';
import 'package:sytium_mobile/features/explorer/presentation/module_navigation.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_models.dart';
import 'package:sytium_mobile/features/invoicing/presentation/sales_doc_form_sheet.dart';
import 'package:sytium_mobile/features/pointage/presentation/pointer_screen.dart';
import 'package:sytium_mobile/features/requests/presentation/leave_form_sheet.dart';
import 'package:sytium_mobile/features/requests/presentation/permission_form_sheet.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Une action rapide du bouton central.
enum QuickAction {
  pointer,
  facture,
  proforma,
  cash,
  permission,
  conge,
  objectives,
}

/// Ouvre le menu d'actions rapides, puis exécute l'action choisie.
///
/// Le menu ne fait que **retourner** l'action : l'exécution a lieu ensuite,
/// avec le contexte de l'écran et non celui de la feuille en train d'être
/// démontée. C'est ce qui évite le piège des feuilles imbriquées (ouvrir une
/// feuille depuis un contexte déjà dépilé).
Future<void> openQuickActions(
  BuildContext context, {
  required MobileCapabilities capabilities,
}) async {
  final action = await showAppSheet<QuickAction>(
    context,
    builder: (_) => _QuickActionsSheet(capabilities: capabilities),
  );

  if (action == null || !context.mounted) return;
  await _run(context, action);
}

Future<void> _run(BuildContext context, QuickAction action) async {
  switch (action) {
    case QuickAction.pointer:
      await Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const PointerScreen()),
      );
    case QuickAction.facture:
      await showSalesDocSheet(context, initialKind: SalesDocKind.comptant);
    case QuickAction.proforma:
      // Proforma est le mode par défaut de la feuille.
      await showSalesDocSheet(context);
    case QuickAction.cash:
      await showCashMovementSheet(context);
    case QuickAction.permission:
      await showPermissionFormSheet(context);
    case QuickAction.conge:
      await showLeaveFormSheet(context);
    case QuickAction.objectives:
      // La proposition d'objectifs dépend de la semaine courante, résolue par
      // l'écran ; on y navigue plutôt que de dupliquer ce calcul ici.
      navigateForModule(context, 'objectives');
  }
}

/// Description d'une entrée du menu.
class _ActionSpec {
  const _ActionSpec({
    required this.action,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.tint,
    required this.visible,
  });

  final QuickAction action;
  final IconData icon;
  final String label;
  final String subtitle;

  /// Couleur d'accent de la pastille — reprend le langage couleur de la marque.
  final Color Function(SytiumColors) tint;

  /// L'action est-elle offerte à ce profil ?
  final bool visible;
}

/// Sections du menu, dans l'ordre d'affichage. Une section sans action visible
/// disparaît entièrement (titre compris).
class _Section {
  const _Section(this.title, this.actions);
  final String title;
  final List<_ActionSpec> actions;
}

class _QuickActionsSheet extends StatelessWidget {
  const _QuickActionsSheet({required this.capabilities});

  final MobileCapabilities capabilities;

  List<_Section> _sections(SytiumColors colors) {
    final caps = capabilities;
    return [
      _Section('Présence', [
        _ActionSpec(
          action: QuickAction.pointer,
          icon: Icons.qr_code_scanner,
          label: 'Pointer',
          subtitle: 'Scanner le QR de présence',
          tint: (c) => c.navy,
          visible: true,
        ),
      ]),
      _Section('Ventes & caisse', [
        _ActionSpec(
          action: QuickAction.facture,
          icon: Icons.receipt_long_outlined,
          label: 'Enregistrer une facture',
          subtitle: 'Vente au comptant',
          tint: (c) => c.brand,
          visible: caps.financeWrite,
        ),
        _ActionSpec(
          action: QuickAction.proforma,
          icon: Icons.request_quote_outlined,
          label: 'Ajouter une proforma',
          subtitle: 'Devis non comptabilisé',
          tint: (c) => c.ai,
          visible: caps.financeWrite || caps.commercial,
        ),
        _ActionSpec(
          action: QuickAction.cash,
          icon: Icons.point_of_sale_outlined,
          label: 'Encaissement / décaissement',
          subtitle: 'Mouvement de caisse',
          tint: (c) => c.brand,
          visible: caps.financeWrite,
        ),
      ]),
      _Section('Mes demandes', [
        _ActionSpec(
          action: QuickAction.conge,
          icon: Icons.beach_access_outlined,
          label: 'Demander un congé',
          subtitle: 'Absence planifiée',
          tint: (c) => c.info,
          visible: caps.leaveRequests,
        ),
        _ActionSpec(
          action: QuickAction.permission,
          icon: Icons.event_available_outlined,
          label: 'Demander une permission',
          subtitle: 'Sortie ou mission',
          tint: (c) => c.info,
          visible: caps.permissionRequests,
        ),
      ]),
      _Section('Objectifs', [
        _ActionSpec(
          action: QuickAction.objectives,
          icon: Icons.flag_outlined,
          label: 'Proposer des objectifs',
          subtitle: 'Semaine en cours',
          tint: (c) => c.brand,
          visible: caps.weeklyObjectives,
        ),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    final sections = _sections(colors)
        .map((s) => _Section(s.title, s.actions.where((a) => a.visible).toList()))
        .where((s) => s.actions.isNotEmpty)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        Tokens.space16,
        0,
        Tokens.space16,
        Tokens.space24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Tokens.space8),
            child: Text('Actions rapides', style: theme.titleLarge),
          ),
          for (final section in sections) ...[
            const SizedBox(height: Tokens.space16),
            Text(
              section.title,
              style: theme.labelMedium?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space8),
            for (final spec in section.actions)
              _ActionRow(spec: spec, tint: spec.tint(colors)),
          ],
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.spec, required this.tint});

  final _ActionSpec spec;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: Tokens.space8),
      child: Material(
        color: colors.background,
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
          onTap: () => Navigator.of(context).pop(spec.action),
          child: Padding(
            padding: const EdgeInsets.all(Tokens.space12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: tint.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(Tokens.radiusMd),
                  ),
                  child: Icon(spec.icon, color: tint, size: 22),
                ),
                const SizedBox(width: Tokens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        spec.label,
                        style: theme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        spec.subtitle,
                        style: theme.bodySmall?.copyWith(color: colors.textMuted),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: colors.textMuted, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
