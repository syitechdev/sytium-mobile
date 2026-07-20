import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/shell/presentation/quick_actions_sheet.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _kPhone = Size(390, 844);

Widget _host(MobileCapabilities caps) => ProviderScope(
  child: MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: ElevatedButton(
            onPressed: () => openQuickActions(context, capabilities: caps),
            child: const Text('ouvrir'),
          ),
        ),
      ),
    ),
  ),
);

MobileCapabilities _caps({
  bool financeWrite = false,
  bool commercial = false,
  bool leaveRequests = false,
  bool permissionRequests = false,
  bool weeklyObjectives = false,
}) => MobileCapabilities(
  dashboard: false,
  employeeSpace: true,
  messaging: true,
  weeklyObjectives: weeklyObjectives,
  leaveRequests: leaveRequests,
  permissionRequests: permissionRequests,
  approvals: false,
  commercial: commercial,
  finance: false,
  financeWrite: financeWrite,
);

Future<void> _open(WidgetTester tester, MobileCapabilities caps) async {
  await tester.pumpWidget(_host(caps));
  await tester.tap(find.text('ouvrir'));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .physicalSize = _kPhone;
    TestWidgetsFlutterBinding
        .instance
        .platformDispatcher
        .views
        .first
        .devicePixelRatio = 1.0;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetPhysicalSize();
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetDevicePixelRatio();
  });

  testWidgets('Pointer est toujours proposé', (tester) async {
    await _open(tester, _caps());
    expect(find.text('Pointer'), findsOneWidget);
  });

  testWidgets('un profil sans droit ne voit que Pointer', (tester) async {
    await _open(tester, _caps());

    expect(find.text('Enregistrer une facture'), findsNothing);
    expect(find.text('Ajouter une proforma'), findsNothing);
    expect(find.text('Encaissement / décaissement'), findsNothing);
    expect(find.text('Demander un congé'), findsNothing);
    expect(find.text('Demander une permission'), findsNothing);
    expect(find.text('Proposer des objectifs'), findsNothing);
  });

  testWidgets('financeWrite ouvre facture, proforma et caisse', (tester) async {
    await _open(tester, _caps(financeWrite: true));

    expect(find.text('Enregistrer une facture'), findsOneWidget);
    expect(find.text('Ajouter une proforma'), findsOneWidget);
    expect(find.text('Encaissement / décaissement'), findsOneWidget);
  });

  testWidgets('un commercial voit la proforma mais pas la facture ni la caisse',
      (tester) async {
    await _open(tester, _caps(commercial: true));

    expect(find.text('Ajouter une proforma'), findsOneWidget);
    // Facture (comptant) et caisse restent réservées à financeWrite.
    expect(find.text('Enregistrer une facture'), findsNothing);
    expect(find.text('Encaissement / décaissement'), findsNothing);
  });

  testWidgets('les demandes suivent leurs capacités', (tester) async {
    await _open(tester, _caps(leaveRequests: true));
    expect(find.text('Demander un congé'), findsOneWidget);
    expect(find.text('Demander une permission'), findsNothing);
  });

  testWidgets('une section sans action visible disparaît avec son titre',
      (tester) async {
    await _open(tester, _caps());
    // Aucune capacité finance : la section entière est masquée.
    expect(find.text('Ventes & caisse'), findsNothing);
    expect(find.text('Mes demandes'), findsNothing);
    // La section Présence reste, car Pointer est inconditionnel.
    expect(find.text('Présence'), findsOneWidget);
  });
}
