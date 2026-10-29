import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_radius.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';

class NegaritCard extends StatelessWidget {
  const NegaritCard({
    required this.child,
    this.padding = const EdgeInsets.all(NegaritSpacing.lg),
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
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
      child: Padding(padding: padding, child: child),
    );
  }
}
