import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/features/beacons/data/beacon_engine.dart';
import 'package:negarit_mobile/features/beacons/data/presence_controller.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

Future<void> showSimulatedPlaces(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: NegaritColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      final languageCode = Localizations.localeOf(context).languageCode;
      return Consumer(
        builder: (context, ref, child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(NegaritSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.beaconHere,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: NegaritSpacing.xs),
                  Text(
                    l10n.beaconSimulated,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: NegaritColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: NegaritSpacing.xxs),
                  Text(
                    l10n.beaconChoose,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: NegaritColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: NegaritSpacing.sm),
                  for (final place in adwaPlaces)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(place.nameFor(languageCode)),
                      onTap: () {
                        ref.read(presenceProvider.notifier).choose(place.slug);
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

String presenceMessage(
  AppLocalizations l10n,
  PresenceNotice notice,
  String? destination,
  String languageCode,
) {
  if (notice.kind == 'welcome') {
    return l10n.beaconWelcome(visitorLabel(destination, l10n.guestLabel));
  }
  if (notice.kind == 'cooldown') {
    return l10n.beaconCooldown;
  }
  final place = placeBySlug(notice.zoneSlug);
  return l10n.beaconAt(place?.nameFor(languageCode) ?? notice.zoneSlug);
}
