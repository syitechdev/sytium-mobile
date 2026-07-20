import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/shared/widgets/app_avatar.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kAvatarRadius = 28.0;

/// En-tête de l'accueil : salutation, nom et poste à gauche, avatar à droite.
///
/// L'avatar mène à l'onglet Explorer, qui porte les modules et les paramètres —
/// c'est le raccourci attendu vers « mon espace » depuis l'accueil.
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    required this.user,
    required this.onAvatarTap,
    super.key,
  });

  final AuthUser? user;
  final VoidCallback onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final name = user?.name ?? '';
    // Seul le poste est affiché : le département faisait une seconde ligne
    // tronquée sans apporter d'information utile ici.
    final poste = user?.poste;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bonjour,',
                    style: theme.bodySmall?.copyWith(color: colors.textMuted),
                  ),
                  Text(
                    name,
                    style: theme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (poste != null && poste.isNotEmpty) ...[
                    const SizedBox(height: Tokens.space4),
                    Text(
                      poste,
                      style: theme.bodySmall?.copyWith(color: colors.brand),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
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
                  name: name,
                  imageUrl: user?.photoUrl,
                  radius: _kAvatarRadius,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
