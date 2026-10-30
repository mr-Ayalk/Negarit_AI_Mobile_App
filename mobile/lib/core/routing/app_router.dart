import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/widgets/app_shell.dart';
import 'package:negarit_mobile/features/flow/onboarding_screens.dart';
import 'package:negarit_mobile/features/flow/shell_screens.dart';
import 'package:negarit_mobile/features/flow/visit_screens.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/language',
    routes: [
      GoRoute(
        path: '/language',
        builder: (context, state) => LanguageScreen(
          returnTo: state.uri.queryParameters['return'],
        ),
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionsScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const WelcomeSignInScreen(),
      ),
      GoRoute(
        path: '/venue',
        builder: (context, state) => const VenuePickScreen(),
      ),
      GoRoute(
        path: '/entrance',
        builder: (context, state) => const EntranceScreen(),
      ),
      GoRoute(
        path: '/exhibit',
        builder: (context, state) => const ExhibitScreen(),
      ),
      GoRoute(
        path: '/offer',
        builder: (context, state) => const OfferScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/break',
        builder: (context, state) => const BreakScreen(),
      ),
      GoRoute(
        path: '/plan',
        builder: (context, state) => const PlanScreen(),
      ),
      GoRoute(
        path: '/guide',
        builder: (context, state) => const GuideChatScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/map',
                builder: (context, state) => const VenueMapScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const SavedScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const VisitorProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
