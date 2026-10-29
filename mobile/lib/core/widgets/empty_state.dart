import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_card.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({required this.title, required this.body, super.key});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return NegaritCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: textTheme.titleLarge),
          const SizedBox(height: NegaritSpacing.xs),
          Text(
            body,
            style: textTheme.bodyLarge?.copyWith(
              color: NegaritColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
