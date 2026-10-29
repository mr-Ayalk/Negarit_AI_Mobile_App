import 'package:flutter/material.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/empty_state.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(NegaritSpacing.lg),
        children: [
          Text(
            l10n.exploreGreeting,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: NegaritSpacing.lg),
          EmptyState(
            title: l10n.exploreEmptyTitle,
            body: l10n.exploreEmptyBody,
          ),
        ],
      ),
    );
  }
}
