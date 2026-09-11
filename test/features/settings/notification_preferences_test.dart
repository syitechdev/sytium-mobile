import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/settings/application/notification_preferences_providers.dart';
import 'package:sytium_mobile/features/settings/data/dtos/notification_preferences_dtos.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences.dart';
import 'package:sytium_mobile/features/settings/domain/notification_preferences_repository.dart';
import 'package:sytium_mobile/features/settings/presentation/notification_preferences_screen.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/theme.dart';

const _pointageActif = NotificationPreferences(
  categories: [
    NotificationCategoryPreference(categorie: 'pointage', actif: true),
  ],
);

class _FakeRepo implements NotificationPreferencesRepository {
  _FakeRepo({
    this.initial = _pointageActif,
    this.failLoad = false,
    this.loadForever = false,
    this.failWrites = false,
  });

  final NotificationPreferences initial;
  final bool failLoad;
  final bool loadForever;
  final bool failWrites;

  int loads = 0;
  final categoryCalls = <(String, bool)>[];
  final quietCalls = <QuietHours?>[];
  late NotificationPreferences _etat = initial;

  @override
  Future<Result<NotificationPreferences>> load() {
    loads++;
    if (loadForever) return Completer<Result<NotificationPreferences>>().future;
    if (failLoad) return Future.value(const Err(UnknownFailure()));
    return Future.value(Ok(_etat));
  }

  @override
  Future<Result<NotificationPreferences>> setCategory(
    String categorie, {
    required bool actif,
  }) async {
    categoryCalls.add((categorie, actif));
    if (failWrites) return const Err(UnknownFailure());
    return Ok(_etat = _etat.withCategory(categorie, actif: actif));
  }

  @override
  Future<Result<NotificationPreferences>> setQuietHours(
    QuietHours? value,
  ) async {
    quietCalls.add(value);
    if (failWrites) return const Err(UnknownFailure());
    return Ok(_etat = _etat.withQuietHours(value));
  }
}

Widget _screen(NotificationPreferencesRepository repo) => ProviderScope(
  overrides: [
    notificationPreferencesRepositoryProvider.overrideWithValue(repo),
  ],
  child: MaterialApp(
    theme: AppTheme.light(),
    home: const NotificationPreferencesScreen(),
  ),
);

bool _switchDe(WidgetTester tester, String titre) => tester
    .widget<SwitchListTile>(find.widgetWithText(SwitchListTile, titre))
    .value;

