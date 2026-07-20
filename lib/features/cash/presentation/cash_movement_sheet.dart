import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/cash/application/cash_providers.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';
import 'package:sytium_mobile/features/finance/application/finance_providers.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
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
  final _notes = TextEditingController();

  CashMovementType _type = CashMovementType.entree;
  CashAccount? _account;
  bool _submitting = false;
  String? _montantError;
  String? _libelleError;
  String? _accountError;
  String? _banner;

  @override
  void dispose() {
    _montant.dispose();
    _libelle.dispose();
    _notes.dispose();
    super.dispose();
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

  Future<void> _submit() async {
    final montant = _parsedMontant();
    final libelle = _libelle.text.trim();
    setState(() {
      _accountError = _account == null ? 'Sélectionnez un compte.' : null;
      _montantError = montant == null ? 'Montant invalide.' : null;
      _libelleError = libelle.isEmpty ? 'Libellé requis.' : null;
      _banner = null;
    });
    if (_account == null || montant == null || libelle.isEmpty) return;

    setState(() => _submitting = true);
    final result = await ref
        .read(cashRepositoryProvider)
        .createMovement(
          CashMovementInput(
            accountId: _account!.id,
            type: _type,
            montant: montant,
            libelle: libelle,
            notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
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
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
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
            AppTextField(
              controller: _notes,
              label: 'Notes (optionnel)',
              hint: 'Détails complémentaires',
              maxLines: 2,
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
