import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_radius.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/features/beacons/presentation/presence_sheet.dart';
import 'package:negarit_mobile/features/map/data/map_focus.dart';
import 'package:negarit_mobile/features/map/presentation/floor_plan_preview.dart';
import 'package:negarit_mobile/features/map/presentation/museum_map.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

const _facilitySlugs = <String>[
  'coffee',
  'restaurant',
  'parking',
  'restrooms',
  'exits',
];

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  var _inside = false;

  bool get _outdoorMapReady {
    if (kIsWeb) {
      return false;
    }
    return !WidgetsBinding.instance.runtimeType.toString().contains('Test');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final showInside = _inside || !_outdoorMapReady;
    final languageCode = Localizations.localeOf(context).languageCode;
    final selected = placeBySlug(ref.watch(mapFocusProvider) ?? '');
    final facilities = <VisitPlace>[
      for (final slug in _facilitySlugs) ?placeBySlug(slug),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            NegaritSpacing.lg,
            NegaritSpacing.lg,
            NegaritSpacing.lg,
            NegaritSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.tourTitle,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (_outdoorMapReady)
                _MapChip(
                  label: showInside ? l10n.mapAround : l10n.mapInside,
                  onPressed: () => setState(() => _inside = !_inside),
                ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: NegaritSpacing.lg),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(NegaritRadius.card),
              child: showInside
                  ? FloorPlanPreview(highlight: selected?.nameEn)
                  : MuseumMap(title: l10n.tourTitle),
            ),
          ),
        ),
        const SizedBox(height: NegaritSpacing.sm),
        Material(
          color: NegaritColors.surface,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              NegaritSpacing.lg,
              NegaritSpacing.md,
              NegaritSpacing.lg,
              NegaritSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showInside) ...[
                  Text(
                    l10n.chipZone,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: NegaritSpacing.sm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final place in facilities) ...[
                          _MapChip(
                            label: place.nameFor(languageCode),
                            selected: place.slug == selected?.slug,
                            onPressed: () => ref
                                .read(mapFocusProvider.notifier)
                                .show(place.slug),
                          ),
                          const SizedBox(width: NegaritSpacing.xs),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: NegaritSpacing.sm),
                ],
                Text(
                  showInside && selected != null
                      ? l10n.facilityOnVisit(selected.nameFor(languageCode))
                      : showInside
                      ? l10n.mapWaiting
                      : l10n.mapAroundBody,
                  style: textTheme.bodyMedium?.copyWith(
                    color: NegaritColors.textSecondary,
                  ),
                ),
                if (showInside && selected != null) ...[
                  const SizedBox(height: NegaritSpacing.xxs),
                  Text(
                    l10n.facilitySchematic,
                    style: textTheme.bodySmall?.copyWith(
                      color: NegaritColors.textSecondary,
                    ),
                  ),
                ],
                Row(
                  children: [
                    if (selected != null)
                      TextButton(
                        onPressed: () => context.push('/place/${selected.slug}'),
                        child: Text(l10n.facilityOpen),
                      ),
                    TextButton(
                      onPressed: () => showSimulatedPlaces(context),
                      child: Text(l10n.beaconHere),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MapChip extends StatelessWidget {
  const _MapChip({required this.label, this.onPressed, this.selected = false});

  final String label;
  final VoidCallback? onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? Colors.white : NegaritColors.text;
    return Material(
      color: selected ? NegaritColors.primary : NegaritColors.skyTop,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NegaritSpacing.md,
            vertical: NegaritSpacing.xs,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
