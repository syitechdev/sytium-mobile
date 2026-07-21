import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/cash/application/cash_providers.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';
import 'package:sytium_mobile/features/commercial/application/commercial_providers.dart';
import 'package:sytium_mobile/features/finance/application/finance_providers.dart';
import 'package:sytium_mobile/features/invoicing/application/invoicing_providers.dart';
import 'package:sytium_mobile/features/invoicing/domain/catalogue.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_models.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_sheet.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/shared/widgets/search_picker_sheet.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';


/// Opens « Émission de pièce commerciale ». Resolves to `true` on success.
///
/// [initialKind] présélectionne le type de pièce (proforma ou comptant). Le
/// mode comptant reste conditionné à l'habilitation financeWrite : demandé sans
/// ce droit, la feuille retombe sur proforma.
Future<bool?> showSalesDocSheet(
  BuildContext context, {
  SalesDocKind initialKind = SalesDocKind.proforma,
}) {
  return showAppSheet<bool>(
    context,
    builder: (_) => _SalesDocFormSheet(initialKind: initialKind),
  );
}

/// Controllers backing one document line.
class _Line {
  _Line() {
    description = TextEditingController();
    quantite = TextEditingController(text: '1');
    prix = TextEditingController();
  }

  late final TextEditingController description;
  late final TextEditingController quantite;
  late final TextEditingController prix;

  /// Produit du catalogue d'où viennent désignation et prix, s'il y en a un.
  ProductRef? product;

  num get qte => num.tryParse(quantite.text.trim().replaceAll(',', '.')) ?? 0;
  num get pu =>
      num.tryParse(
        prix.text.trim().replaceAll(RegExp('[  ]'), '').replaceAll(',', '.'),
      ) ??
      0;
  num get total => qte * pu;
  bool get isValid => description.text.trim().isNotEmpty && qte > 0 && pu >= 0;

  ProformaLineInput toInput() => ProformaLineInput(
    description: description.text.trim(),
    quantite: qte,
    prixUnitaire: pu,
    productId: product?.id,
    reference: product?.reference,
  );

  void dispose() {
    description.dispose();
    quantite.dispose();
    prix.dispose();
  }
}

class _SalesDocFormSheet extends ConsumerStatefulWidget {
  const _SalesDocFormSheet({required this.initialKind});

  final SalesDocKind initialKind;

  @override
  ConsumerState<_SalesDocFormSheet> createState() => _SalesDocFormSheetState();
}

class _SalesDocFormSheetState extends ConsumerState<_SalesDocFormSheet> {
  final _client = TextEditingController();
  final _objet = TextEditingController();
  final _lines = <_Line>[];

  ClientRef? _clientRef;

  late SalesDocKind _kind = widget.initialKind;
  num _taux = 18;
  CashAccount? _account;
  bool _submitting = false;
  String? _clientError;
  String? _itemsError;
  String? _accountError;
  String? _banner;

  @override
  void initState() {
    super.initState();
    // Garde-fou : un comptant demandé sans habilitation retombe sur proforma,
    // sinon le sélecteur de mode serait masqué et la pièce partirait en
    // comptant sans compte de règlement.
    if (_kind == SalesDocKind.comptant && !_canComptant) {
      _kind = SalesDocKind.proforma;
    }
    _addLine();
  }

