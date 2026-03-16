import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/auth_repository.dart';

/// LEARNING NOTES:
/// Responsible for: business rules and use-cases.
/// NOT allowed to: know about Dio, Flutter widgets, or databases.

@injectable
class LogoutUseCase implements BaseUseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.logout();
  }
}
