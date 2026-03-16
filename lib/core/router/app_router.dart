import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Note: These imports will show errors until Part 3 is completed.
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/cubit/auth_state.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/splash_onboarding/screens/splash_screen.dart';
import '../di/injection.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// Get a single instance of AuthCubit to use throughout the router.
// Since it's now a @lazySingleton, this instance will be shared.
final _authCubit = getIt<AuthCubit>();

/// PURPOSE: Centralized routing configuration using GoRouter.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  // We provide the AuthCubit stream as a listenable so GoRouter re-evaluates
  // redirects whenever the authentication state changes.
  refreshListenable: GoRouterRefreshStream(_authCubit.stream),
  redirect: (context, state) {
    // Read the current state of the AuthCubit
    final authState = _authCubit.state;
    
    final isLoggingIn = state.matchedLocation == '/login';
    final isSplash = state.matchedLocation == '/';

    // If still checking auth (loading/initial) and we are on splash, stay on splash.
    if (authState is AuthInitial || authState is AuthLoading) {
      if (!isSplash) return '/';
      return null;
    }

    // If unauthenticated and we are not on the login screen, redirect to login.
    if (authState is AuthUnauthenticated || authState is AuthError) {
      if (!isLoggingIn) return '/login';
      return null;
    }

    // If authenticated and trying to access login or splash, redirect to home.
    if (authState is AuthAuthenticated) {
      if (isLoggingIn || isSplash) return '/home';
      return null;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Home - Placeholder')),
      ),
    ),
  ],
);

/// A helper class to convert a Stream into a Listenable for GoRouter.
/// GoRouter needs a Listenable for "refreshListenable", but Cubits expose Streams.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
