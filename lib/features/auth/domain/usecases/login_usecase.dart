import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// LEARNING NOTES:
/// Responsible for: business rules and use-cases.
/// NOT allowed to: know about Dio, Flutter widgets, or databases.

@injectable
class LoginUseCase implements BaseUseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}
