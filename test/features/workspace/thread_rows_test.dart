import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';

Message _msg(
  String id, {
  String author = 'peer',
  DateTime? at,
  bool system = false,
}) =>
    Message(
      id: id,
      channelId: 'c1',
      authorId: author,
      content: id,
      isSystem: system,
      createdAt: at,
    );

void main() {
  setUpAll(() async => initializeDateFormatting('fr_FR'));

  group('buildThreadRows', () {
    test('opens with a day marker and groups the same author', () {
      final rows = buildThreadRows([
        _msg('a', at: DateTime(2026, 6, 29, 9)),
        _msg('b', at: DateTime(2026, 6, 29, 9, 2)),
      ]);

      expect(rows, hasLength(3));
      expect(rows.first, isA<DayRow>());
      expect((rows[1] as MessageRow).startsGroup, isTrue);
      expect((rows[2] as MessageRow).startsGroup, isFalse);
    });

    test('inserts a marker on each new day and restarts the group', () {
      final rows = buildThreadRows([
        _msg('a', at: DateTime(2026, 6, 29, 23, 59)),
        _msg('b', at: DateTime(2026, 6, 30, 0, 1)),
      ]);

      expect(rows.whereType<DayRow>(), hasLength(2));
      // Two minutes apart, same author — but a day boundary always breaks the
      // block, otherwise the second day would open without an author name.
      expect((rows.last as MessageRow).startsGroup, isTrue);
    });

    test('breaks the group past the 5-minute window', () {
      final rows = buildThreadRows([
        _msg('a', at: DateTime(2026, 6, 29, 9)),
        _msg('b', at: DateTime(2026, 6, 29, 9, 6)),
      ]);

      expect((rows.last as MessageRow).startsGroup, isTrue);
    });

    test('breaks the group when the author changes', () {
      final rows = buildThreadRows([
        _msg('a', at: DateTime(2026, 6, 29, 9)),
        _msg('b', author: 'me', at: DateTime(2026, 6, 29, 9, 1)),
      ]);

      expect((rows.last as MessageRow).startsGroup, isTrue);
    });

    test('breaks the group around a system message', () {
      final rows = buildThreadRows([
        _msg('a', at: DateTime(2026, 6, 29, 9)),
        _msg('sys', at: DateTime(2026, 6, 29, 9, 1), system: true),
      ]);

      expect((rows.last as MessageRow).startsGroup, isTrue);
    });

    test('tolerates a message without a timestamp (no marker, own group)', () {
      final rows = buildThreadRows([
        _msg('a', at: DateTime(2026, 6, 29, 9)),
        _msg('b'),
      ]);

      // One marker only — the undated message cannot be placed in time.
      expect(rows.whereType<DayRow>(), hasLength(1));
      expect((rows.last as MessageRow).startsGroup, isTrue);
    });

    test('returns nothing for an empty thread', () {
      expect(buildThreadRows(const []), isEmpty);
    });
  });

  group('dayLabel', () {
    final now = DateTime(2026, 7, 21, 14, 30);

    test('names today and yesterday', () {
      expect(dayLabel(DateTime(2026, 7, 21, 8), now), 'Aujourd’hui');
      expect(dayLabel(DateTime(2026, 7, 20, 23), now), 'Hier');
    });

    test('uses the weekday within the last week', () {
      // 2026-07-17 is a Friday.
      expect(dayLabel(DateTime(2026, 7, 17), now), 'vendredi');
    });

    test('falls back to the full date beyond a week', () {
      expect(dayLabel(DateTime(2026, 6, 29), now), '29 juin 2026');
    });
  });
}
