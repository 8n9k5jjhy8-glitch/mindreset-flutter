import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/main_shell.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/intervention/presentation/intervention_screen.dart';
import '../../features/modes/presentation/modes_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/visual_contact/presentation/visual_contact_screen.dart';

class AppRoutes {
  static const home = '/';
  static const modes = '/modes';
  static const history = '/history';
  static const profile = '/profile';
  static const intervention = '/intervention';
  static const visualContact = '/visual-contact';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _homeBranchNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'homeBranch',
);
final _modesBranchNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'modesBranch',
);
final _historyBranchNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'historyBranch',
);
final _profileBranchNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'profileBranch',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeBranchNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.home,
              pageBuilder:
                  (context, state) =>
                      const NoTransitionPage(child: HomeScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _modesBranchNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.modes,
              pageBuilder:
                  (context, state) =>
                      const NoTransitionPage(child: ModesScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _historyBranchNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.history,
              pageBuilder:
                  (context, state) =>
                      const NoTransitionPage(child: HistoryScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileBranchNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              pageBuilder:
                  (context, state) =>
                      const NoTransitionPage(child: ProfileScreen()),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.intervention,
      builder: (context, state) {
        final extra = state.extra;
        return InterventionScreen(
          arguments: extra is Map<String, dynamic> ? extra : const {},
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.visualContact,
      builder: (context, state) {
        final extra = state.extra;
        return VisualContactScreen(
          arguments: extra is Map<String, dynamic> ? extra : const {},
        );
      },
    ),
  ],
);
