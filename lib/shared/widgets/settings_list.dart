import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Taille de la tuile d'icone en tete de ligne.
const _kLeadingSize = 40.0;
const _kLeadingIconSize = 20.0;

/// Espacement des lettres du titre de section, en capitales.
const _kSectionLetterSpacing = 1.2;

/// Une section de reglages : titre en capitales, puis une carte qui porte des
/// lignes separees par un filet. Forme de la page Profil (Explorer).
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.title,
    required this.children,
    this.footer,
    super.key,
  });

  final String title;
  final List<Widget> children;

  /// Precision sous la carte (ce qui se fait ailleurs, par exemple).
  final String? footer;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: Tokens.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: Tokens.space4,
              bottom: Tokens.space8,
            ),
            child: Text(
              title.toUpperCase(),
              style: theme.labelSmall?.copyWith(
                color: colors.textMuted,
                fontWeight: FontWeight.w600,
                letterSpacing: _kSectionLetterSpacing,
              ),
            ),
          ),
          // Material et non Container decore : l'effet d'appui des lignes doit
          // rester visible sur le fond de la carte.
          Material(
            color: colors.card,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Tokens.radiusLg),
              side: BorderSide(color: colors.border),
            ),
            child: Column(
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  children[i],
                  if (i < children.length - 1)
                    Divider(
                      height: 1,
                      indent:
                          Tokens.space16 + _kLeadingSize + Tokens.space12,
                      color: colors.border,
                    ),
                ],
              ],
            ),
          ),
          if (footer != null) ...[
            const SizedBox(height: Tokens.space8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Tokens.space4),
              child: Text(
                footer!,
                style: theme.bodySmall?.copyWith(color: colors.textMuted),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Une ligne de reglage : tuile d'icone teintee, titre, sous-titre, et a
/// droite soit un controle, soit un chevron si la ligne ouvre un ecran.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.accent,
    this.titleColor,
    this.subtitleColor,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  /// Controle a droite (interrupteur, choix). A defaut, un chevron s'affiche
  /// si la ligne est touchable.
  final Widget? trailing;
  final VoidCallback? onTap;

  /// Couleur de l'icone et de sa tuile. Defaut : la couleur de marque.
  final Color? accent;
  final Color? titleColor;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final teinte = accent ?? colors.brand;
    final droite = trailing;
    final dessous = subtitle;

    return MergeSemantics(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Tokens.space16,
            vertical: Tokens.space12,
          ),
          child: Row(
            children: [
              Container(
                width: _kLeadingSize,
                height: _kLeadingSize,
                decoration: BoxDecoration(
                  color: teinte.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Tokens.radiusMd),
                ),
                child: Icon(icon, size: _kLeadingIconSize, color: teinte),
              ),
              const SizedBox(width: Tokens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                    if (dessous != null && dessous.isNotEmpty)
                      Text(
                        dessous,
                        style: theme.bodySmall?.copyWith(
                          color: subtitleColor ?? colors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
              if (droite != null)
                droite
              else if (onTap != null)
                Icon(Icons.chevron_right, color: colors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ligne de texte simple dans une section : etat vide, precision.
class SettingsMessageRow extends StatelessWidget {
  const SettingsMessageRow(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Tokens.space16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: context.colors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
