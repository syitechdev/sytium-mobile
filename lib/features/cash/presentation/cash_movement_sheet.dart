import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/upload/upload_providers.dart';
import 'package:sytium_mobile/core/upload/uploaded_file.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/cash/application/cash_providers.dart';
import 'package:sytium_mobile/features/cash/domain/beneficiary.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';
import 'package:sytium_mobile/features/finance/application/finance_providers.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/shared/widgets/attachment_field.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/shared/widgets/search_picker_sheet.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Opens the « Nouveau mouvement de caisse » sheet. Resolves to `true` when a
/// movement was recorded, so the caller can refresh treasury data.
Future<bool?> showCashMovementSheet(BuildContext context) {
  return showAppSheet<bool>(
    context,
    builder: (_) => const _CashMovementSheet(),
  );
}

class _CashMovementSheet extends ConsumerStatefulWidget {
  const _CashMovementSheet();

  @override
  ConsumerState<_CashMovementSheet> createState() => _CashMovementSheetState();
}

class _CashMovementSheetState extends ConsumerState<_CashMovementSheet> {
  final _montant = TextEditingController();
  final _libelle = TextEditingController();
  final _reference = TextEditingController();
  final _notes = TextEditingController();

  CashMovementType _type = CashMovementType.entree;
  CashAccount? _account;
  DateTime _date = DateTime.now();
  PickedAttachment? _proof;
  BeneficiaryType _beneficiaryType = BeneficiaryType.autre;
  Beneficiary? _beneficiary;
  String? _filiale;
  bool _submitting = false;
  String? _montantError;
  String? _libelleError;
  String? _accountError;
  String? _proofError;
  String? _beneficiaryError;
  String? _banner;

  @override
  void dispose() {
    _montant.dispose();
    _libelle.dispose();
    _reference.dispose();
    _notes.dispose();
    super.dispose();
  }

  /// Notes envoyées : le bénéficiaire en première ligne, puis la saisie libre.
  ///
  /// La plateforme n'a pas de colonne bénéficiaire ; c'est cette ligne qui en
  /// garde la trace, exactement comme au web.
  String? _composedNotes() {
    final free = _notes.text.trim();
    final beneficiary = _beneficiary;
    final parts = [
      if (_type == CashMovementType.sortie && beneficiary != null)
        'Bénéficiaire : ${_beneficiaryType.label} — ${beneficiary.label}',
      if (free.isNotEmpty) free,
    ];
    return parts.isEmpty ? null : parts.join('\n');
  }

  /// Parses the amount field (accepts spaces/thousands separators) into a
  /// positive number, or null if invalid.
  num? _parsedMontant() {
    final raw = _montant.text
        .replaceAll(RegExp(r'[\s ]'), '')
        .replaceAll(',', '.');
    final v = num.tryParse(raw);
    return (v != null && v > 0) ? v : null;
  }

  /// Vrai quand la sortie exige un bénéficiaire choisi dans la base.
  bool get _needsBeneficiary =>
      _type == CashMovementType.sortie && _beneficiaryType.picksFromDatabase;

