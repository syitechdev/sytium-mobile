import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/requests/application/requests_providers.dart';
import 'package:sytium_mobile/features/requests/domain/request_models.dart';
import 'package:sytium_mobile/features/requests/presentation/widgets/date_time_field.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

const _kFirstYearOffset = 1;
const _kLastYearOffset = 2;

/// Opens the permission/mission modal. Creates a draft then submits it in one
/// flow (Assumption 2). Returns `true` once submitted (statut en_attente_n1).
Future<bool?> showPermissionFormSheet(BuildContext context) {
  return showAppSheet<bool>(
    context,
    builder: (_) => const _PermissionFormSheet(),
  );
}

class _PermissionFormSheet extends ConsumerStatefulWidget {
  const _PermissionFormSheet();

  @override
  ConsumerState<_PermissionFormSheet> createState() =>
      _PermissionFormSheetState();
}

class _PermissionFormSheetState extends ConsumerState<_PermissionFormSheet> {
  PermissionType _type = PermissionType.permission;
  late final TextEditingController _motif;
  late final TextEditingController _destination;
  late final TextEditingController _transport;
  late final TextEditingController _budget;
  late DateTime _debut;
  late DateTime _fin;
  TimeOfDay? _heureDebut;
  TimeOfDay? _heureFin;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _debut = DateTime(now.year, now.month, now.day);
    _fin = _debut;
    _motif = TextEditingController();
    _destination = TextEditingController();
    _transport = TextEditingController();
    _budget = TextEditingController();
  }

  @override
  void dispose() {
    _motif.dispose();
    _destination.dispose();
    _transport.dispose();
    _budget.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isStart) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _debut : _fin,
      firstDate: DateTime(now.year - _kFirstYearOffset),
      lastDate: DateTime(now.year + _kLastYearOffset),
    );
    if (!mounted) return;
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _debut = picked;
        if (_fin.isBefore(_debut)) _fin = _debut;
      } else {
        _fin = picked;
      }
    });
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime:
          (isStart ? _heureDebut : _heureFin) ??
          const TimeOfDay(hour: 8, minute: 0),
    );
    if (!mounted) return;
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _heureDebut = picked;
      } else {
        _heureFin = picked;
      }
    });
  }

  Future<void> _submit() async {
    final motif = _motif.text.trim();
    if (motif.isEmpty) {
      setState(() => _error = 'Le motif est requis.');
      return;
    }
    if (_fin.isBefore(_debut)) {
      setState(() => _error = 'La date de fin doit suivre la date de début.');
      return;
    }
    // Heures: both-or-neither, and fin > debut on the same day.
    final hasDebut = _heureDebut != null;
    final hasFin = _heureFin != null;
    if (hasDebut != hasFin) {
      setState(
        () => _error = 'Renseignez les deux heures (début et fin) ou aucune.',
      );
      return;
    }
    if (hasDebut && hasFin && !_isAfter(_heureFin!, _heureDebut!)) {
      setState(() => _error = "L'heure de fin doit suivre l'heure de début.");
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final repo = ref.read(requestsRepositoryProvider);
    final created = await repo.createPermission(
      PermissionDraft(
        type: _type,
        motif: motif,
        dateDebut: _ymd(_debut),
        dateFin: _ymd(_fin),
        destination: _destination.text.trim().isEmpty
            ? null
            : _destination.text.trim(),
        heureDebut: hasDebut ? _hm(_heureDebut!) : null,
        heureFin: hasFin ? _hm(_heureFin!) : null,
        moyenTransport: _transport.text.trim().isEmpty
            ? null
            : _transport.text.trim(),
        budgetEstime: double.tryParse(_budget.text.trim().replaceAll(' ', '')),
      ),
    );

    if (!mounted) return;

    await created.fold(
      (permission) async {
        // Immediately submit the fresh draft (Assumption 2).
        final submitted = await repo.submitPermission(permission.id);
        if (!mounted) return;
        submitted.fold(
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
      },
      (f) async => setState(() {
        _saving = false;
        _error = _message(f);
      }),
    );
  }

  String _message(Failure f) {
    if (f is RequestFailure) {
      return switch (f.code) {
        'NO_EMPLOYEE' => 'Aucun profil employé associé à votre compte.',
        'CONFLICT' => f.message ?? 'Cette demande a déjà été traitée.',
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
            Text('Nouvelle demande', style: theme.titleLarge),
            const SizedBox(height: Tokens.space16),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text('Type', style: theme.labelLarge),
                  const SizedBox(height: Tokens.space8),
                  SegmentedButton<PermissionType>(
                    segments: [
                      for (final t in PermissionType.creatable)
                        ButtonSegment(value: t, label: Text(t.label)),
                    ],
                    selected: {_type},
                    onSelectionChanged: (s) => setState(() => _type = s.first),
                  ),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(controller: _motif, label: 'Motif', maxLines: 3),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(
                    controller: _destination,
                    label: 'Destination (optionnel)',
                  ),
                  const SizedBox(height: Tokens.space12),
                  DateTimeField(
                    label: 'Du',
                    date: _debut,
                    time: _heureDebut,
                    onPickDate: () => _pickDate(true),
                    onPickTime: () => _pickTime(true),
                    onClearTime: () => setState(() => _heureDebut = null),
                  ),
                  const SizedBox(height: Tokens.space12),
                  DateTimeField(
                    label: 'Au',
                    date: _fin,
                    time: _heureFin,
                    onPickDate: () => _pickDate(false),
                    onPickTime: () => _pickTime(false),
                    onClearTime: () => setState(() => _heureFin = null),
                  ),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(
                    controller: _transport,
                    label: 'Moyen de transport (optionnel)',
                  ),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(
                    controller: _budget,
                    label: 'Budget estimé FCFA (optionnel)',
                    keyboardType: TextInputType.number,
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
            AppPrimaryButton(
              label: 'Envoyer la demande',
              onPressed: _submit,
              isLoading: _saving,
            ),
          ],
        ),
      ),
    );
  }
}

bool _isAfter(TimeOfDay a, TimeOfDay b) =>
    a.hour * 60 + a.minute > b.hour * 60 + b.minute;

String _ymd(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

String _hm(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
