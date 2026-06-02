import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/auth/presentation/auth_screen.dart';
import '../features/auth/presentation/email_confirm_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/intervention/presentation/intervention_screen.dart';
import '../features/modes/presentation/modes_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/sessions/presentation/history_screen.dart';
import '../features/visual_contact/presentation/visual_contact_screen.dart';
import 'main_shell.dart';

abstract class AppRoutes {
  static const auth = '/auth';
  static const emailConfirm = '/email-confirm';

  static const home = '/home';
  static const modes = '/modes';
  static const history = '/history';
  static const profile = '/profile';

  static const intervention = '/intervention';
  static const visualContact = '/visual-contact';
}

GoRouter buildAppRouter() {
  final auth = Supabase.instance.client.auth;

  return GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: _AuthRefreshNotifier(auth.onAuthStateChange),
    redirect: (context, state) {
      final session = auth.currentSession;
      final goingTo = state.matchedLocation;

      if (session == null) {
        if (goingTo == AppRoutes.auth) return null;
        return AppRoutes.auth;
      }

      final emailConfirmed = session.user.emailConfirmedAt != null;
      if (!emailConfirmed) {
        if (goingTo == AppRoutes.emailConfirm) return null;
        return AppRoutes.emailConfirm;
      }

      if (goingTo == AppRoutes.auth || goingTo == AppRoutes.emailConfirm) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.emailConfirm,
        builder: (context, state) => const EmailConfirmScreen(),
      ),
      GoRoute(
        path: AppRoutes.intervention,
        builder: (context, state) {
          final extra = state.extra;
          final args =
              extra is Map<String, dynamic> ? extra : <String, dynamic>{};
          return InterventionScreen(arguments: args);
        },
      ),
      GoRoute(
        path: AppRoutes.visualContact,
        builder: (context, state) {
          final extra = state.extra;
          final args =
              extra is Map<String, dynamic> ? extra : <String, dynamic>{};
          return VisualContactScreen(arguments: args);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) =>
                MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.modes,
                builder: (context, state) => const ModesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Stream<AuthState> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
