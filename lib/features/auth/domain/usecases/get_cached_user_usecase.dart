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
class GetCachedUserUseCase implements BaseUseCase<User?, NoParams> {
  final AuthRepository repository;

  GetCachedUserUseCase(this.repository);

  @override
  Future<Either<Failure, User?>> call(NoParams params) {
    return repository.getCachedUser();
  }
}
