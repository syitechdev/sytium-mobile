import 'package:flutter/material.dart';
import 'package:sytium_mobile/features/approvals/presentation/approvals_screen.dart';
import 'package:sytium_mobile/features/commercial/presentation/commercial_dashboard_screen.dart';
import 'package:sytium_mobile/features/finance/presentation/finance_dashboard_screen.dart';
import 'package:sytium_mobile/features/objectives/presentation/objectives_screen.dart';
import 'package:sytium_mobile/features/requests/presentation/requests_screen.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Maps a backend `feature_key` (as sent by MobileModuleResolver) to a human
/// label of its destination. Keys are the real module feature_keys, not
/// capability flag names.
String moduleDestinationLabel(String? featureKey) => switch (featureKey) {
  'objectives' => 'Mes objectifs',
  'requests' => 'Mes congés & permissions',
  'employee_space' => 'Mon espace',
  'approvals' => 'Approbations',
  'commercial' => 'Tableau de bord commercial',
  'finance' => 'Tableau de bord financier',
  _ => 'Bientôt disponible',
};

/// Pushes the destination for [featureKey]. `objectives` opens ObjectivesScreen,
/// `requests` opens RequestsScreen; employee_space and unknown keys use a titled
/// "bientôt" placeholder.
void navigateForModule(BuildContext context, String? featureKey) {
  final destination = switch (featureKey) {
    'objectives' => const ObjectivesScreen(),
    'requests' => const RequestsScreen(),
    'approvals' => const ApprovalsScreen(),
    'commercial' => const CommercialDashboardScreen(),
    'finance' => const FinanceDashboardScreen(),
    // employee_space lands in a later sub-project.
    _ => _ComingSoonScreen(title: moduleDestinationLabel(featureKey)),
  };
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => destination),
  );
}

class _ComingSoonScreen extends StatelessWidget {
  const _ComingSoonScreen({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(Tokens.space24),
          child: Text(
            'Cette fonctionnalité arrive bientôt.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
