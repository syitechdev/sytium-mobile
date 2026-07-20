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

/// Opens the leave-deposit modal. Returns `true` if a leave was created.
Future<bool?> showLeaveFormSheet(BuildContext context) {
  return showAppSheet<bool>(context, builder: (_) => const _LeaveFormSheet());
}

class _LeaveFormSheet extends ConsumerStatefulWidget {
  const _LeaveFormSheet();

  @override
  ConsumerState<_LeaveFormSheet> createState() => _LeaveFormSheetState();
}

class _LeaveFormSheetState extends ConsumerState<_LeaveFormSheet> {
  LeaveType _type = LeaveType.congePaye;
  late DateTime _debut;
  late DateTime _fin;
  TimeOfDay? _heureDebut;
  TimeOfDay? _heureFin;
  late final TextEditingController _motif;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _debut = DateTime(now.year, now.month, now.day);
    _fin = _debut;
    _motif = TextEditingController();
  }

  @override
  void dispose() {
    _motif.dispose();
    super.dispose();
  }

  Future<void> _pickDebut() async {
    final picked = await _pickDate(_debut);
    if (!mounted) return;
    if (picked == null) return;
    setState(() {
      _debut = picked;
      if (_fin.isBefore(_debut)) _fin = _debut;
    });
  }

  Future<void> _pickFin() async {
    final picked = await _pickDate(_fin);
    if (!mounted) return;
    if (picked == null) return;
    setState(() => _fin = picked);
  }

  Future<DateTime?> _pickDate(DateTime initial) {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - _kFirstYearOffset),
      lastDate: DateTime(now.year + _kLastYearOffset),
    );
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime:
          (isStart ? _heureDebut : _heureFin) ??
          const TimeOfDay(hour: 8, minute: 0),
    );
    if (!mounted || picked == null) return;
    setState(() {
      if (isStart) {
        _heureDebut = picked;
      } else {
        _heureFin = picked;
      }
    });
  }

  Future<void> _submit() async {
    if (_fin.isBefore(_debut)) {
      setState(() => _error = 'La date de fin doit suivre la date de début.');
      return;
    }
    // Heures : tout ou rien, et fin après début (le backend applique la même
    // règle). Elles restent optionnelles : sans heure, congé pleine journée.
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

    final result = await ref
        .read(requestsRepositoryProvider)
        .createLeave(
          LeaveDraft(
            type: _type,
            dateDebut: _ymd(_debut),
            dateFin: _ymd(_fin),
            heureDebut: hasDebut ? _hm(_heureDebut!) : null,
            heureFin: hasFin ? _hm(_heureFin!) : null,
            motif: _motif.text.trim().isEmpty ? null : _motif.text.trim(),
          ),
        );

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
    if (f is RequestFailure && f.code == 'NO_EMPLOYEE') {
      return 'Aucun profil employé associé à votre compte.';
    }
    return f.message ?? 'Enregistrement impossible.';
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
            Text('Déposer un congé', style: theme.titleLarge),
            const SizedBox(height: Tokens.space16),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text('Type', style: theme.labelLarge),
                  const SizedBox(height: Tokens.space8),
                  DropdownButtonFormField<LeaveType>(
                    initialValue: _type,
                    items: [
                      for (final t in LeaveType.creatable)
                        DropdownMenuItem(value: t, child: Text(t.label)),
                    ],
                    onChanged: (t) => setState(() => _type = t ?? _type),
                  ),
                  const SizedBox(height: Tokens.space12),
                  DateTimeField(
                    label: 'Du',
                    date: _debut,
                    time: _heureDebut,
                    onPickDate: _pickDebut,
                    onPickTime: () => _pickTime(true),
                    onClearTime: () => setState(() => _heureDebut = null),
                  ),
                  const SizedBox(height: Tokens.space12),
                  DateTimeField(
                    label: 'Au',
                    date: _fin,
                    time: _heureFin,
                    onPickDate: _pickFin,
                    onPickTime: () => _pickTime(false),
                    onClearTime: () => setState(() => _heureFin = null),
                  ),
                  const SizedBox(height: Tokens.space12),
                  AppTextField(
                    controller: _motif,
                    label: 'Motif (optionnel)',
                    maxLines: 3,
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
              label: 'Déposer',
              onPressed: _submit,
              isLoading: _saving,
            ),
          ],
        ),
      ),
    );
  }
}

/// `YYYY-MM-DD` for a date.
String _ymd(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

/// `HH:mm` for a time.
String _hm(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

bool _isAfter(TimeOfDay a, TimeOfDay b) =>
    a.hour * 60 + a.minute > b.hour * 60 + b.minute;
