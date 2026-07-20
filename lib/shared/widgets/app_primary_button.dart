import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';

/// Brand CTA. Style comes from `filledButtonTheme` (tokens) — no hardcoding.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: context.colors.onBrand,
              ),
            )
          : Text(label),
    );
  }
}
