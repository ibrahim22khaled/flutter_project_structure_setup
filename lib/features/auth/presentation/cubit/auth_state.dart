import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'auth_state.freezed.dart';

/// LEARNING NOTES:
/// Responsible for: UI and state only.
/// NOT allowed to: import from the data layer directly.
/// 
/// PURPOSE: Defines all possible states for the Authentication feature.
/// freeezed automatically generates pattern matching (map/when) for these states.
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(User user) = AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.error(String message) = AuthError;
}
