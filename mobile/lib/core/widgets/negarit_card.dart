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
        border: Border.all(color: NegaritColors.line),
        boxShadow: [
          BoxShadow(
            color: NegaritColors.primary.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