  @override
  void dispose() {
    _client.dispose();
    _objet.dispose();
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  Future<void> _pickClient() async {
    final catalogue = ref.read(catalogueProvider);
    final picked = await showSearchPicker<ClientRef>(
      context,
      title: 'Client',
      hint: 'Nom, code, e-mail ou téléphone',
      emptyLabel: 'Aucun client trouvé.',
      onSearch: (query) async {
        final clients = await catalogue.searchClients(query);
        return [
          for (final c in clients)
            PickerEntry(
              value: c,
              label: c.nom,
              detail: c.email ?? c.telephone ?? c.adresse,
            ),
        ];
      },
    );
    if (picked == null || !mounted) return;

    setState(() {
      _clientRef = picked;
      _client.text = picked.nom;
      _clientError = null;
    });
  }

  Future<void> _pickProduct(_Line line) async {
    final products = await ref.read(productsProvider.future);
    if (!mounted) return;

    final picked = await showSearchPicker<ProductRef>(
      context,
      title: 'Produit',
      hint: 'Référence ou désignation',
      emptyLabel: 'Aucun produit actif au catalogue.',
      entries: [
        for (final p in products)
          PickerEntry(
            value: p,
            label: p.label,
            detail: Money.fcfa(p.prixHt),
          ),
      ],
    );
    if (picked == null || !mounted) return;

    setState(() {
      line.product = picked;
      line.description.text = picked.libelle;
      line.prix.text = picked.prixHt.round().toString();
    });
  }

  void _recompute() => setState(() {});

  void _addLine() {
    final line = _Line()
      ..quantite.addListener(_recompute)
      ..prix.addListener(_recompute);
    setState(() => _lines.add(line));
  }

  void _removeLine(int i) {
    _lines.removeAt(i)
      ..quantite.removeListener(_recompute)
      ..prix.removeListener(_recompute)
      ..dispose();
    setState(() {});
  }

  num get _ht => _lines.fold<num>(0, (s, l) => s + l.total);
  num get _tva => (_ht * _taux / 100).round();
  num get _ttc => _ht + _tva;

  bool get _canComptant {
    final auth = ref.read(authControllerProvider).valueOrNull;
    return auth is Authenticated && auth.session.capabilities.financeWrite;
  }

  Future<void> _submit() async {
    final client = _client.text.trim();
    final validLines = _lines.where((l) => l.isValid).toList();
    final needAccount = _kind == SalesDocKind.comptant;
    setState(() {
      _clientError = client.isEmpty ? 'Nom du client requis.' : null;
      _itemsError = validLines.isEmpty
          ? 'Ajoutez au moins une ligne valide.'
          : null;
      _accountError = needAccount && _account == null
          ? 'Choisissez le compte encaisseur.'
          : null;
      _banner = null;
    });
    if (client.isEmpty ||
        validLines.isEmpty ||
        (needAccount && _account == null)) {
      return;
    }

    setState(() => _submitting = true);
    final result = await ref
        .read(invoicingRepositoryProvider)
        .createDocument(
          SalesDocInput(
            kind: _kind,
            clientNom: client,
            clientEmail: _clientRef?.email,
            clientAdresse: _clientRef?.adresse,
            objet: _objet.text.trim().isEmpty ? null : _objet.text.trim(),
            tauxTva: _taux,
            accountId: needAccount ? _account!.id : null,
            items: validLines.map((l) => l.toInput()).toList(),
          ),
        );
    if (!mounted) return;
    setState(() => _submitting = false);

    result.fold(
      (ok) {
        unawaited(HapticFeedback.lightImpact());
        ref
          ..invalidate(commercialDashboardProvider)
          ..invalidate(cashJournalProvider)
          ..invalidate(cashAccountsProvider)
          ..invalidate(financeDashboardProvider);
        Navigator.of(context).pop(true);
        final label = ok.kind == SalesDocKind.comptant ? 'Facture' : 'Proforma';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$label ${ok.numero} créée · ${Money.fcfa(ok.totalTtc)}',
            ),
          ),
        );
      },
      (f) => setState(
        () => _banner = f.message ?? 'Émission impossible. Réessayez.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final comptant = _kind == SalesDocKind.comptant;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Émission de pièce commerciale', style: theme.titleLarge),
            const SizedBox(height: Tokens.space4),
            Text(
              comptant
                  ? 'Facture comptant · intègre la trésorerie'
                  : 'Proforma · devis non comptabilisé',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space24),
            if (_banner != null) ...[
              _Banner(message: _banner!),
              const SizedBox(height: Tokens.space16),
            ],
            if (_canComptant)
              SegmentedButton<SalesDocKind>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(
                    value: SalesDocKind.proforma,
                    label: Text('Proforma'),
                  ),
                  ButtonSegment(
                    value: SalesDocKind.comptant,
                    label: Text('Comptant'),
                  ),
                ],
                selected: {_kind},
                onSelectionChanged: (s) => setState(() => _kind = s.first),
              ),
            if (_canComptant) const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _client,
              label: 'Client',
              hint: 'Ex : SODECI, Orange CI…',
              // Le web laisse aussi taper un nom non répertorié : le devis
              // n'est pas lié au référentiel, il en recopie les valeurs.
              suffix: IconButton(
                onPressed: _pickClient,
                icon: const Icon(Icons.search),
                tooltip: 'Rechercher un client',
              ),
              onChanged: (_) => _clientRef = null,
              prefixIcon: Icons.business_outlined,
              errorText: _clientError,
            ),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _objet,
              label: 'Objet (optionnel)',
              hint: 'Ex : Prestation, fourniture…',
              prefixIcon: Icons.subject,
            ),
            const SizedBox(height: Tokens.space24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lignes', style: theme.titleSmall),
                TextButton.icon(
                  onPressed: _addLine,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Ajouter'),
                ),
              ],
            ),
            if (_itemsError != null)
              Padding(
                padding: const EdgeInsets.only(bottom: Tokens.space8),
                child: Text(
                  _itemsError!,
                  style: theme.bodySmall?.copyWith(color: colors.danger),
                ),
              ),
            for (var i = 0; i < _lines.length; i++)
              _LineEditor(
                line: _lines[i],
                canRemove: _lines.length > 1,
                onRemove: () => _removeLine(i),
                onPickProduct: () => _pickProduct(_lines[i]),
              ),
            const SizedBox(height: Tokens.space16),
            _Dropdown<num>(
              label: 'TVA',
              value: _taux,
              items: const {0: '0 %', 18: '18 %'},
              onChanged: (v) => setState(() => _taux = v),
            ),
            if (comptant) ...[
              const SizedBox(height: Tokens.space16),
              _AccountPicker(
                value: _account,
                errorText: _accountError,
                onChanged: (a) => setState(() => _account = a),
              ),
            ],
            const SizedBox(height: Tokens.space24),
            _TotalsCard(
              ht: _ht,
              tvaPct: _taux,
              tva: _tva,
              ttc: _ttc,
            ),
            const SizedBox(height: Tokens.space24),
            AppPrimaryButton(
              label: comptant
                  ? 'Générer & encaisser la facture'
                  : 'Émettre le proforma',
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountPicker extends ConsumerWidget {
  const _AccountPicker({
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  final CashAccount? value;
  final ValueChanged<CashAccount?> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    final async = ref.watch(cashAccountsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Compte encaisseur', style: theme.labelLarge),
        const SizedBox(height: Tokens.space8),
        async.when(
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text(
            'Comptes indisponibles.',
            style: theme.bodySmall?.copyWith(color: context.colors.danger),
          ),
          data: (accounts) => DropdownButtonFormField<CashAccount>(
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
          ),
        ),
      ],
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final T value;
  final Map<T, String> items;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: Tokens.space8),
        DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: true,
          items: [
            for (final e in items.entries)
              DropdownMenuItem(value: e.key, child: Text(e.value)),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ],
    );
  }
}

