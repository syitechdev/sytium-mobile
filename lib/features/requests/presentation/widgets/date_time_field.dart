import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Champ combiné date + heure d'une demande de congé ou de permission.
///
/// La date se saisit à gauche, l'heure — optionnelle — à droite dans le même
/// champ. L'heure reste facultative : tant qu'elle n'est pas renseignée, la
/// demande vaut pour la journée entière. Une fois posée, une croix permet de
/// la retirer.
class DateTimeField extends StatelessWidget {
  const DateTimeField({
    required this.label,
    required this.date,
    required this.time,
    required this.onPickDate,
    required this.onPickTime,
    required this.onClearTime,
    super.key,
  });

  final String label;
  final DateTime date;
  final TimeOfDay? time;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;
  final VoidCallback onClearTime;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.labelLarge),
        const SizedBox(height: Tokens.space8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(Tokens.radiusMd),
          ),
          child: Row(
            children: [
              // Partie date.
              Expanded(
                child: InkWell(
                  onTap: onPickDate,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(Tokens.radiusMd),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Tokens.space16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                          color: colors.textMuted,
                        ),
                        const SizedBox(width: Tokens.space12),
                        Text(_dmy(date)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(width: 1, height: 28, color: colors.border),
              // Partie heure : « Ajouter » tant qu'aucune n'est posée, sinon
              // l'heure avec une croix pour la retirer.
              InkWell(
                onTap: onPickTime,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(Tokens.radiusMd),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Tokens.space12,
                    vertical: Tokens.space16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule_outlined,
                        size: 18,
                        color: time == null ? colors.textMuted : colors.brand,
                      ),
                      const SizedBox(width: Tokens.space8),
                      Text(
                        time == null ? 'Ajouter' : _hm(time!),
                        style: TextStyle(
                          color: time == null ? colors.textMuted : colors.brand,
                          fontWeight: time == null
                              ? FontWeight.w400
                              : FontWeight.w600,
                        ),
                      ),
                      if (time != null)
                        Padding(
                          padding: const EdgeInsets.only(left: Tokens.space4),
                          child: InkWell(
                            onTap: onClearTime,
                            customBorder: const CircleBorder(),
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: colors.textMuted,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// `JJ/MM/AAAA` d'une date. Formaté à la main pour ne pas dépendre de l'init
/// locale d'intl : le formulaire reste montable sans initializeDateFormatting.
String _dmy(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/'
    '${d.month.toString().padLeft(2, '0')}/'
    '${d.year.toString().padLeft(4, '0')}';

/// `HH:mm` d'une heure.
String _hm(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
