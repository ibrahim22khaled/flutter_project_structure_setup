import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure_setup/app.dart';
import 'package:flutter_project_structure_setup/core/di/injection.dart';
import 'package:flutter_project_structure_setup/core/utils/logger.dart';

void main() {
  // runZonedGuarded catches all unhandled asynchronous errors in the Dart framework.
  // This is the ideal place to report crashes to Firebase Crashlytics or Sentry.
  runZonedGuarded(() async {
    // Ensures Flutter bindings are initialized before calling native code
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize our Dependency Injection (get_it)
    // This must be done before runApp so our repositories and cubits are ready.
    await configureDependencies();

    // Run the actual app
    runApp(const MainApp());
  }, (error, stack) {
    // Log the error using our unified logger instead of print()
    logError('Uncaught asynchronous error', error);
  });
}
