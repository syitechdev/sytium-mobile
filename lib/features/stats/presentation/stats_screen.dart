import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/my_activity_view.dart';
import 'package:sytium_mobile/features/stats/presentation/widgets/organisation_stats_view.dart';
import 'package:sytium_mobile/shared/widgets/minimal_tabs.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// The two panes of the adaptive Stats tab.
enum StatsTab { organisation, myActivity }

/// Stats tab. Profiles with `capabilities.dashboard` get a
/// « Organisation | Mon activité » toggle (default Organisation); everyone else
/// sees « mes heures » (Mon activité) directly with no toggle.
class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  StatsTab _tab = StatsTab.organisation;

  bool _canSeeDashboard() {
    final auth = ref.watch(authControllerProvider).valueOrNull;
    return auth is Authenticated && auth.session.capabilities.dashboard;
  }

  @override
  Widget build(BuildContext context) {
    if (!_canSeeDashboard()) {
      // No dashboard capability → the plain « mes heures » screen, no toggle.
      return const MyActivityView();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Tokens.space16,
            Tokens.space16,
            Tokens.space16,
            0,
          ),
          child: MinimalTabs<StatsTab>(
            selected: _tab,
            onSelected: (t) => setState(() => _tab = t),
            tabs: const [
              MinimalTab(value: StatsTab.organisation, label: 'Organisation'),
              MinimalTab(value: StatsTab.myActivity, label: 'Mon activité'),
            ],
          ),
        ),
        Expanded(
          child: _tab == StatsTab.organisation
              ? const OrganisationStatsView()
              : const MyActivityView(),
        ),
      ],
    );
  }
}