  Future<void> _pickBeneficiary() async {
    final entries = await ref.read(beneficiariesProvider(_beneficiaryType).future);
    if (!mounted) return;

    final picked = await showSearchPicker<Beneficiary>(
      context,
      title: _beneficiaryType.label,
      hint: 'Rechercher dans la base',
      emptyLabel:
          'Aucun ${_beneficiaryType.label.toLowerCase()} enregistré dans la base.',
      entries: [
        for (final b in entries)
          PickerEntry(value: b, label: b.label, detail: b.detail),
      ],
    );
    if (picked == null || !mounted) return;

    setState(() {
      _beneficiary = picked;
      _beneficiaryError = null;
      // Le libellé déjà saisi n'est jamais écrasé — même règle qu'au web.
      if (_libelle.text.trim().isEmpty) {
        _libelle.text = '${_beneficiaryType.shortLabel} — ${picked.label}';
      }
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      // Un mouvement se constate ; on n'antidate pas au-delà de l'exercice et on
      // ne postdate pas.
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _submit() async {
    final montant = _parsedMontant();
    final libelle = _libelle.text.trim();
    final proof = _proof;
    setState(() {
      _accountError = _account == null ? 'Sélectionnez un compte.' : null;
      _montantError = montant == null ? 'Montant invalide.' : null;
      _libelleError = libelle.isEmpty ? 'Libellé requis.' : null;
      _proofError = proof == null ? 'Justificatif requis.' : null;
      _beneficiaryError = _needsBeneficiary && _beneficiary == null
          ? 'Sélectionnez le bénéficiaire dans la base.'
          : null;
      _banner = null;
    });
    if (_account == null ||
        montant == null ||
        libelle.isEmpty ||
        proof == null ||
        (_needsBeneficiary && _beneficiary == null)) {
      return;
    }

    setState(() => _submitting = true);

    // Le fichier part d'abord : le mouvement ne transporte que son emplacement.
    final upload = await ref
        .read(uploadRepositoryProvider)
        .upload(
          filePath: proof.path,
          fileName: proof.name,
          bucket: UploadBucket.paymentProofs,
          mimeType: proof.mime,
        );
    if (!mounted) return;

    final uploaded = upload.valueOrNull;
    if (uploaded == null) {
      setState(() {
        _submitting = false;
        // Nommer l'étape qui a échoué : sans cela, un « Connexion
        // indisponible » laissait croire que le mouvement était en cause.
        final cause = upload.failureOrNull?.message ?? 'Réessayez.';
        _banner = "Le justificatif n'a pas pu être envoyé. $cause";
      });
      return;
    }

    final result = await ref
        .read(cashRepositoryProvider)
        .createMovement(
          CashMovementInput(
            accountId: _account!.id,
            type: _type,
            montant: montant,
            libelle: libelle,
            proof: uploaded,
            dateMouvement: _date.toIso8601String().split('T').first,
            reference: _reference.text.trim().isEmpty
                ? null
                : _reference.text.trim(),
            filiale: _filiale,
            notes: _composedNotes(),
          ),
        );
    if (!mounted) return;
    setState(() => _submitting = false);

    result.fold(
      (ok) {
        unawaited(HapticFeedback.lightImpact());
        // Refresh treasury-derived data so the new balance shows everywhere.
        ref
          ..invalidate(cashAccountsProvider)
          ..invalidate(cashJournalProvider)
          ..invalidate(financeDashboardProvider);
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Mouvement enregistré · solde ${Money.fcfa(ok.accountSolde)}',
            ),
          ),
        );
      },
      (f) => setState(
        () => _banner = f.message ?? 'Enregistrement impossible. Réessayez.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final accountsAsync = ref.watch(cashAccountsProvider);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Nouveau mouvement', style: theme.titleLarge),
            const SizedBox(height: Tokens.space4),
            Text(
              'Enregistrer un encaissement ou un décaissement',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space24),
            if (_banner != null) ...[
              _Banner(message: _banner!),
              const SizedBox(height: Tokens.space16),
            ],
            SegmentedButton<CashMovementType>(
              segments: const [
                ButtonSegment(
                  value: CashMovementType.entree,
                  label: Text('Encaissement'),
                  icon: Icon(Icons.south_west),
                ),
                ButtonSegment(
                  value: CashMovementType.sortie,
                  label: Text('Décaissement'),
                  icon: Icon(Icons.north_east),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() {
                _type = s.first;
                // Un encaissement n'a pas de bénéficiaire : on repart propre.
                if (_type == CashMovementType.entree) {
                  _beneficiary = null;
                  _beneficiaryError = null;
                }
              }),
            ),
            if (_type == CashMovementType.sortie) ...[
              const SizedBox(height: Tokens.space16),
              _BeneficiaryBlock(
                type: _beneficiaryType,
                value: _beneficiary,
                errorText: _beneficiaryError,
                onTypeChanged: (t) => setState(() {
                  _beneficiaryType = t;
                  _beneficiary = null;
                  _beneficiaryError = null;
                }),
                onPick: _pickBeneficiary,
              ),
            ],
            const SizedBox(height: Tokens.space24),
            Text('Compte', style: theme.labelLarge),
            const SizedBox(height: Tokens.space8),
            accountsAsync.when(
              loading: () => const _AccountsLoading(),
              error: (e, _) => ErrorState(
                message: 'Comptes indisponibles.',
                onRetry: () => ref.invalidate(cashAccountsProvider),
              ),
              data: (accounts) => _AccountDropdown(
                accounts: accounts,
                value: _account,
                errorText: _accountError,
                onChanged: (a) => setState(() => _account = a),
              ),
            ),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _montant,
              label: 'Montant (FCFA)',
              hint: 'Ex : 250 000',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              prefixIcon: Icons.payments_outlined,
              errorText: _montantError,
            ),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _libelle,
              label: 'Libellé',
              hint: 'Ex : Acompte client, achat fournitures…',
              prefixIcon: Icons.notes_outlined,
              errorText: _libelleError,
            ),
            const SizedBox(height: Tokens.space16),
            _DateField(value: _date, onTap: _pickDate),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _reference,
              label: 'Référence (optionnel)',
              hint: 'Ex : chèque, virement, DEC-2026-014',
              prefixIcon: Icons.tag,
            ),
            const SizedBox(height: Tokens.space16),
            _FilialeField(
              value: _filiale,
              onChanged: (v) => setState(() => _filiale = v),
            ),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _notes,
              label: 'Notes (optionnel)',
              hint: 'Détails complémentaires',
              maxLines: 2,
            ),
            const SizedBox(height: Tokens.space16),
            AttachmentField(
              label: 'Preuve de paiement',
              actionLabel: 'Joindre un justificatif',
              value: _proof,
              errorText: _proofError,
              onChanged: (p) => setState(() {
                _proof = p;
                _proofError = null;
              }),
            ),
            const SizedBox(height: Tokens.space24),
            AppPrimaryButton(
              label: 'Enregistrer',
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

/// Bloc bénéficiaire d'un décaissement : sa nature, puis qui exactement.
///
/// Détaché visuellement du reste, comme au web : il ne concerne que les
/// sorties, et ce cadre évite qu'il se confonde avec les champs du mouvement.
class _BeneficiaryBlock extends StatelessWidget {
  const _BeneficiaryBlock({
    required this.type,
    required this.value,
    required this.errorText,
    required this.onTypeChanged,
    required this.onPick,
  });

  final BeneficiaryType type;
  final Beneficiary? value;
  final String? errorText;
  final ValueChanged<BeneficiaryType> onTypeChanged;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Type de bénéficiaire', style: theme.labelLarge),
          const SizedBox(height: Tokens.space8),
          DropdownButtonFormField<BeneficiaryType>(
            initialValue: type,
            isExpanded: true,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: [
              for (final t in BeneficiaryType.values)
                DropdownMenuItem(
                  value: t,
                  child: Text(t.label, overflow: TextOverflow.ellipsis),
                ),
            ],
            onChanged: (t) => t == null ? null : onTypeChanged(t),
          ),
          if (type.picksFromDatabase) ...[
            const SizedBox(height: Tokens.space12),
            Text('Bénéficiaire', style: theme.labelLarge),
            const SizedBox(height: Tokens.space8),
            OutlinedButton.icon(
              onPressed: onPick,
              icon: const Icon(Icons.search),
              label: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value?.label ?? 'Sélectionner dans la base',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                alignment: Alignment.centerLeft,
                side: BorderSide(
                  color: errorText == null ? colors.border : colors.danger,
                ),
              ),
            ),
            if (errorText != null) ...[
              const SizedBox(height: Tokens.space4),
              Text(
                errorText!,
                style: theme.bodySmall?.copyWith(color: colors.danger),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// Filiale concernée, prise dans les listes de référence de l'organisation.
/// Absente ou vide, le champ ne s'affiche pas : rien à choisir.
class _FilialeField extends ConsumerWidget {
  const _FilialeField({required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filiales = ref.watch(filialesProvider).valueOrNull ?? const <String>[];
    if (filiales.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Filiale (optionnel)', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: Tokens.space8),
        DropdownButtonFormField<String?>(
          initialValue: value,
          isExpanded: true,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: [
            const DropdownMenuItem<String?>(child: Text('Toutes')),
            for (final f in filiales)
              DropdownMenuItem<String?>(value: f, child: Text(f)),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}

/// Date de l'opération, présentée comme un champ pour rester dans la même
/// famille visuelle que le reste du formulaire.
class _DateField extends StatelessWidget {
  const _DateField({required this.value, required this.onTap});

  final DateTime value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final label =
        '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/${value.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Date de l'opération", style: theme.labelLarge),
        const SizedBox(height: Tokens.space8),
        OutlinedButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.event_outlined),
          label: Align(
            alignment: Alignment.centerLeft,
            child: Text(label),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }
}

class _AccountDropdown extends StatelessWidget {
  const _AccountDropdown({
    required this.accounts,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  final List<CashAccount> accounts;
  final CashAccount? value;
  final ValueChanged<CashAccount?> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return Text(
        'Aucun compte disponible.',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: context.colors.textMuted),
      );
    }
    return DropdownButtonFormField<CashAccount>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        errorText: errorText,
        prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
      ),
      hint: const Text('Choisir un compte'),
      items: [
        for (final a in accounts)
          DropdownMenuItem(
            value: a,
            child: Text(
              '${a.nom} · ${Money.fcfa(a.solde)}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

class _AccountsLoading extends StatelessWidget {
  const _AccountsLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: context.colors.border.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.danger.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Tokens.radiusSm),
        border: Border.all(color: colors.danger.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colors.danger, size: 20),
          const SizedBox(width: Tokens.space8),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
