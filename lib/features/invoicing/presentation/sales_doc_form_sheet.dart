import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/cash/application/cash_providers.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';
import 'package:sytium_mobile/features/commercial/application/commercial_providers.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
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
  ProformaDetail? editing,
}) {
  return showAppSheet<bool>(
    context,
    builder: (_) =>
        _SalesDocFormSheet(initialKind: initialKind, editing: editing),
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
  const _SalesDocFormSheet({required this.initialKind, this.editing});

  final SalesDocKind initialKind;

  /// Proforma à modifier ; nulle pour une émission.
  final ProformaDetail? editing;

  @override
  ConsumerState<_SalesDocFormSheet> createState() => _SalesDocFormSheetState();
}

class _SalesDocFormSheetState extends ConsumerState<_SalesDocFormSheet> {
  final _client = TextEditingController();
  final _objet = TextEditingController();
  final _lines = <_Line>[];

  final _notes = TextEditingController();

  ClientRef? _clientRef;
  DateTime _dateEmission = DateTime.now();

  /// Durée de validité en jours, ou null pour une échéance choisie à la main.
  int? _validityDays = 30;
  DateTime _dateEcheance = DateTime.now().add(const Duration(days: 30));
  ProformaStatus _statut = ProformaStatus.brouillon;
  String? _objetError;

  late SalesDocKind _kind = widget.initialKind;
  /// Taux de TVA : celui de l'organisation tant que l'employé n'en choisit pas
  /// un autre, et figé si le régime l'exonère.
  num? _tauxChoisi;
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

    final editing = widget.editing;
    if (editing == null) {
      _addLine();
      return;
    }
    _prefill(editing);
  }

  /// Recharge la pièce dans le formulaire. Les lignes sont recréées telles
  /// quelles, rattachement au catalogue compris, pour qu'un enregistrement sans
  /// retouche ne perde rien.
  void _prefill(ProformaDetail p) {
    _client.text = p.clientNom;
    _objet.text = p.objet ?? '';
    _notes.text = p.notes ?? '';
    _clientRef = ClientRef(
      id: '',
      nom: p.clientNom,
      email: p.clientEmail,
      adresse: p.clientAdresse,
    );
    _tauxChoisi = p.tauxTva;
    _statut = ProformaStatus.values.firstWhere(
      (s) => s.wire == p.statut,
      orElse: () => ProformaStatus.brouillon,
    );
    if (p.dateEmission != null) _dateEmission = p.dateEmission!;
    if (p.dateEcheance != null) {
      _dateEcheance = p.dateEcheance!;
      // L'échéance vient de la pièce : aucune durée ne doit la recalculer.
      _validityDays = null;
    }

    for (final line in p.items) {
      final l = _Line()
        ..description.text = line.description
        ..quantite.text = _plain(line.quantite)
        ..prix.text = _plain(line.prixUnitaire);
      if (line.productId != null) {
        l.product = ProductRef(
          id: line.productId!,
          libelle: line.description,
          reference: line.reference,
          prixHt: line.prixUnitaire,
        );
      }
      l.quantite.addListener(_recompute);
      l.prix.addListener(_recompute);
      _lines.add(l);
    }
    if (_lines.isEmpty) _addLine();
  }

  /// « 2 » plutôt que « 2.0 » dans un champ de saisie.
  static String _plain(num v) =>
      v == v.roundToDouble() ? v.round().toString() : v.toString();

  @override
  void dispose() {
    _client.dispose();
    _objet.dispose();
    _notes.dispose();
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  /// Recale l'échéance sur la durée choisie. Une échéance fixée à la main
  /// n'est plus touchée : c'est le sens de « personnalisée ».
  void _applyValidity() {
    final days = _validityDays;
    if (days != null) {
      _dateEcheance = _dateEmission.add(Duration(days: days));
    }
  }

  /// Décrit la pièce telle qu'elle sera envoyée, à la création comme à la
  /// modification — une seule définition, donc aucun champ oublié d'un côté.
  SalesDocInput _input(String client, List<_Line> lines) => SalesDocInput(
    kind: _kind,
    clientNom: client,
    clientEmail: _clientRef?.email,
    clientAdresse: _clientRef?.adresse,
    objet: _objet.text.trim(),
    notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
    dateEmission: _dateEmission,
    dateEcheance: _dateEcheance,
    statut: _statut,
    tauxTva: _taux,
    accountId: _kind == SalesDocKind.comptant ? _account?.id : null,
    items: lines.map((l) => l.toInput()).toList(),
  );

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

  FiscalRule get _fiscal {
    final auth = ref.read(authControllerProvider).valueOrNull;
    return auth is Authenticated ? auth.session.fiscal : const FiscalRule();
  }

  num get _taux => _fiscal.verrouille ? 0 : (_tauxChoisi ?? _fiscal.tauxTva);

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
      _objetError = _objet.text.trim().isEmpty
          ? "L'objet de la commande est requis."
          : null;
      _itemsError = validLines.isEmpty
          ? 'Ajoutez au moins une ligne valide.'
          : null;
      _accountError = needAccount && _account == null
          ? 'Choisissez le compte encaisseur.'
          : null;
      _banner = null;
    });
    if (client.isEmpty ||
        _objet.text.trim().isEmpty ||
        validLines.isEmpty ||
        (needAccount && _account == null)) {
      return;
    }

    setState(() => _submitting = true);
    final editing = widget.editing;
    final repo = ref.read(invoicingRepositoryProvider);

    if (editing != null) {
      final updated = await repo.updateProforma(
        editing.id,
        _input(client, validLines),
      );
      if (!mounted) return;
      setState(() => _submitting = false);

      updated.fold(
        (_) {
          unawaited(HapticFeedback.lightImpact());
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Proforma ${editing.numero} mise à jour')),
          );
        },
        // Le serveur porte les garde-fous : proforma déjà facturée, validation
        // exigée pour l'accepter. Son message est plus précis que le nôtre.
        (f) => setState(
          () => _banner = f.message ?? 'Modification impossible. Réessayez.',
        ),
      );
      return;
    }

    final result = await repo.createDocument(_input(client, validLines));
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
    // La session porte la règle de TVA de l'organisation. On la suit : une
    // feuille ouverte avant sa résolution resterait sinon sur 18 %, y compris
    // pour une société exonérée.
    ref.watch(authControllerProvider);

    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final comptant = _kind == SalesDocKind.comptant;
    final editing = widget.editing;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              editing == null
                  ? 'Émission de pièce commerciale'
                  : 'Modifier la proforma',
              style: theme.titleLarge,
            ),
            const SizedBox(height: Tokens.space4),
            Text(
              editing != null
                  ? editing.numero
                  : comptant
                  ? 'Facture comptant · intègre la trésorerie'
                  : 'Proforma · devis non comptabilisé',
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: Tokens.space24),
            if (_banner != null) ...[
              _Banner(message: _banner!),
              const SizedBox(height: Tokens.space16),
            ],
            if (_canComptant && editing == null)
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
            if (_canComptant && editing == null)
              const SizedBox(height: Tokens.space16),
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
              label: 'Objet de la commande',
              hint: 'Ex : Prestation, fourniture…',
              prefixIcon: Icons.subject,
              errorText: _objetError,
            ),
            const SizedBox(height: Tokens.space16),
            _ValidityFields(
              emission: _dateEmission,
              echeance: _dateEcheance,
              days: _validityDays,
              onEmission: (d) => setState(() {
                _dateEmission = d;
                _applyValidity();
              }),
              onDays: (d) => setState(() {
                _validityDays = d;
                _applyValidity();
              }),
              onEcheance: (d) => setState(() {
                _dateEcheance = d;
                _validityDays = null;
              }),
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
            _TvaField(
              value: _taux,
              rule: _fiscal,
              onChanged: (v) => setState(() => _tauxChoisi = v),
            ),
            if (comptant) ...[
              const SizedBox(height: Tokens.space16),
              _AccountPicker(
                value: _account,
                errorText: _accountError,
                onChanged: (a) => setState(() => _account = a),
              ),
            ],
            const SizedBox(height: Tokens.space16),
            if (!comptant) ...[
              _StatusField(
                value: _statut,
                onChanged: (v) => setState(() => _statut = v),
              ),
              const SizedBox(height: Tokens.space16),
            ],
            AppTextField(
              controller: _notes,
              label: 'Notes (optionnel)',
              hint: 'Conditions, précisions…',
              maxLines: 2,
            ),
            const SizedBox(height: Tokens.space24),
            _TotalsCard(
              ht: _ht,
              tvaPct: _taux,
              tva: _tva,
              ttc: _ttc,
            ),
            const SizedBox(height: Tokens.space24),
            AppPrimaryButton(
              label: editing != null
                  ? 'Enregistrer les modifications'
                  : comptant
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

/// Date d'émission et fin de validité, avec les durées proposées par le web.
class _ValidityFields extends StatelessWidget {
  const _ValidityFields({
    required this.emission,
    required this.echeance,
    required this.days,
    required this.onEmission,
    required this.onDays,
    required this.onEcheance,
  });

  final DateTime emission;
  final DateTime echeance;
  final int? days;
  final ValueChanged<DateTime> onEmission;
  final ValueChanged<int?> onDays;
  final ValueChanged<DateTime> onEcheance;

  static const _presets = <int?, String>{
    7: '7 jours',
    15: '15 jours',
    20: '20 jours',
    30: '30 jours',
    60: '2 mois',
    90: '3 mois',
    null: 'Personnalisée',
  };

  static String _label(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';

  Future<void> _pick(
    BuildContext context,
    DateTime current,
    ValueChanged<DateTime> onPicked,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 3),
    );
    if (picked != null) onPicked(picked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Date d’émission', style: theme.labelLarge),
        const SizedBox(height: Tokens.space8),
        OutlinedButton.icon(
          onPressed: () => _pick(context, emission, onEmission),
          icon: const Icon(Icons.event_outlined),
          label: Align(
            alignment: Alignment.centerLeft,
            child: Text(_label(emission)),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            alignment: Alignment.centerLeft,
          ),
        ),
        const SizedBox(height: Tokens.space16),
        _Dropdown<int?>(
          label: 'Durée de validité',
          value: days,
          items: _presets,
          onChanged: onDays,
        ),
        const SizedBox(height: Tokens.space8),
        // La date reste consultable même quand une durée la calcule : c'est
        // elle qui figure sur le devis.
        OutlinedButton.icon(
          onPressed: days == null
              ? () => _pick(context, echeance, onEcheance)
              : null,
          icon: const Icon(Icons.event_available_outlined),
          label: Align(
            alignment: Alignment.centerLeft,
            child: Text('Valable jusqu’au ${_label(echeance)}'),
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

/// Taux de TVA. Verrouillé sous un régime exonéré : la loi ne se choisit pas
/// dans un formulaire.
class _TvaField extends StatelessWidget {
  const _TvaField({
    required this.value,
    required this.rule,
    required this.onChanged,
  });

  final num value;
  final FiscalRule rule;
  final ValueChanged<num> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    if (rule.verrouille) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: 'TVA',
          border: const OutlineInputBorder(),
          helperText: 'Régime ${rule.regime ?? ''} — exonéré',
          enabled: false,
        ),
        child: Text('0 %', style: theme.bodyLarge),
      );
    }

    return _Dropdown<num>(
      label: 'TVA',
      value: value,
      items: const {0: '0 %', 9: '9 %', 18: '18 %'},
      onChanged: onChanged,
    );
  }
}

class _StatusField extends StatelessWidget {
  const _StatusField({required this.value, required this.onChanged});

  final ProformaStatus value;
  final ValueChanged<ProformaStatus> onChanged;

  @override
  Widget build(BuildContext context) => _Dropdown<ProformaStatus>(
    label: 'Statut',
    value: value,
    items: {for (final s in ProformaStatus.values) s: s.label},
    onChanged: onChanged,
  );
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
