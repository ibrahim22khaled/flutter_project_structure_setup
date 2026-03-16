import 'package:flutter/foundation.dart';

/// PURPOSE: A unified logging utility for the entire application.
/// 
/// To switch to Crashlytics or any other logging service later, 
/// only modify this file — nothing else in the app needs to change.

void logInfo(String message) {
  debugPrint('ℹ️ $message');
}

void logError(String message, [Object? error]) {
  debugPrint('❌ $message');
  if (error != null) {
    debugPrint('❌ Error Details: $error');
  }
}

void logWarning(String message) {
  debugPrint('⚠️ $message');
}

void logDebug(String message) {
  debugPrint('🐛 $message');
}
