import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';
import 'package:negarit_mobile/features/map/presentation/floor_plan_preview.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Stack(
      children: [
        const FloorPlanPreview(),
        Positioned(
          top: NegaritSpacing.md,
          left: NegaritSpacing.md,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: NegaritColors.surface,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: NegaritSpacing.md,
                vertical: NegaritSpacing.xs,
              ),
              child: Text(
                l10n.mapPreview,
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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
                  l10n.mapWaiting,
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
