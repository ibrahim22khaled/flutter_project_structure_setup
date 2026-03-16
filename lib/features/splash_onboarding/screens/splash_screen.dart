import 'package:flutter/material.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../auth/presentation/cubit/auth_cubit.dart';

/// LEARNING NOTES:
/// Responsible for: UI and state only.
/// NOT allowed to: import from the data layer directly.
///
/// PURPOSE: Shows a loading indicator while the app checks for cached credentials.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check auth status as soon as the splash screen loads.
    // The result will trigger GoRouter to redirect accordingly.
    getIt<AuthCubit>().checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background pattern or subtle gradient can go here
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated logo placeholder
                const Icon(
                  Icons.rocket_launch,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                Text(
                  'FLUTTER STRATER',
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
          // Subtle loading indicator at the bottom
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
