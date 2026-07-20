import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _labels = {
  'entree': 'Arrivée',
  'pause_debut': 'Début pause',
  'pause_fin': 'Fin pause',
  'sortie': 'Départ',
};

class HistoryTile extends StatelessWidget {
  const HistoryTile({required this.entry, super.key});
  final PointageHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: Tokens.space8),
      leading: CircleAvatar(
        backgroundColor: colors.brand.withValues(alpha: 0.12),
        child: Icon(Icons.schedule, color: colors.brand, size: 20),
      ),
      title: Text(_labels[entry.type] ?? entry.type),
      subtitle: Text('${entry.dateLabel ?? ''} · ${entry.timeLabel ?? ''}'),
      trailing: entry.outOfZone
          ? Icon(Icons.location_off, color: colors.danger, size: 18)
          : Icon(Icons.check_circle, color: colors.success, size: 18),
    );
  }
}
