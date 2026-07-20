import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/cash/presentation/cash_movement_sheet.dart';
import 'package:sytium_mobile/features/invoicing/presentation/sales_doc_form_sheet.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// « Raccourci décisionnel » — role-gated action shortcuts on the Accueil:
/// Facture (proforma/invoice), Caisse (movement), Pointage GPS. Each CTA is
/// shown only to a habilitated profile; [onPointer] switches to the Pointer tab.
class RaccourciDecisionnel extends ConsumerWidget {
  const RaccourciDecisionnel({required this.onPointer, super.key});

  final VoidCallback onPointer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final auth = ref.watch(authControllerProvider).valueOrNull;
    final caps = auth is Authenticated
        ? auth.session.capabilities
        : const MobileCapabilities.baseline();

    final canInvoice = caps.financeWrite || caps.commercial;
    final canCash = caps.financeWrite;

    final ctas = <Widget>[
      if (canInvoice)
        _Cta(
          icon: Icons.request_quote_outlined,
          label: 'Facture',
          subtitle: 'Proforma & vente',
          color: colors.ai,
          onTap: () => showSalesDocSheet(context),
        ),
      if (canCash)
        _Cta(
          icon: Icons.point_of_sale_outlined,
          label: 'Caisse',
          subtitle: 'Encaisser / décaisser',
          color: colors.brand,
          onTap: () => showCashMovementSheet(context),
        ),
      _Cta(
        icon: Icons.qr_code_scanner,
        label: 'Pointage GPS',
        subtitle: 'Check-in équipe',
        color: colors.navy,
        onTap: onPointer,
      ),
    ];

    if (ctas.length == 1) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Raccourci décisionnel', style: theme.titleSmall),
        const SizedBox(height: Tokens.space12),
        Row(
          children: [
            for (var i = 0; i < ctas.length; i++) ...[
              if (i > 0) const SizedBox(width: Tokens.space12),
              Expanded(child: ctas[i]),
            ],
          ],
        ),
      ],
    );
  }
}

class _Cta extends StatelessWidget {
  const _Cta({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    return Material(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(Tokens.radiusMd),
      child: InkWell(
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(Tokens.space12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Tokens.radiusMd),
            border: Border.all(color: color.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: Tokens.space8),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: Tokens.space4),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.bodySmall?.copyWith(
                  color: colors.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