void main() {
  group('DTO · contrat serveur', () {
    test("lit l'enveloppe du serveur", () {
      final dto = NotificationPreferencesEnvelopeDto.fromJson({
        'data': {
          'categories': [
            {'categorie': 'pointage', 'actif': false},
          ],
          'silence_debut': '22:00',
          'silence_fin': '07:00',
        },
      });

      expect(dto.data.categories.single.categorie, 'pointage');
      expect(dto.data.categories.single.actif, isFalse);
      expect(dto.data.silenceDebut, '22:00');
      expect(dto.data.silenceFin, '07:00');
    });

    test('retirer le silence envoie deux null EXPLICITES', () {
      // C'est l'envoi des deux cles a null qui efface le silence cote serveur.
      expect(const QuietHoursUpdateDto().toJson(), {
        'silence_debut': null,
        'silence_fin': null,
      });
    });

    test("couper une famille n'envoie jamais les cles du silence", () {
      // Cote serveur `categorie` est `sometimes|required` et le silence
      // exige ses deux bornes : melanger les deux corps donnerait un 422.
      expect(
        const NotificationCategoryUpdateDto(
          categorie: 'pointage',
          actif: false,
        ).toJson(),
        {'categorie': 'pointage', 'actif': false},
      );
    });
  });

  group('Contrôleur', () {
    ProviderContainer conteneur(_FakeRepo repo) {
      final c = ProviderContainer(
        overrides: [
          notificationPreferencesRepositoryProvider.overrideWithValue(repo),
        ],
      );
      // Garde le provider en vie entre deux lectures (autoDispose).
      final sub = c.listen(
        notificationPreferencesControllerProvider,
        (_, _) {},
      );
      addTearDown(sub.close);
      addTearDown(c.dispose);
      return c;
    }

    test("un échec remet l'interrupteur à sa place et rend l'échec", () async {
      final c = conteneur(_FakeRepo(failWrites: true));
      await c.read(notificationPreferencesControllerProvider.future);

      final echec = await c
          .read(notificationPreferencesControllerProvider.notifier)
          .setCategory('pointage', actif: false);

      expect(echec, isNotNull);
      // Un interrupteur qui mentirait sur ce qui est enregistré serait pire
      // qu'un interrupteur lent.
      expect(
        c
            .read(notificationPreferencesControllerProvider)
            .asData!
            .value
            .categories
            .single
            .actif,
        isTrue,
      );
    });

    test('un succès adopte l’état rendu par le serveur', () async {
      final repo = _FakeRepo();
      final c = conteneur(repo);
      await c.read(notificationPreferencesControllerProvider.future);

      final echec = await c
          .read(notificationPreferencesControllerProvider.notifier)
          .setQuietHours(QuietHours.defaut);

      expect(echec, isNull);
      expect(repo.quietCalls, [QuietHours.defaut]);
      expect(
        c
            .read(notificationPreferencesControllerProvider)
            .asData!
            .value
            .quietHours,
        QuietHours.defaut,
      );
    });
  });

  group('Écran · les 4 états', () {
    testWidgets('chargement → squelette, sans spinner ni erreur', (
      tester,
    ) async {
      await tester.pumpWidget(_screen(_FakeRepo(loadForever: true)));
      await tester.pump();

      expect(find.byType(ErrorState), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(SwitchListTile), findsNothing);
    });

    testWidgets('erreur → message et nouvel essai', (tester) async {
      final repo = _FakeRepo(failLoad: true);
      await tester.pumpWidget(_screen(repo));
      await tester.pumpAndSettle();

      expect(find.byType(ErrorState), findsOneWidget);
      final avant = repo.loads;
      await tester.tap(find.text('Réessayer'));
      await tester.pumpAndSettle();
      expect(repo.loads, greaterThan(avant));
    });

    testWidgets('vide → aucune famille coupable, le silence reste réglable', (
      tester,
    ) async {
      await tester.pumpWidget(
        _screen(_FakeRepo(initial: const NotificationPreferences())),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Aucune notification ne peut être coupée pour le moment.'),
        findsOneWidget,
      );
      expect(find.text('Activer les heures de silence'), findsOneWidget);
    });

    testWidgets('succès → les rappels de pointage et ce qui ne se coupe pas', (
      tester,
    ) async {
      await tester.pumpWidget(_screen(_FakeRepo()));
      await tester.pumpAndSettle();

      expect(find.text('Rappels de pointage'), findsOneWidget);
      expect(_switchDe(tester, 'Rappels de pointage'), isTrue);
      expect(find.textContaining('vous parviennent toujours'), findsOneWidget);
    });
  });

  group('Écran · interactions', () {
    testWidgets('couper les rappels de pointage', (tester) async {
      final repo = _FakeRepo();
      await tester.pumpWidget(_screen(repo));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Rappels de pointage'));
      await tester.pumpAndSettle();

      expect(repo.categoryCalls, [('pointage', false)]);
      expect(_switchDe(tester, 'Rappels de pointage'), isFalse);
    });

    testWidgets(
      "un échec d'enregistrement est dit, et l'interrupteur revient",
      (tester) async {
        await tester.pumpWidget(_screen(_FakeRepo(failWrites: true)));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Rappels de pointage'));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(_switchDe(tester, 'Rappels de pointage'), isTrue);
      },
    );

    testWidgets('activer le silence propose la nuit, 22:00 → 07:00', (
      tester,
    ) async {
      final repo = _FakeRepo();
      await tester.pumpWidget(_screen(repo));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Activer les heures de silence'));
      await tester.pumpAndSettle();

      expect(repo.quietCalls, [QuietHours.defaut]);
      expect(find.text('Début'), findsOneWidget);
      expect(find.text('22:00'), findsOneWidget);
      // Un creneau qui enjambe minuit se precise : « 22:00 a 07:00 » pourrait
      // se lire comme un creneau vide.
      expect(find.text('07:00 (lendemain)'), findsOneWidget);
    });

    testWidgets('désactiver le silence le retire', (tester) async {
      final repo = _FakeRepo(
        initial: const NotificationPreferences(quietHours: QuietHours.defaut),
      );
      await tester.pumpWidget(_screen(repo));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Activer les heures de silence'));
      await tester.pumpAndSettle();

      expect(repo.quietCalls, [null]);
      expect(find.text('Début'), findsNothing);
    });
  });
}
