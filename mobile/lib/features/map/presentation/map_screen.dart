import 'package:flutter/material.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/empty_state.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(NegaritSpacing.lg),
        children: [
          EmptyState(title: l10n.mapEmptyTitle, body: l10n.mapEmptyBody),
        ],
      ),
    );
  }
}
