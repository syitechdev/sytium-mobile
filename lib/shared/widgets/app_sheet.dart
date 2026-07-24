import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Part de la hauteur d'écran qu'une feuille ne dépasse jamais.
///
/// Une feuille `isScrollControlled` sans contrainte grimpe jusque sous la barre
/// d'état : elle se lit alors comme une page plein écran, sans zone de barrière
/// à toucher pour revenir. Ce plafond garantit qu'il reste toujours une bande
/// visible au-dessus.
const _kMaxHeightFactor = 0.88;

const _kHandleWidth = 40.0;
const _kHandleHeight = 4.0;
const _kBarHeight = 44.0;

/// Ouvre une feuille modale avec le cadre commun de l'application.
///
/// Garantit sur toutes les feuilles : une poignée visible, un bouton de
/// fermeture explicite, un plafond de hauteur, et le respect des encoches.
/// Le contenu passé garde sa propre mise en page — il n'a plus besoin de
/// dessiner sa poignée ni de gérer `useSafeArea`.
Future<T?> showAppSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,

  /// Passe à false pour une action qui exige un choix explicite. Le bouton de
  /// fermeture reste affiché : aucune feuille ne doit pouvoir piéger l'utilisateur.
  bool isDismissible = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * _kMaxHeightFactor,
    ),
    builder: (context) => AppSheet(child: builder(context)),
  );
}

/// Cadre visuel d'une feuille : barre de préhension + contenu défilant.
class AppSheet extends StatelessWidget {
  const AppSheet({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Réserve la hauteur du clavier : sans ça, une feuille avec champ de saisie
    // (recherche, ajout de membres) voit le bas de sa liste passer SOUS le
    // clavier, hors d'atteinte. La feuille étant ancrée en bas, ce padding
    // remonte le contenu au-dessus du clavier ; la liste `Flexible` se réduit
    // pour rester défilable dans l'espace visible restant.
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _SheetBar(),
          // Flexible et non Expanded : une feuille courte garde sa hauteur
          // naturelle au lieu d'être étirée jusqu'au plafond.
          Flexible(child: child),
        ],
      ),
    );
  }
}

/// Poignée centrée et bouton de fermeture.
///
/// Les deux coexistent volontairement : la poignée indique que la feuille se
/// tire vers le bas, le bouton reste la sortie évidente quand le contenu est
/// long et que la barrière n'est plus atteignable au pouce.
class _SheetBar extends StatelessWidget {
  const _SheetBar();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      height: _kBarHeight,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: _kHandleWidth,
              height: _kHandleHeight,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(Tokens.radiusPill),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: Tokens.space4),
              child: IconButton(
                icon: const Icon(Icons.close),
                color: colors.textMuted,
                tooltip: 'Fermer',
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
