import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_radius.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';
import 'package:negarit_mobile/core/widgets/negarit_chip.dart';
import 'package:negarit_mobile/features/beacons/data/presence_controller.dart';
import 'package:negarit_mobile/features/beacons/presentation/presence_sheet.dart';
import 'package:negarit_mobile/features/visit/data/interests_controller.dart';
import 'package:negarit_mobile/features/visit/data/saved_places_controller.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final saved = ref.watch(savedPlacesProvider).value ?? const <String>[];
    final interests = ref.watch(interestsProvider).value ?? const <String>[];
    final matches = placesForInterests(interests);
    final presence = ref.watch(presenceProvider);
    final currentPlace = presence == null
        ? null
        : placeBySlug(presence.zoneSlug);
    final textTheme = Theme.of(context).textTheme;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        NegaritSpacing.lg,
        NegaritSpacing.xl,
        NegaritSpacing.lg,
        bottom + NegaritSpacing.lg,
      ),
      children: [
        const _BrandMark(),
        const SizedBox(height: NegaritSpacing.lg),
        Text(
          l10n.exploreHello,
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text.rich(
          TextSpan(
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(text: l10n.explorePromptLead),
              TextSpan(
                text: l10n.explorePromptEmphasis,
                style: const TextStyle(color: NegaritColors.primary),
              ),
              TextSpan(text: l10n.explorePromptEnd),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: NegaritSpacing.xs),
        Text(
          l10n.exploreSubtitle,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: NegaritColors.textSecondary,
          ),
        ),
        const SizedBox(height: NegaritSpacing.lg),
        if (presence != null && currentPlace != null) ...[
          GestureDetector(
            onTap: () => context.push('/place/${presence.zoneSlug}'),
            child: NegaritCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentPlace.nameFor(languageCode),
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: NegaritSpacing.xs),
                  Text(
                    l10n.beaconSimulated,
                    style: textTheme.bodySmall?.copyWith(
                      color: NegaritColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: NegaritSpacing.lg),
        ],
        Wrap(
          alignment: WrapAlignment.center,
          spacing: NegaritSpacing.xs,
          runSpacing: NegaritSpacing.xs,
          children: [
            NegaritChip(
              icon: Icons.place_outlined,
              label: l10n.beaconHere,
              onPressed: () => showSimulatedPlaces(context),
            ),
            NegaritChip(
              icon: Icons.chat_bubble_outline,
              label: l10n.chipAsk,
              onPressed: () => context.push('/guide'),
            ),
            NegaritChip(
              icon: Icons.route_outlined,
              label: l10n.chipTour,
              onPressed: () => context.go('/map'),
            ),
            NegaritChip(
              icon: Icons.place_outlined,
              label: l10n.chipZone,
              onPressed: () => context.go('/map'),
            ),
            NegaritChip(
              icon: Icons.favorite_outline,
              label: l10n.chipSaved,
              onPressed: () => context.go('/favorites'),
            ),
          ],
        ),
        const SizedBox(height: NegaritSpacing.xl),
        Text(
          l10n.suggestedTitle,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: NegaritSpacing.sm),
        if (matches.isNotEmpty) ...[
          Text(
            l10n.suggestedInterests,
            style: textTheme.bodyMedium?.copyWith(
              color: NegaritColors.textSecondary,
            ),
          ),
          const SizedBox(height: NegaritSpacing.sm),
          Wrap(
            spacing: NegaritSpacing.xs,
            runSpacing: NegaritSpacing.xs,
            children: [
              for (final place in matches)
                ActionChip(
                  label: Text(place.nameFor(languageCode)),
                  onPressed: () => context.push('/place/${place.slug}'),
                ),
            ],
          ),
          const SizedBox(height: NegaritSpacing.sm),
        ],
        Row(
          children: [
            Expanded(
              child: NegaritCard(
                child: _Suggestion(
                  icon: Icons.menu_book_outlined,
                  title: l10n.suggestedStories,
                  body: l10n.visitCountBody,
                ),
              ),
            ),
            const SizedBox(width: NegaritSpacing.sm),
            Expanded(
              child: NegaritCard(
                child: _Suggestion(
                  icon: Icons.headphones_outlined,
                  title: l10n.suggestedAudio,
                  body: l10n.visitMapBody,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: NegaritSpacing.lg),
        Text(
          l10n.stopsHeading,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: NegaritSpacing.xxs),
        Text(
          l10n.stopsBody,
          style: textTheme.bodyMedium?.copyWith(
            color: NegaritColors.textSecondary,
          ),
        ),
        const SizedBox(height: NegaritSpacing.sm),
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: adwaPlaces.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: NegaritSpacing.xs),
            itemBuilder: (context, index) {
              final place = adwaPlaces[index];
              final isSaved = saved.contains(place.slug);
              return Material(
                color: NegaritColors.surface,
                borderRadius: BorderRadius.circular(999),
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => context.push('/place/${place.slug}'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: NegaritSpacing.md,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(place.nameFor(languageCode)),
                        if (isSaved) ...[
                          const SizedBox(width: NegaritSpacing.xxs),
                          const Icon(
                            Icons.favorite,
                            size: 16,
                            color: NegaritColors.primary,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: NegaritSpacing.lg),
        _TourCard(l10n: l10n),
      ],
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(NegaritRadius.card),
          boxShadow: [
            BoxShadow(
              color: NegaritColors.primary.withValues(alpha: 0.22),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(NegaritRadius.card),
          child: Image.asset(
            'assets/brand/logo.png',
            width: 148,
            height: 148,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _Suggestion extends StatelessWidget {
  const _Suggestion({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: NegaritColors.primary),
        const SizedBox(height: NegaritSpacing.sm),
        Text(
          title,
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: NegaritSpacing.xxs),
        Text(
          body,
          style: textTheme.bodySmall?.copyWith(
            color: NegaritColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _TourCard extends StatelessWidget {
  const _TourCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: NegaritColors.surface,
        borderRadius: BorderRadius.circular(NegaritRadius.card),
        boxShadow: [
          BoxShadow(
            color: NegaritColors.primary.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(NegaritRadius.card),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 176,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/brand/logo.png',
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x00000000), NegaritColors.night],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(NegaritSpacing.md),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: _HeroPill(
                        icon: Icons.map_outlined,
                        label: l10n.openMap,
                        filled: true,
                        onPressed: () => context.go('/map'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(NegaritSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.tourTitle,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: NegaritSpacing.xs),
                  Text(
                    l10n.tourBody,
                    style: textTheme.bodyMedium?.copyWith(
                      color: NegaritColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.icon,
    required this.label,
    required this.filled,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool filled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final foreground = filled ? Colors.white : NegaritColors.text;
    return Material(
      color: filled ? NegaritColors.primary : NegaritColors.surface,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NegaritSpacing.sm,
            vertical: NegaritSpacing.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: foreground),
              const SizedBox(width: NegaritSpacing.xxs),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(color: foreground, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
