import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/home/presentation/widgets/activity_ring_card.dart';
import 'package:sytium_mobile/features/stats/application/stats_providers.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_models.dart';
import 'package:sytium_mobile/features/stats/domain/dashboard_series_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_models.dart';
import 'package:sytium_mobile/features/stats/domain/stats_repository.dart';
import 'package:sytium_mobile/features/stats/domain/working_capital_models.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kEmployee = AttendanceEmployee(id: 'e1', nom: 'Koffi', prenoms: 'Ama');

/// Ne sert que le récapitulatif mensuel : le reste de l'écran n'est pas monté.
class _Repo implements StatsRepository {

  const _Repo(this.summary);

  @override
  Future<Result<WorkingCapital>> workingCapital() =>
      Completer<Result<WorkingCapital>>().future;

  final MonthlyAttendance summary;

  @override
  Future<Result<MonthlyAttendance>> attendanceSummary(String month) async =>
      Ok(summary);

  @override
  Future<Result<DashboardKpis>> dashboard(DashboardPeriod period) async =>
      throw UnimplementedError();

  @override
  Future<Result<DashboardSeries>> dashboardSeries() async =>
      throw UnimplementedError();
}

Future<void> _pump(WidgetTester tester, MonthlyAttendance summary) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [statsRepositoryProvider.overrideWithValue(_Repo(summary))],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: ActivityRingCard()),
      ),
    ),
  );
  await tester.pump();
}

String get _thisMonth => DateFormat('yyyy-MM').format(DateTime.now());

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  testWidgets('la section s’affiche même sans heure encore travaillée', (
    tester,
  ) async {
    // Tout le monde est employé : un mois qui commence à zéro reste une
    // information, la carte ne doit plus disparaître.
    await _pump(
      tester,
      MonthlyAttendance(
        month: _thisMonth,
        employee: _kEmployee,
        heuresAttendues: 16,
      ),
    );

    expect(find.text('Mon activité'), findsOneWidget);
    expect(find.text('0 h'), findsWidgets);
  });

  testWidgets('un mois sans rien d’attendu n’affiche pas 0 % de présence', (
    tester,
  ) async {
    // Le 1er du mois, rien n'est encore attendu : « 0 % » se lirait comme une
    // absence totale alors qu'il n'y a rien à comparer.
    await _pump(
      tester,
      MonthlyAttendance(month: _thisMonth, employee: _kEmployee),
    );

    expect(find.text('—'), findsOneWidget);
    expect(find.text('0 %'), findsNothing);
  });

  testWidgets('le taux de présence se calcule sur les heures attendues', (
    tester,
  ) async {
    await _pump(
      tester,
      MonthlyAttendance(
        month: _thisMonth,
        employee: _kEmployee,
        heuresTravaillees: 12,
        heuresAttendues: 16,
      ),
    );

    expect(find.text('75 %'), findsOneWidget);
    expect(find.text('12 h'), findsOneWidget);
  });

  testWidgets('sans fiche employé, la carte ne s’affiche pas', (tester) async {
    // Le serveur ne renvoie aucune ligne : rien à montrer, et « Statut du jour »
    // annonce déjà que le profil RH n'est pas lié.
    await _pump(tester, MonthlyAttendance(month: _thisMonth));

    expect(find.text('Mon activité'), findsNothing);
  });
}
