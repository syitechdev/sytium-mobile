import 'package:flutter/foundation.dart';

/// Org « pouls de l'équipe »: today's team attendance + project-task completion.
@immutable
class TeamPulse {
  const TeamPulse({
    required this.present,
    required this.effectif,
    required this.pointageTaux,
    required this.tachesDone,
    required this.tachesTotal,
    required this.tachesTaux,
  });

  final int present;
  final int effectif;

  /// 0–100.
  final double pointageTaux;
  final int tachesDone;
  final int tachesTotal;

  /// 0–100.
  final double tachesTaux;
}
