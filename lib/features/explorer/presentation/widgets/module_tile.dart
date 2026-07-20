import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kModuleIconSize = 28.0;

/// Maps a backend icon name to an [IconData]. Unknown names fall back to a
/// generic module icon (never crashes on a new backend value).
IconData moduleIcon(String? name) => switch (name) {
  'flag' => Icons.flag_outlined,
  'objectives' => Icons.flag_outlined,
  'calendar' => Icons.event_outlined,
  'leave' => Icons.beach_access_outlined,
  'permission' => Icons.assignment_outlined,
  'profile' => Icons.person_outline,
  'employee_space' => Icons.badge_outlined,
  'checks' => Icons.checklist_rtl_outlined,
  'trending_up' => Icons.trending_up,
  'wallet' => Icons.account_balance_wallet_outlined,
  _ => Icons.widgets_outlined,
};

class ModuleTile extends StatelessWidget {
  const ModuleTile({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      borderRadius: BorderRadius.circular(Tokens.radiusMd),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.card,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(Tokens.radiusMd),
        ),
        padding: const EdgeInsets.all(Tokens.space16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colors.brand, size: _kModuleIconSize),
            const SizedBox(height: Tokens.space8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
