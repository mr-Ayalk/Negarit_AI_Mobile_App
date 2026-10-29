import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';
import 'package:negarit_mobile/features/visit/data/saved_places_controller.dart';
import 'package:negarit_mobile/features/visit/data/visit_labels.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final languageCode = Localizations.localeOf(context).languageCode;
    final saved = ref.watch(savedPlacesProvider).value ?? const <String>[];
    final places = <VisitPlace>[
      for (final slug in saved) ?placeBySlug(slug),
    ];

    return ListView(
      padding: EdgeInsets.fromLTRB(
        NegaritSpacing.lg,
        NegaritSpacing.xl,
        NegaritSpacing.lg,
        bottom + NegaritSpacing.lg,
      ),
      children: [
        Text(
          l10n.navFavorites,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: NegaritSpacing.lg),
        if (places.isEmpty)
          NegaritCard(
            child: Column(
              children: [
                const Icon(
                  Icons.favorite_outline,
                  color: NegaritColors.primary,
                  size: 32,
                ),
                const SizedBox(height: NegaritSpacing.sm),
                Text(
                  l10n.favoritesEmptyTitle,
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: NegaritSpacing.xs),
                Text(
                  l10n.favoritesEmptyBody,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: NegaritColors.textSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          NegaritCard(
            padding: EdgeInsets.zero,
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  for (var index = 0; index < places.length; index++) ...[
                    if (index > 0) const Divider(height: 1),
                    ListTile(
                      title: Text(places[index].nameFor(languageCode)),
                      subtitle: Text(placeTypeLabel(l10n, places[index])),
                      onTap: () => context.push('/place/${places[index].slug}'),
                      trailing: IconButton(
                        tooltip: l10n.favoritesRemove,
                        onPressed: () => ref
                            .read(savedPlacesProvider.notifier)
                            .toggle(places[index].slug),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
