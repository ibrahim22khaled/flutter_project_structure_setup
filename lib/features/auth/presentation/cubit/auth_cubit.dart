import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/async.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/usecases/get_cached_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_state.dart';

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

  Future<void> checkAuthStatus() async {
    emit(state.copyWith(authStatus: const Async.loading()));
    
    await Future.delayed(const Duration(seconds: 2));
    
    // Bypass real cache checks for now as requested.
    logInfo('Bypassing cache check for structural prototype. Navigating to Login.');
    emit(state.copyWith(authStatus: const Async.success(null)));
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(authStatus: const Async.loading()));
    
    final result = await _loginUseCase(LoginParams(email: email, password: password));
    
    result.fold(
      (failure) {
        logError('Login failed: ${failure.message}');
        emit(state.copyWith(authStatus: Async.failure(failure.message)));
        // Optional: Revert to initial/success(null) if needed
        // emit(state.copyWith(authStatus: const Async.success(null)));
      },
      (user) {
        logInfo('Login successful for: ${user.email}');
        emit(state.copyWith(authStatus: Async.success(user)));
      },
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(authStatus: const Async.loading()));
    
    final result = await _logoutUseCase(const NoParams());
    
    result.fold(
      (failure) {
        logError('Logout failed: ${failure.message}');
        emit(state.copyWith(authStatus: Async.failure(failure.message)));
      },
      (_) {
        logInfo('User logged out successfully.');
        emit(state.copyWith(authStatus: const Async.success(null)));
      },
    );
  }
}
