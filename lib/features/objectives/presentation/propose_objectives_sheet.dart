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

const _kMaxObjectives = 20;

/// Opens the propose/edit modal for [week]. Returns `true` if a write
/// succeeded (the caller invalidates the list), else `null`/`false`.
Future<bool?> showProposeObjectivesSheet(
  BuildContext context, {
  required WeeklyObjective week,
}) {
  return showAppSheet<bool>(context, builder: (_) => _ProposeSheet(week: week));
}

class _ProposeSheet extends ConsumerStatefulWidget {
  const _ProposeSheet({required this.week});
  final WeeklyObjective week;

  @override
  ConsumerState<_ProposeSheet> createState() => _ProposeSheetState();
}

class _ProposeSheetState extends ConsumerState<_ProposeSheet> {
  late final List<TextEditingController> _lines;
  late final TextEditingController _contexte;
  late final TextEditingController _remarque;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final existing = widget.week.objectifs;
    _lines = existing.isEmpty
        ? [TextEditingController()]
        : existing.map((o) => TextEditingController(text: o.activite)).toList();
    _contexte = TextEditingController(text: widget.week.contexte ?? '');
    _remarque = TextEditingController(text: widget.week.remarqueSemaine ?? '');
  }

  @override
  void dispose() {
    for (final c in _lines) {
      c.dispose();
    }
    _contexte.dispose();
    _remarque.dispose();
    super.dispose();
  }

  void _addLine() {
    if (_lines.length >= _kMaxObjectives) return;
    setState(() => _lines.add(TextEditingController()));
  }

  void _removeLine(int i) {
    setState(() {
      _lines.removeAt(i).dispose();
      if (_lines.isEmpty) _lines.add(TextEditingController());
    });
  }

  Future<void> _submit() async {
    final objectifs = _lines
        .map((c) => c.text.trim())
        .where((t) => t.isNotEmpty)
        .map((t) => ObjectiveLine(activite: t))
        .toList();

    if (objectifs.isEmpty) {
      setState(() => _error = 'Ajoutez au moins un objectif.');
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final repo = ref.read(objectivesRepositoryProvider);
    final draft = ObjectiveDraft(
      annee: widget.week.annee,
      semaine: widget.week.semaine,
      dateDebut: widget.week.dateDebut ?? '',
      dateFin: widget.week.dateFin ?? '',
      objectifs: objectifs,
      contexte: _contexte.text.trim().isEmpty ? null : _contexte.text.trim(),
      remarqueSemaine: _remarque.text.trim().isEmpty
          ? null
          : _remarque.text.trim(),
    );

    // No id → create (POST); existing id → update (PATCH).
    final result = widget.week.id.isEmpty
        ? await repo.create(draft)
        : await repo.update(widget.week.id, draft);

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
        'OBJECTIVE_LOCKED' =>
          'Cette semaine est verrouillée : les objectifs ont déjà été validés.',
        'NO_EMPLOYEE' => 'Aucun profil employé associé à votre compte.',
        _ => f.message ?? 'Enregistrement impossible.',
      };
    }
    return f.message ?? 'Enregistrement impossible.';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final atMax = _lines.length >= _kMaxObjectives;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

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
            Text(
              widget.week.objectifs.isEmpty
                  ? 'Proposer mes objectifs'
                  : 'Modifier mes objectifs',
              style: theme.titleLarge,
            ),
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
                  for (var i = 0; i < _lines.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: Tokens.space12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _lines[i],
                              decoration: InputDecoration(
                                hintText: 'Objectif ${i + 1}',
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _removeLine(i),
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: colors.danger,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (atMax)
                    Text(
                      'Maximum de 20 objectifs atteint.',
                      style: theme.bodySmall?.copyWith(color: colors.warning),
                    )
                  else
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _addLine,
                        icon: const Icon(Icons.add),
                        label: const Text('Ajouter un objectif'),
                      ),
                    ),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(
                    controller: _contexte,
                    label: 'Contexte (optionnel)',
                  ),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(
                    controller: _remarque,
                    label: 'Remarque de la semaine (optionnel)',
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
                  : Text(
                      widget.week.objectifs.isEmpty
                          ? 'Proposer'
                          : 'Enregistrer',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
