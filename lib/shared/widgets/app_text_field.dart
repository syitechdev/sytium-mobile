import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Branded text field. Decoration comes from `inputDecorationTheme`.
class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.label,
    this.hint,
    this.obscure = false,
    this.keyboardType,
    this.maxLines = 1,
    this.errorText,
    this.prefixIcon,
    this.suffix,
    this.textInputAction,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool obscure;
  final TextInputType? keyboardType;
  /// Number of lines for the field. Pass `null` for unlimited (multiline).
  final int? maxLines;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: Tokens.space8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
