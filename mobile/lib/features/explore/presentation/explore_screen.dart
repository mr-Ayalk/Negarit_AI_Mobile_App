import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_radius.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';
import 'package:negarit_mobile/core/widgets/negarit_chip.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
        const _SparkMark(),
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
        Wrap(
          alignment: WrapAlignment.center,
          spacing: NegaritSpacing.xs,
          runSpacing: NegaritSpacing.xs,
          children: [
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
        Row(
          children: [
            Expanded(
              child: NegaritCard(
                child: _Suggestion(
                  icon: Icons.menu_book_outlined,
                  title: l10n.suggestedStories,
                  body: l10n.notLoaded,
                ),
              ),
            ),
            const SizedBox(width: NegaritSpacing.sm),
            Expanded(
              child: NegaritCard(
                child: _Suggestion(
                  icon: Icons.headphones_outlined,
                  title: l10n.suggestedAudio,
                  body: l10n.notLoaded,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: NegaritSpacing.lg),
        _TourCard(l10n: l10n),
      ],
    );
  }
}

class _SparkMark extends StatelessWidget {
  const _SparkMark();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: NegaritColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: NegaritColors.primary.withValues(alpha: 0.28),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const SizedBox(
          width: 84,
          height: 84,
          child: Icon(Icons.auto_awesome, color: Colors.white, size: 36),
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
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          NegaritColors.skyBottom,
                          NegaritColors.primary,
                        ],
                      ),
                    ),
                  ),
                  const Positioned(right: -24, top: -36, child: _SoftOrb()),
                  Padding(
                    padding: const EdgeInsets.all(NegaritSpacing.md),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Wrap(
                        spacing: NegaritSpacing.xs,
                        runSpacing: NegaritSpacing.xs,
                        children: [
                          _HeroPill(
                            icon: Icons.play_arrow_rounded,
                            label: l10n.playAudio,
                            filled: true,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.audioUnavailable)),
                              );
                            },
                          ),
                          _HeroPill(
                            icon: Icons.map_outlined,
                            label: l10n.openMap,
                            filled: false,
                            onPressed: () => context.go('/map'),
                          ),
                        ],
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

class _SoftOrb extends StatelessWidget {
  const _SoftOrb();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.18),
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
      color: filled ? NegaritColors.text : NegaritColors.surface,
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
