import 'package:equatable/equatable.dart';
import '../../../../core/utils/async.dart';
import '../../domain/entities/user.dart';

class AuthState extends Equatable {
  final Async<User?> authStatus;

  const AuthState({
    required this.authStatus,
  });

  const AuthState.initial() : this(authStatus: const Async.initial());

  AuthState copyWith({
    Async<User?>? authStatus,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props => [authStatus];
}
