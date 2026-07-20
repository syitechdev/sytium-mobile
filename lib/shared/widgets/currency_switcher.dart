import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/app/currency/currency_controller.dart';
import 'package:sytium_mobile/core/utils/currency.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// App-bar currency switcher (XOF/EUR/USD), mirroring the web header control.
/// Persists the choice; the whole app re-renders amounts in the new currency.
class CurrencySwitcher extends ConsumerWidget {
  const CurrencySwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final current = ref.watch(currencyControllerProvider);
    return PopupMenuButton<AppCurrency>(
      tooltip: 'Devise',
      position: PopupMenuPosition.under,
      onSelected: (c) =>
          ref.read(currencyControllerProvider.notifier).setCurrency(c),
      itemBuilder: (context) => [
        for (final c in AppCurrency.values)
          PopupMenuItem(
            value: c,
            child: Row(
              children: [
                SizedBox(
                  width: 44,
                  child: Text(
                    c.code,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    c.label,
                    style: TextStyle(color: colors.textMuted),
                  ),
                ),
                if (c == current)
                  Icon(Icons.check, size: 16, color: colors.brand),
              ],
            ),
          ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Tokens.space8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.paid_outlined, size: 18, color: colors.textMuted),
            const SizedBox(width: Tokens.space4),
            Text(
              current.code,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Icon(Icons.arrow_drop_down, size: 18, color: colors.textMuted),
          ],
        ),
      ),
    );
  }
}
