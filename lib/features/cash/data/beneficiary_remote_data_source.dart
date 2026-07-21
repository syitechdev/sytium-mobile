import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/utils/money.dart';
import 'package:sytium_mobile/features/cash/domain/beneficiary.dart';

/// Plafond de chargement. La recherche filtre ensuite en local, comme au web —
/// qui demande davantage mais que le serveur ramène de toute façon à ce palier
/// pour les fournisseurs.
const _kPerPage = 500;

/// Listes de bénéficiaires, une par nature.
///
/// Ce sont les routes de la plateforme, pas des routes mobiles : le web les
/// consomme déjà, et un employé habilité à décaisser y a accès.
class BeneficiaryRemoteDataSource {
  BeneficiaryRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<Beneficiary>> forType(BeneficiaryType type) => switch (type) {
    BeneficiaryType.fournisseur => _suppliers(prestataires: false),
    BeneficiaryType.prestataire => _suppliers(prestataires: true),
    BeneficiaryType.debiteurBanque => _bankLoans(),
    BeneficiaryType.debiteurPersonne => _personalDebts(),
    BeneficiaryType.actionnaireCca => _ccaBalances(),
    BeneficiaryType.actionnaireDividende => _shareholders(),
    BeneficiaryType.salarie => _employees(),
    BeneficiaryType.autre => Future.value(const <Beneficiary>[]),
  };

  Future<List<Beneficiary>> _suppliers({required bool prestataires}) async {
    final rows = await _rows('/suppliers');
    // La base ne distingue les deux que par ce champ ; un partenaire sans
    // mention est un fournisseur, comme au web.
    bool isPrestataire(Map<String, dynamic> r) =>
        ((r['type_partenaire'] as String?) ?? 'fournisseur') == 'prestataire';

    return rows
        .where((r) => isPrestataire(r) == prestataires)
        .map(
          (r) => Beneficiary(
            id: r['id'] as String,
            label: (r['nom'] as String?) ?? '—',
            detail: (r['telephone'] as String?) ?? (r['email'] as String?),
          ),
        )
        .toList();
  }

  Future<List<Beneficiary>> _bankLoans() async {
    final rows = await _rows('/bank-loans');
    return rows.map((r) {
      final banque = (r['banque'] as String?) ?? '';
      final libelle = (r['libelle'] as String?) ?? '';
      return Beneficiary(
        id: r['id'] as String,
        label: [banque, libelle].where((s) => s.isNotEmpty).join(' — '),
        detail: 'Reste dû : ${Money.fcfa(_num(r['capital_restant']))}',
      );
    }).toList();
  }

  Future<List<Beneficiary>> _personalDebts() async {
    final rows = await _rows('/personal-debts');
    return rows
        .map(
          (r) => Beneficiary(
            id: r['id'] as String,
            label: (r['creancier_nom'] as String?) ?? '—',
            detail: 'Reste : ${Money.fcfa(_num(r['montant_restant']))}',
          ),
        )
        .toList();
  }

  Future<List<Beneficiary>> _ccaBalances() async {
    final rows = await _rows('/shareholder-current-accounts/balances');
    return rows
        .map(
          (r) => Beneficiary(
            // L'identifiant utile est l'actionnaire, pas la ligne de solde.
            id: (r['shareholder_id'] as String?) ?? (r['id'] as String),
            label: _fullName(r),
            detail: 'Solde CCA : ${Money.fcfa(_num(r['solde']))}',
          ),
        )
        .toList();
  }

  Future<List<Beneficiary>> _shareholders() async {
    final rows = await _rows('/shareholders');
    return rows
        .where((r) => (r['statut'] as String?) == 'actif')
        .map(
          (r) => Beneficiary(
            id: r['id'] as String,
            label: _fullName(r),
            detail: r['type_actionnaire'] as String?,
          ),
        )
        .toList();
  }

  Future<List<Beneficiary>> _employees() async {
    final rows = await _rows('/employees');
    return rows
        .where((r) => (r['statut'] as String?) != 'inactif')
        .map(
          (r) => Beneficiary(
            id: r['id'] as String,
            label: _fullName(r),
            detail: (r['poste'] as String?) ?? (r['matricule'] as String?),
          ),
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> _rows(String path) async {
    final res = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: {'per_page': _kPerPage},
    );
    final data = res.data?['data'];
    if (data is! List) return const [];
    return data.cast<Map<String, dynamic>>();
  }

  static String _fullName(Map<String, dynamic> row) {
    final nom = (row['nom'] as String?) ?? '';
    final prenoms = (row['prenoms'] as String?) ?? '';
    final full = '$nom $prenoms'.trim();
    return full.isEmpty ? '—' : full;
  }

  /// Les agrégats SQL remontent parfois en chaîne décimale.
  static num _num(Object? v) => switch (v) {
    final num n => n,
    final String s => num.tryParse(s) ?? 0,
    _ => 0,
  };
}
