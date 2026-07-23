import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/stats/data/dashboard_remote_data_source.dart';
import 'package:sytium_mobile/features/stats/data/dtos/dashboard_series_dtos.dart';
import 'package:sytium_mobile/features/stats/data/stats_remote_data_source.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/features/stats/domain/working_capital_models.dart';

class StatsRepositoryImpl implements StatsRepository {
  StatsRepositoryImpl(this._remote, this._dashboardRemote);
  final StatsRemoteDataSource _remote;
  final DashboardRemoteDataSource _dashboardRemote;

  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) =>
      _guard(() async {
        final dto = await _remote.attendanceSummary(month);
        final row = dto.row;
        if (row == null) {
          return MonthlyAttendance(month: dto.month);
        }
        return MonthlyAttendance(
          month: dto.month,
          employee: AttendanceEmployee(
            id: row.employee.id,
            matricule: row.employee.matricule,
            nom: row.employee.nom,
            prenoms: row.employee.prenoms,
          ),
          heuresTravaillees: row.heuresTravaillees.toDouble(),
          heuresAttendues: row.heuresAttendues.toDouble(),
          heuresPermission: row.heuresPermission.toDouble(),
          heuresAbsenceInjustifiee: row.heuresAbsenceInjustifiee.toDouble(),
          joursPermission: row.joursPermission,
          joursAbsenceInjustifiee: row.joursAbsenceInjustifiee,
        );
      });

  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) =>
      _guard(() async {
        final dto = await _dashboardRemote.dashboard(period.query);
        final k = dto.kpis;
        final d = dto.deltas;
        return DashboardKpis(
          period: dto.period,
          periodLabel: dto.periodLabel,
          caGlobal: k.caGlobal,
          recettes: k.recettes,
          charges: k.charges,
          tauxRecouvrement: k.tauxRecouvrement,
          tresorerieTotale: k.tresorerieTotale,
          dettesFournisseurs: k.dettesFournisseurs,
          dettesSalaires: k.dettesSalaires,
          masseSalarialeNet: k.masseSalarialeNet,
          effectifActif: k.effectifActif,
          presence: dto.presence == null
              ? null
              : PresenceSnapshot(
                  effectifActif: dto.presence!.effectifActif,
                  presents: dto.presence!.presents,
                  enMission: dto.presence!.enMission,
                  absents: dto.presence!.absents,
                ),
          today: dto.today == null
              ? null
              : TodaySnapshot(
                  ca: dto.today!.ca,
                  recettes: dto.today!.recettes,
                  depenses: dto.today!.depenses,
                  solde: dto.today!.solde,
                ),
          deltaCaGlobal: d.caGlobal,
          deltaRecettes: d.recettes,
          deltaCharges: d.charges,
          deltaMasseSalariale: d.masseSalarialeNet,
        );
      });

  @override
  Future<Result<DashboardSeries>> dashboardSeries() => _guard(() async {
        final dto = await _dashboardRemote.series();
        List<NamedValue> map(List<SeriesPointDto> pts) =>
            pts.map((p) => NamedValue(p.label, p.value)).toList();
        final c = dto.caComparaison;
        final o = dto.caObjectif;
        return DashboardSeries(
          caObjectif: o == null
              ? null
              : CaObjectif(
                  objectif: o.objectif,
                  realise: o.realise,
                  annee: o.annee,
                  taux: o.taux,
                  anneePrecedenteRealise: o.anneePrecedenteRealise,
                ),
          caJournalier: map(dto.caJournalier),
          caEvolution: map(dto.caEvolution),
          caComparaison: YearComparison(
            currentYear: c.anneeCourante,
            previousYear: c.anneePrecedente,
            current: map(c.series[c.anneeCourante.toString()] ?? const []),
            previous: map(c.series[c.anneePrecedente.toString()] ?? const []),
          ),
          topClients: map(dto.topClients),
          topProduits: map(dto.topProduits),
          caParFiliale: map(dto.caParFiliale),
          caParPays: map(dto.caParPays),
          recettesEvolution: map(dto.recettesEvolution),
          recettesParMode: map(dto.recettesParMode),
          soldeParCompte: map(dto.soldeParCompte),
          chargesParCategorie: map(dto.chargesParCategorie),
          chargesEvolution: map(dto.chargesEvolution),
        );
      });

  @override
  Future<Result<WorkingCapital>> workingCapital() => _guard(() async {
        final j = await _dashboardRemote.workingCapital();
        final m = j['metrics'] as Map<String, dynamic>? ?? const {};
        final w = j['weights'] as Map<String, dynamic>? ?? const {};
        final b = j['breakdown'] as Map<String, dynamic>? ?? const {};
        final d = j['diagnostic'] as Map<String, dynamic>? ?? const {};

        WcMetric metric(String key) {
          final e = m[key] as Map<String, dynamic>? ?? const {};
          return WcMetric(
            signal: WcSignal.fromWire(e['signal'] as String?),
            score: _num(e['score']),
          );
        }

        return WorkingCapital(
          fr: _num(j['fr']),
          bfr: _num(j['bfr']),
          tn: _num(j['tn']),
          overall: WcSignal.fromWire(j['overall'] as String?),
          score: (j['score'] as num?)?.toInt() ?? 0,
          frMetric: metric('fr'),
          bfrMetric: metric('bfr'),
          tnMetric: metric('tn'),
          frWeight: (w['fr'] as num?)?.toInt() ?? 0,
          bfrWeight: (w['bfr'] as num?)?.toInt() ?? 0,
          tnWeight: (w['tn'] as num?)?.toInt() ?? 0,
          diagnosticTitle: (d['title'] as String?) ?? '',
          diagnosticText: (d['text'] as String?) ?? '',
          tresorerie: _num(b['tresorerie']),
          creancesClients: _num(b['creances_clients']),
          stocks: _num(b['stocks']),
          dettesFournisseurs: _num(b['dettes_fournisseurs']),
        );
      });

  /// Un agrégat SQL peut remonter en chaîne décimale.
  static num _num(Object? v) => switch (v) {
        final num n => n,
        final String s => num.tryParse(s) ?? 0,
        _ => 0,
      };

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
