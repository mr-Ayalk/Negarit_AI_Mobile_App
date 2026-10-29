import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
        Text(
          l10n.navFavorites,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: NegaritSpacing.lg),
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
        ),
      ],
    );
  }
}
