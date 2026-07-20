import 'package:flutter/widgets.dart';

/// Découpe un volet diagonal qui balaie l'écran de la droite vers la gauche.
///
/// À [progress] = 0 rien n'est visible, à 1 tout l'écran l'est. L'inclinaison
/// vaut 30 % de la hauteur : le bord haut devance le bord bas, ce qui donne au
/// balayage sa diagonale plutôt qu'un front vertical.
class DiagonalClipper extends CustomClipper<Path> {
  const DiagonalClipper(this.progress);

  final double progress;

  /// Décalage horizontal entre le haut et le bas du front, en fraction de la
  /// hauteur. Plus la valeur est grande, plus la diagonale est couchée.
  static const _slantRatio = 0.3;

  @override
  Path getClip(Size size) {
    if (progress <= 0) return Path();

    if (progress >= 1) {
      return Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    final slant = size.height * _slantRatio;
    // Le front doit parcourir la largeur PLUS l'inclinaison, sinon le coin bas
    // gauche resterait découvert en fin de course.
    final travelled = (size.width + slant) * progress;

    final topX = size.width - travelled + slant;
    final bottomX = size.width - travelled;

    return Path()
      ..moveTo(topX.clamp(0.0, size.width), 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(bottomX.clamp(0.0, size.width), size.height)
      ..close();
  }

  @override
  bool shouldReclip(DiagonalClipper oldClipper) =>
      oldClipper.progress != progress;
}
