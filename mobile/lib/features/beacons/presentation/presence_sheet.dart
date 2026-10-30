import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_button.dart';
import 'package:negarit_mobile/features/beacons/data/beacon_engine.dart';
import 'package:negarit_mobile/features/beacons/data/place_code.dart';
import 'package:negarit_mobile/features/beacons/data/presence_controller.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

Future<void> showSimulatedPlaces(BuildContext hostContext) {
  return showModalBottomSheet<void>(
    context: hostContext,
    isScrollControlled: true,
    backgroundColor: NegaritColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return _SimulatedPlacesSheet(hostContext: hostContext);
    },
  );
}

class _SimulatedPlacesSheet extends ConsumerStatefulWidget {
  const _SimulatedPlacesSheet({required this.hostContext});

  final BuildContext hostContext;

  @override
  ConsumerState<_SimulatedPlacesSheet> createState() =>
      _SimulatedPlacesSheetState();
}

class _SimulatedPlacesSheetState extends ConsumerState<_SimulatedPlacesSheet> {
  final _code = TextEditingController();
  var _unknown = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _open(String slug) {
    ref.read(presenceProvider.notifier).choose(slug);
    Navigator.of(context).pop();
    widget.hostContext.push('/place/$slug');
  }

  void _useCode() {
    final slug = placeSlugFromCode(_code.text);
    if (slug == null) {
      setState(() => _unknown = true);
      return;
    }
    _open(slug);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          NegaritSpacing.lg,
          NegaritSpacing.lg,
          NegaritSpacing.lg,
          NegaritSpacing.lg + MediaQuery.viewInsetsOf(context).bottom,
        ),
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
            const SizedBox(height: NegaritSpacing.sm),
            Text(
              l10n.placeCodeHelp,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: NegaritColors.textSecondary,
              ),
            ),
            const SizedBox(height: NegaritSpacing.xs),
            TextField(
              controller: _code,
              decoration: InputDecoration(hintText: l10n.placeCodeHint),
              textInputAction: TextInputAction.done,
              onChanged: (_) {
                if (_unknown) {
                  setState(() => _unknown = false);
                }
              },
              onSubmitted: (_) => _useCode(),
            ),
            if (_unknown) ...[
              const SizedBox(height: NegaritSpacing.xs),
              Text(
                l10n.placeCodeUnknown,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: NegaritColors.primaryDark,
                ),
              ),
            ],
            const SizedBox(height: NegaritSpacing.sm),
            NegaritButton(label: l10n.placeCodeUse, onPressed: _useCode),
            const SizedBox(height: NegaritSpacing.md),
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
                onTap: () => _open(place.slug),
              ),
          ],
        ),
      ),
    );
  }
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
