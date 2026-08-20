import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/features/employee_space/application/employee_space_providers.dart';
import 'package:sytium_mobile/features/employee_space/data/dtos/employee_space_dtos.dart';
import 'package:sytium_mobile/features/employee_space/presentation/employee_space_screen.dart';
import 'package:sytium_mobile/theme/theme.dart';

/// « Mon espace » minimaliste : la fiche, les bulletins, les documents
/// personnels et le règlement intérieur.

const _profile = EmployeeProfileDto(
  id: 'e1',
  matricule: 'NTL-SYI-000010',
  nom: 'KOUAKOU',
  prenoms: 'Kouablan Assiahue',
  identite: EmployeeIdentityDto(
    dateNaissance: '1989-06-05',
    lieuNaissance: 'EBILASSOKRO',
    nationalite: 'Ivoirienne',
  ),
  contrat: EmployeeContractDto(
    dateEmbauche: '2025-03-17',
    typeContrat: 'CDD',
    fonction: 'DEVELOPPEUR',
    poste: 'CHIEF TECHNICAL OFFICER',
  ),
  remuneration: EmployeePayDto(salaireBase: 230918),
  contacts: EmployeeContactsDto(telephone: '+225 07 09 72 78 21'),
);

Widget _host({
  EmployeeProfileDto? profile = _profile,
  List<MyPayslipDto> payslips = const [],
  List<MyDocumentDto> documents = const [],
  InternalRegulationDto? regulation,
}) => ProviderScope(
  overrides: [
    myProfileProvider.overrideWith((ref) async => profile),
    myPayslipsProvider.overrideWith((ref) async => payslips),
    myDocumentsProvider.overrideWith((ref) async => documents),
    myInternalRegulationProvider.overrideWith((ref) async => regulation),
  ],
  child: MaterialApp(theme: AppTheme.dark(), home: const EmployeeSpaceScreen()),
);

/// Le montant est-il affiché, quel que soit le séparateur de milliers ?
bool _montantAffiche(WidgetTester tester, String chiffres) => tester
    .widgetList<Text>(find.byType(Text))
    .any(
      (t) =>
          (t.data ?? '').replaceAll(RegExp('[^0-9]'), '').contains(chiffres),
    );

void main() {
  setUpAll(() => initializeDateFormatting('fr'));

  testWidgets('les informations reprennent identité, contrat et paie', (
    tester,
  ) async {
    await tester.pumpWidget(_host());
    await tester.pumpAndSettle();

    expect(find.text('KOUAKOU Kouablan Assiahue'), findsOneWidget);
    expect(find.text('CHIEF TECHNICAL OFFICER'), findsOneWidget);
    expect(find.text('17/03/2025'), findsOneWidget);
    // `NumberFormat` sépare les milliers par une espace insécable étroite :
    // chercher une espace ordinaire ne trouverait rien.
    expect(_montantAffiche(tester, '230918'), isTrue);
  });

  testWidgets('une case vide ne s’affiche pas', (tester) async {
    await tester.pumpWidget(_host());
    await tester.pumpAndSettle();

    // Le sursalaire vaut zéro et la situation matrimoniale est absente : une
    // liste de tirets ne renseigne personne.
    expect(find.text('Sursalaire'), findsNothing);
    expect(find.text('Situation matrimoniale'), findsNothing);
  });

  testWidgets('un compte sans fiche RH le dit', (tester) async {
    await tester.pumpWidget(_host(profile: null));
    await tester.pumpAndSettle();

    expect(
      find.text("Aucune fiche salarié n'est rattachée à ce compte."),
      findsOneWidget,
    );
  });

  testWidgets('les bulletins montrent brut, retenues et net', (tester) async {
    await tester.pumpWidget(
      _host(
        payslips: const [
          MyPayslipDto(
            id: 'p1',
            periode: '2026-07',
            gross: 300000,
            deductions: 50000,
            netToPay: 250000,
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bulletins'));
    await tester.pumpAndSettle();

    expect(find.textContaining('juillet 2026'), findsOneWidget);
    expect(find.text('Salaire brut'), findsOneWidget);
    expect(find.text('Net à payer'), findsOneWidget);
  });

  testWidgets('sans bulletin validé, l’écran le dit', (tester) async {
    await tester.pumpWidget(_host());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bulletins'));
    await tester.pumpAndSettle();

    expect(find.text('Aucun bulletin validé pour l’instant.'), findsOneWidget);
  });

  testWidgets('les documents personnels se listent', (tester) async {
    await tester.pumpWidget(
      _host(
        documents: const [
          MyDocumentDto(
            id: 'd1',
            nom: 'Contrat de travail',
            categorie: 'contrat',
            date: '2025-03-17',
            storagePath: 'uploads/org/employee-documents/c.pdf',
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Documents'));
    await tester.pumpAndSettle();

    expect(find.text('Contrat de travail'), findsOneWidget);
    expect(find.textContaining('contrat · 17/03/2025'), findsOneWidget);
  });

  testWidgets('le règlement affiche sa version et l’état de la signature', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        regulation: const InternalRegulationDto(
          id: 'r1',
          titre: 'Règlement intérieur 2026',
          version: 'V2',
          publishedAt: '2026-01-15',
          storagePath: 'uploads/org/internal-regulations/ri.pdf',
          acknowledgement: RegulationAckDto(status: 'pending'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Règlement'));
    await tester.pumpAndSettle();

    expect(find.text('Règlement intérieur 2026'), findsOneWidget);
    expect(find.textContaining('Version V2'), findsOneWidget);
    // Non signé : on le dit, et on dit où signer.
    expect(find.text('Signature en attente'), findsOneWidget);
  });

  testWidgets('sans règlement publié, l’écran le dit', (tester) async {
    await tester.pumpWidget(_host());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Règlement'));
    await tester.pumpAndSettle();

    expect(
      find.text("Aucun règlement intérieur n'est publié."),
      findsOneWidget,
    );
  });
}
