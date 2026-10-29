import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        const Center(child: _BrandMark()),
        const SizedBox(height: NegaritSpacing.md),
        Text(
          l10n.guestLabel,
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: NegaritSpacing.xs),
        Text(
          l10n.profileEmptyBody,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: NegaritColors.textSecondary,
          ),
        ),
        const SizedBox(height: NegaritSpacing.lg),
        NegaritCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _ProfileRow(
                label: l10n.profileVisit,
                value: l10n.profileVisitValue,
              ),
              const Divider(height: 1),
              _ProfileRow(
                label: l10n.profileLanguage,
                value: l10n.profileLanguageValue,
              ),
              const Divider(height: 1),
              _ProfileRow(
                label: l10n.profilePrivacy,
                value: l10n.profilePrivacyValue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/brand/logo.png',
        width: 88,
        height: 88,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: NegaritSpacing.lg,
        vertical: NegaritSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              color: NegaritColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
