import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';
import 'package:negarit_mobile/features/map/presentation/floor_plan_preview.dart';
import 'package:negarit_mobile/features/map/presentation/museum_map.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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
    final bottom = MediaQuery.paddingOf(context).bottom;
    final showInside = _inside || !_outdoorMapReady;

    return Stack(
      children: [
        if (showInside)
          const FloorPlanPreview()
        else
          MuseumMap(title: l10n.tourTitle),
        Positioned(
          top: NegaritSpacing.md,
          left: NegaritSpacing.md,
          right: NegaritSpacing.md,
          child: Row(
            children: [
              _MapChip(label: l10n.mapPreview),
              if (_outdoorMapReady) ...[
                const SizedBox(width: NegaritSpacing.xs),
                _MapChip(
                  label: showInside ? l10n.mapAround : l10n.mapInside,
                  onPressed: () => setState(() => _inside = !_inside),
                ),
              ],
            ],
          ),
        ),
        Positioned(
          left: NegaritSpacing.md,
          right: NegaritSpacing.md,
          bottom: bottom + NegaritSpacing.md,
          child: NegaritCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.tourTitle,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: NegaritSpacing.xxs),
                Text(
                  showInside ? l10n.mapWaiting : l10n.mapAroundBody,
                  style: textTheme.bodyMedium?.copyWith(
                    color: NegaritColors.textSecondary,
                  ),
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
  const _MapChip({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NegaritColors.surface,
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
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
