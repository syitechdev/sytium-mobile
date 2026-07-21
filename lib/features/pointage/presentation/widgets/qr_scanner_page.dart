import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Lecteur de QR du pointage — **hors du parcours actuel**.
///
/// Le pointage se valide désormais par la géolocalisation seule ; ce lecteur
/// n'est plus appelé nulle part. Il est conservé, avec le mode QR côté serveur
/// (`sytium.pointage.mode`), pour pouvoir être remis en service : le rebrancher
/// consiste à le pousser depuis l'écran de pointage et à transmettre le jeton
/// obtenu au champ `qrToken` de la requête de scan.
///
/// Retourne le contenu brut du code lu, ou null si l'utilisateur abandonne.
class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final _controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  /// Verrou : la caméra émet en rafale, sans lui la route serait dépilée
  /// plusieurs fois.
  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner le QR')),
      body: MobileScanner(
        controller: _controller,
        onDetect: (capture) {
          if (_handled) return;
          final raw = capture.barcodes
              .map((b) => b.rawValue)
              .firstWhere((v) => v != null && v.isNotEmpty, orElse: () => null);
          if (raw == null) return;
          _handled = true;
          Navigator.of(context).pop(raw);
        },
      ),
    );
  }
}
