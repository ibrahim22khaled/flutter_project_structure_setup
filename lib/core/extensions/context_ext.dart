import 'package:flutter/material.dart';
import 'package:flutter_project_structure_setup/l10n/app_localizations.dart';

/// PURPOSE: Provides quick shortcuts on BuildContext to reduce boilerplate.
extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // A junior developer might wonder what "l10n" is short for. It stands for Localization.
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
