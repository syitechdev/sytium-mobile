import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';
import 'package:url_launcher/url_launcher.dart';

/// Professional legal mention shown on the login screen: access is reserved to
/// client companies and their authorized users, subject to the CGU.
class LegalFooter extends StatefulWidget {
  const LegalFooter({super.key});

  @override
  State<LegalFooter> createState() => _LegalFooterState();
}

class _LegalFooterState extends State<LegalFooter> {
  static final Uri _cguUri = Uri.parse('https://sytium.tech/sytium/legal#cgu');
  late final TapGestureRecognizer _cguTap;

  @override
  void initState() {
    super.initState();
    _cguTap = TapGestureRecognizer()..onTap = _openCgu;
  }

  @override
  void dispose() {
    _cguTap.dispose();
    super.dispose();
  }

  Future<void> _openCgu() async {
    try {
      await launchUrl(_cguUri, mode: LaunchMode.externalApplication);
    } on Exception {
      // Best-effort: opening the external browser is non-critical.
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final base = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: colors.textMuted, height: 1.45);

    return Column(
      children: [
        Text.rich(
          TextSpan(
            style: base,
            children: [
              const TextSpan(
                text:
                    'L’accès à Sytium ERP est réservé aux entreprises '
                    'Clientes et à leurs collaborateurs autorisés. En vous '
                    'connectant, vous acceptez les ',
              ),
              TextSpan(
                text: 'Conditions Générales d’Utilisation',
                style: base?.copyWith(
                  color: colors.brand,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: _cguTap,
              ),
              const TextSpan(text: '.'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Tokens.space12),
        Text('© Syitech Group', textAlign: TextAlign.center, style: base),
      ],
    );
  }
}
