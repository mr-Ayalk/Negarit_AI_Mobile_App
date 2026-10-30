import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';

class NegaritChip extends StatelessWidget {
  const NegaritChip({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NegaritColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: const BorderSide(color: NegaritColors.line),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NegaritSpacing.md,
            vertical: NegaritSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: NegaritColors.primary),
              const SizedBox(width: NegaritSpacing.xs),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
