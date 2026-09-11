import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Bouton d'accès au lecteur, commun aux fiches facture, proforma et document.
class OpenDocumentButton extends StatelessWidget {
  const OpenDocumentButton({
    required this.onPressed,
    this.label = 'Voir le PDF',
    this.icon = Icons.picture_as_pdf_outlined,
    super.key,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(Tokens.space48),
      ),
    );
  }
}