class _LineEditor extends StatelessWidget {
  const _LineEditor({
    required this.line,
    required this.canRemove,
    required this.onRemove,
    required this.onPickProduct,
  });

  final _Line line;
  final bool canRemove;
  final VoidCallback onRemove;
  final VoidCallback onPickProduct;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: Tokens.space12),
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: line.description,
                  // Une désignation retouchée à la main ne vient plus du
                  // catalogue : on cesse de prétendre le contraire.
                  onChanged: (_) => line.product = null,
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Désignation',
                  ),
                ),
              ),
              IconButton(
                onPressed: onPickProduct,
                icon: const Icon(Icons.inventory_2_outlined, size: 18),
                tooltip: 'Choisir au catalogue',
              ),
              if (canRemove)
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(Icons.close, size: 18, color: colors.danger),
                  tooltip: 'Supprimer la ligne',
                ),
            ],
          ),
          const SizedBox(height: Tokens.space8),
          Row(
            children: [
              SizedBox(
                width: 72,
                child: TextField(
                  controller: line.quantite,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Qté',
                  ),
                ),
              ),
              const SizedBox(width: Tokens.space12),
              Expanded(
                child: TextField(
                  controller: line.prix,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Prix unitaire (FCFA)',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Tokens.space8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              Money.fcfa(line.total),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colors.textMuted,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalsCard extends StatelessWidget {
  const _TotalsCard({
    required this.ht,
    required this.tvaPct,
    required this.tva,
    required this.ttc,
  });

  final num ht;
  final num tvaPct;
  final num tva;
  final num ttc;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(Tokens.space16),
      decoration: BoxDecoration(
        color: colors.brand.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(Tokens.radiusMd),
        border: Border.all(color: colors.brand.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          _row(context, 'Montant HT', Money.fcfa(ht)),
          const SizedBox(height: Tokens.space8),
          _row(context, 'TVA (${tvaPct.toInt()} %)', Money.fcfa(tva)),
          const Divider(height: Tokens.space24),
          _row(
            context,
            'Total net à payer (TTC)',
            Money.fcfa(ttc),
            emphasize: true,
          ),
        ],
      ),
    );
  }

  Widget _row(
    BuildContext context,
    String label,
    String value, {
    bool emphasize = false,
    Color? color,
  }) {
    final theme = Theme.of(context).textTheme;
    final colors = context.colors;
    final style = emphasize
        ? theme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
        : theme.bodyMedium?.copyWith(color: color ?? colors.textMuted);
    // Le libellé cède la place au montant : « Total net à payer (TTC) » suivi
    // d'une somme à sept chiffres débordait sur un écran étroit.
    return Row(
      children: [
        Expanded(child: Text(label, style: style)),
        const SizedBox(width: Tokens.space12),
        Text(
          value,
          style: style?.copyWith(
            color: color ?? (emphasize ? null : colors.textPrimary),
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
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
