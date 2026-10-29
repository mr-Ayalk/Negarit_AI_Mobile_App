import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/locale/locale_controller.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_button.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';
import 'package:negarit_mobile/features/profile/data/session_controller.dart';
import 'package:negarit_mobile/features/visit/data/interests_controller.dart';
import 'package:negarit_mobile/features/visit/data/saved_places_controller.dart';
import 'package:negarit_mobile/features/visit/data/visit_labels.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final savedLanguage = ref.watch(localeProvider).value;
    final languageCode =
        savedLanguage ?? Localizations.localeOf(context).languageCode;
    final signedIn = ref.watch(sessionProvider).value;
    final interests = ref.watch(interestsProvider).value ?? const <String>[];
    final savedCount = ref.watch(savedPlacesProvider).value?.length ?? 0;

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
          signedIn ?? l10n.guestLabel,
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
        const SizedBox(height: NegaritSpacing.xxs),
        Text(
          l10n.profileAccountBody,
          textAlign: TextAlign.center,
          style: textTheme.bodySmall?.copyWith(
            color: NegaritColors.textSecondary,
          ),
        ),
        const SizedBox(height: NegaritSpacing.lg),
        NegaritButton(
          label: signedIn == null ? l10n.signIn : l10n.profileSignOut,
          onPressed: () {
            if (signedIn == null) {
              context.push('/sign-in');
              return;
            }
            ref.read(sessionProvider.notifier).signOut();
          },
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
                value: _languageLabel(languageCode),
                onTap: () => _chooseLanguage(context, ref),
              ),
              const Divider(height: 1),
              _ProfileRow(
                label: l10n.interestsTitle,
                value: interests.isEmpty
                    ? l10n.interestsNone
                    : interests
                          .map((id) => interestLabel(l10n, id))
                          .join(', '),
                onTap: () => _chooseInterests(context, ref),
              ),
              const Divider(height: 1),
              _ProfileRow(
                label: l10n.profileSaved,
                value: '$savedCount',
                onTap: () => context.go('/favorites'),
              ),
              const Divider(height: 1),
              _ProfileRow(
                label: l10n.profilePrivacy,
                value: l10n.profilePrivacyValue,
                onTap: () => _showPrivacy(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _languageLabel(String languageCode) {
    for (final language in visitLanguages) {
      if (language.code == languageCode) {
        return language.label;
      }
    }
    return visitLanguages.first.label;
  }

  Future<void> _chooseLanguage(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: NegaritColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(NegaritSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.chooseLanguage,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: NegaritSpacing.sm),
                for (final language in visitLanguages)
                  ListTile(
                    title: Text(language.label),
                    onTap: () async {
                      await ref
                          .read(localeProvider.notifier)
                          .select(language.code);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _chooseInterests(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: NegaritColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final selected =
                ref.watch(interestsProvider).value ?? const <String>[];
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(NegaritSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.interestsTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: NegaritSpacing.sm),
                    for (final interestId in visitInterestIds)
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: selected.contains(interestId),
                        title: Text(interestLabel(l10n, interestId)),
                        onChanged: (_) => ref
                            .read(interestsProvider.notifier)
                            .toggle(interestId),
                      ),
                    const SizedBox(height: NegaritSpacing.sm),
                    NegaritButton(
                      label: l10n.interestsDone,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showPrivacy(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: NegaritColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(NegaritSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.profilePrivacy,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: NegaritSpacing.sm),
                Text(l10n.profileAccountBody),
                const SizedBox(height: NegaritSpacing.xs),
                Text(l10n.profilePrivacyBody),
              ],
            ),
          ),
        );
      },
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
  const _ProfileRow({required this.label, required this.value, this.onTap});

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
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
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: NegaritColors.textSecondary,
                ),
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(width: NegaritSpacing.xxs),
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: NegaritColors.textSecondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
