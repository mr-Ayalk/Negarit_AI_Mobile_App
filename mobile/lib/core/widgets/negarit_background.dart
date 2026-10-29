import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';

/// Soft sky gradient used behind visitor screens.
class NegaritBackground extends StatelessWidget {
  const NegaritBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [NegaritColors.skyTop, NegaritColors.skyBottom],
        ),
      ),
      child: child,
    );
  }
}
