import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_structure_setup/core/router/app_router.dart';
import 'package:flutter_project_structure_setup/core/theme/app_theme.dart';
import 'package:flutter_project_structure_setup/l10n/app_localizations.dart';

/// The root of our application.
///
/// We use [MaterialApp.router] because we are using GoRouter for navigation.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Template', // Fallback title

      // Theme setup (defined in lib/core/theme/app_theme.dart)
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // The GoRouter instance handles our navigation and deep linking
      routerConfig: appRouter,

      // Localization setup
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
      ],

      // Use localized title if available
      onGenerateTitle: (context) {
        return AppLocalizations.of(context)?.appTitle ?? 'Flutter Template';
      },
    );
  }
}
