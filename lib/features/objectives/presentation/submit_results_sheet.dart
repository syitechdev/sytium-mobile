import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/objectives/application/objectives_providers.dart';
import 'package:sytium_mobile/features/objectives/domain/objective_models.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kTauxDivisions = 20; // 0..100 in steps of 5
const _kMaxAutoNote = 5;

/// Opens the submit-results modal for [week]. Returns `true` on success.
Future<bool?> showSubmitResultsSheet(
  BuildContext context, {
  required WeeklyObjective week,
}) {
  return showAppSheet<bool>(context, builder: (_) => _ResultsSheet(week: week));
}

class _ResultsSheet extends ConsumerStatefulWidget {
  const _ResultsSheet({required this.week});
  final WeeklyObjective week;

  @override
  ConsumerState<_ResultsSheet> createState() => _ResultsSheetState();
}

class _ResultsSheetState extends ConsumerState<_ResultsSheet> {
  late final List<TextEditingController> _realises;
  late final TextEditingController _freins;
  late final TextEditingController _soutien;
  late final TextEditingController _focus;
  double _taux = 0;
  int? _autoNote;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _realises = widget.week.objectifs
        .map((o) => TextEditingController(text: o.realiseNb?.toString() ?? ''))
        .toList();
    _freins = TextEditingController();
    _soutien = TextEditingController();
    _focus = TextEditingController();
  }

  @override
  void dispose() {
    for (final c in _realises) {
      c.dispose();
    }
    _freins.dispose();
    _soutien.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _saving = true;
      _error = null;
    });

    final resultats = <ObjectiveLine>[
      for (var i = 0; i < widget.week.objectifs.length; i++)
        widget.week.objectifs[i].copyWith(
          realiseNb: int.tryParse(_realises[i].text.trim()),
        ),
    ];

    final draft = ResultsDraft(
      resultats: resultats,
      tauxRealisation: _taux,
      freins: _freins.text.trim().isEmpty ? null : _freins.text.trim(),
      soutienRequis: _soutien.text.trim().isEmpty ? null : _soutien.text.trim(),
      focusSemaineSuivante: _focus.text.trim().isEmpty
          ? null
          : _focus.text.trim(),
      autoNote: _autoNote,
    );

    final result = await ref
        .read(objectivesRepositoryProvider)
        .submitResults(widget.week.id, draft);

    if (!mounted) return;

    result.fold(
      (_) {
        if (mounted) setState(() => _saving = false);
        HapticFeedback.lightImpact();
        Navigator.of(context).pop(true);
      },
      (f) => setState(() {
        _saving = false;
        _error = _message(f);
      }),
    );
  }

  String _message(Failure f) {
    if (f is ObjectiveFailure) {
      return switch (f.code) {
        'OBJECTIVE_LOCKED' => 'Cette semaine est verrouillée.',
        'NO_EMPLOYEE' => 'Aucun profil employé associé à votre compte.',
        _ => f.message ?? 'Envoi impossible.',
      };
    }
    return f.message ?? 'Envoi impossible.';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final objectifs = widget.week.objectifs;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: Tokens.space24,
          right: Tokens.space24,
          top: Tokens.space24,
          bottom: Tokens.space24 + bottomInset,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Soumettre les résultats', style: theme.titleLarge),
            const SizedBox(height: Tokens.space4),
            Text(
              'Semaine ${widget.week.semaine} · ${widget.week.annee}',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space16),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (objectifs.isEmpty)
                    Text(
                      'Aucun objectif à évaluer pour cette semaine.',
                      style: theme.bodySmall?.copyWith(color: colors.textMuted),
                    )
                  else
                    for (var i = 0; i < objectifs.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: Tokens.space12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                objectifs[i].activite,
                                style: theme.bodyMedium,
                              ),
                            ),
                            const SizedBox(width: Tokens.space12),
                            SizedBox(
                              width: 72,
                              child: TextField(
                                controller: _realises[i],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Réalisé',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  const SizedBox(height: Tokens.space8),
                  Text(
                    'Taux de réalisation : ${_taux.round()} %',
                    style: theme.titleSmall,
                  ),
                  Slider(
                    value: _taux,
                    max: 100,
                    divisions: _kTauxDivisions,
                    label: '${_taux.round()} %',
                    activeColor: colors.brand,
                    onChanged: (v) => setState(() => _taux = v),
                  ),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(
                    controller: _freins,
                    label: 'Freins rencontrés (optionnel)',
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(
                    controller: _soutien,
                    label: 'Soutien requis (optionnel)',
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(
                    controller: _focus,
                    label: 'Focus semaine suivante (optionnel)',
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: Tokens.space16),
                  Text('Auto-évaluation', style: theme.titleSmall),
                  const SizedBox(height: Tokens.space8),
                  Row(
                    children: [
                      for (var n = 1; n <= _kMaxAutoNote; n++)
                        Padding(
                          padding: const EdgeInsets.only(right: Tokens.space8),
                          child: ChoiceChip(
                            label: Text('$n'),
                            selected: _autoNote == n,
                            selectedColor: colors.brand.withValues(alpha: 0.16),
                            onSelected: (_) => setState(() => _autoNote = n),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: Tokens.space12),
              Text(
                _error!,
                style: theme.bodySmall?.copyWith(color: colors.danger),
              ),
            ],
            const SizedBox(height: Tokens.space16),
            FilledButton(
              onPressed: _saving ? null : _submit,
              style: FilledButton.styleFrom(
                backgroundColor: colors.brand,
                foregroundColor: colors.onBrand,
                minimumSize: const Size.fromHeight(52),
              ),
              child: _saving
                  ? SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: colors.onBrand,
                      ),
                    )
                  : const Text('Envoyer les résultats'),
            ),
          ],
        ),
      ),
    );
  }
}
