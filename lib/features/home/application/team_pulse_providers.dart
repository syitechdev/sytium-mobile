import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/home/domain/team_pulse.dart';

part 'team_pulse_providers.g.dart';

double _d(Object? v) => switch (v) {
      final num n => n.toDouble(),
      final String s => double.tryParse(s) ?? 0,
      _ => 0,
    };

int _i(Object? v) => switch (v) {
      final num n => n.toInt(),
      final String s => int.tryParse(s) ?? 0,
      _ => 0,
    };

/// Org team pulse (attendance + task completion) for the Stats tab.
@riverpod
Future<TeamPulse> teamPulse(Ref ref) async {
  final dio = ref.watch(authDioProvider);
  final res = await dio.get<Map<String, dynamic>>('/mobile/team-pulse');
  final data = res.data!['data'] as Map<String, dynamic>;
  final p = (data['pointage'] as Map<String, dynamic>?) ?? const {};
  final t = (data['taches'] as Map<String, dynamic>?) ?? const {};
  return TeamPulse(
    present: _i(p['present']),
    effectif: _i(p['effectif']),
    pointageTaux: _d(p['taux']),
    tachesDone: _i(t['terminees']),
    tachesTotal: _i(t['total']),
    tachesTaux: _d(t['taux']),
  );
}
