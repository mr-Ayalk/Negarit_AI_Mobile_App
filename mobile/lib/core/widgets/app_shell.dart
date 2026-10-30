import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/features/flow/premium_ui.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final branch = navigationShell.currentIndex;
    final selected = branch >= 2 ? branch + 1 : branch;
    return PremiumBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: navigationShell,
        bottomNavigationBar: PremiumTabBar(
          index: selected,
          onSelected: (index) {
            if (index == 2) {
              context.push('/guide');
              return;
            }
            final next = index > 2 ? index - 1 : index;
            navigationShell.goBranch(
              next,
              initialLocation: next == branch,
            );
          },
        ),
      ),
    );
  }
}
