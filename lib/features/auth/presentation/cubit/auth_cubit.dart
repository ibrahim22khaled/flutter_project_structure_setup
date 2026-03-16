import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/usecases/get_cached_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_state.dart';

/// LEARNING NOTES:
/// Responsible for: UI and state only.
/// NOT allowed to: import from the data layer directly.
/// 
/// PURPOSE: Manages the state of authentication for the app.
@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;

  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._getCachedUserUseCase,
  ) : super(const AuthState.initial());

  /// Checks if a user is already logged in on app startup.
  /// MODIFIED: For this prototype, we just show splash for 2 seconds then go to Login.
  Future<void> checkAuthStatus() async {
    emit(const AuthState.loading());
    
    // Add a small delay so the splash screen is visible for a "reasonable time".
    await Future.delayed(const Duration(seconds: 2));
    
    // Bypass real cache checks for now as requested.
    logInfo('Bypassing cache check for structural prototype. Navigating to Login.');
    emit(const AuthState.unauthenticated());
  }

  /// Attempts to log the user in with email and password.
  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    
    final result = await _loginUseCase(LoginParams(email: email, password: password));
    
    result.fold(
      (failure) {
        logError('Login failed: ${failure.message}');
        emit(AuthState.error(failure.message));
        // Reset to unauthenticated after showing error so the user can try again
        emit(const AuthState.unauthenticated());
      },
      (user) {
        logInfo('Login successful for: ${user.email}');
        emit(AuthState.authenticated(user));
      },
    );
  }

  /// Logs the user out and clears local data.
  Future<void> logout() async {
    emit(const AuthState.loading());
    
    final result = await _logoutUseCase(const NoParams());
    
    result.fold(
      (failure) {
        logError('Logout failed: ${failure.message}');
        emit(AuthState.error(failure.message));
      },
      (_) {
        logInfo('User logged out successfully.');
        emit(const AuthState.unauthenticated());
      },
    );
  }
}
