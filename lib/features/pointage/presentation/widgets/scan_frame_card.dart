import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// **Hors du parcours actuel.** Le pointage se valide par la géolocalisation
/// seule ; cette carte au cadre QR n'est plus affichée. Conservée avec le mode
/// QR côté serveur (`sytium.pointage.mode`) pour pouvoir être remise en service.
///
/// Premium idle scan card: a framed QR illustration + the next-motif hint + CTA.
class ScanFrameCard extends StatelessWidget {
  const ScanFrameCard({
    required this.nextLabel,
    required this.onScan,
    this.disabled = false,
    super.key,
  });

  final String nextLabel;
  final VoidCallback onScan;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(Tokens.radiusLg),
                  border: Border.all(color: colors.brand, width: 2),
                ),
                child: Icon(Icons.qr_code_2, size: 120, color: colors.brand),
              ),
            ),
            const SizedBox(height: Tokens.space16),
            Text(
              'Prochain pointage',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: colors.textMuted),
            ),
            Text(nextLabel, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: Tokens.space16),
            FilledButton.icon(
              onPressed: disabled ? null : onScan,
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scanner pour pointer'),
              style: FilledButton.styleFrom(
                backgroundColor: colors.brand,
                foregroundColor: colors.onBrand,
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
