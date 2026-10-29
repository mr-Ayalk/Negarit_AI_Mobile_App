import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_background.dart';
import 'package:negarit_mobile/core/widgets/negarit_button.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';
import 'package:negarit_mobile/features/visit/data/saved_places_controller.dart';
import 'package:negarit_mobile/features/visit/data/visit_labels.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class PlaceScreen extends ConsumerWidget {
  const PlaceScreen({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final place = placeBySlug(slug);
    final saved = ref.watch(savedPlacesProvider).value ?? const <String>[];
    final languageCode = Localizations.localeOf(context).languageCode;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NegaritBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(NegaritSpacing.lg),
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              if (place == null)
                Text(
                  l10n.placeMissing,
                  style: textTheme.titleMedium,
                )
              else ...[
                Text(
                  place.nameFor(languageCode),
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: NegaritSpacing.xs),
                Text(
                  placeTypeLabel(l10n, place),
                  style: textTheme.bodyMedium?.copyWith(
                    color: NegaritColors.textSecondary,
                  ),
                ),
                const SizedBox(height: NegaritSpacing.lg),
                NegaritCard(
                  child: Text(
                    l10n.placeStoryMissing,
                    style: textTheme.bodyMedium?.copyWith(
                      color: NegaritColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: NegaritSpacing.lg),
                NegaritButton(
                  label: saved.contains(place.slug)
                      ? l10n.placeSaved
                      : l10n.placeSave,
                  onPressed: () => ref
                      .read(savedPlacesProvider.notifier)
                      .toggle(place.slug),
                ),
                const SizedBox(height: NegaritSpacing.sm),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => context.go('/map'),
                    child: Text(l10n.openMap),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
