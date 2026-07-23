import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kAvatarRadius = 26.0;

/// En-tête de l'accueil : la date du jour, une salutation en grand, l'avatar à
/// droite. Posé à plat sur le fond, sans carte — c'est un titre de page, pas un
/// contenu à encadrer.
///
/// L'avatar mène à l'onglet Explorer, qui porte les modules et les paramètres —
/// le raccourci attendu vers « mon espace » depuis l'accueil.
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    required this.user,
    required this.onAvatarTap,
    super.key,
  });

  final AuthUser? user;
  final VoidCallback onAvatarTap;

  /// Prénom seul : « Alexis Kouakou » devient « Alexis ». Une salutation
  /// s'adresse à la personne, pas à son identité administrative.
  String get _firstName {
    final name = user?.name.trim() ?? '';
    if (name.isEmpty) return '';
    return name.split(RegExp(r'\s+')).first;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final firstName = _firstName;

    // « Jeudi 23 juillet », première lettre en capitale.
    final rawDate = DateFormat('EEEE d MMMM', 'fr_FR').format(DateTime.now());
    final date = rawDate.isEmpty
        ? rawDate
        : '${rawDate[0].toUpperCase()}${rawDate.substring(1)}';

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: theme.bodyMedium?.copyWith(color: colors.textMuted),
              ),
              const SizedBox(height: Tokens.space4),
              Text(
                firstName.isEmpty ? 'Bonjour 👋' : 'Bonjour, $firstName 👋',
                style: theme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: Tokens.space16),
        Semantics(
          button: true,
          label: 'Ouvrir Explorer',
          child: InkWell(
            onTap: onAvatarTap,
            customBorder: const CircleBorder(),
            child: AppAvatar(
              name: user?.name ?? '',
              imageUrl: user?.photoUrl,
              radius: _kAvatarRadius,
            ),
          ),
        ),
      ],
    );
  }
}
