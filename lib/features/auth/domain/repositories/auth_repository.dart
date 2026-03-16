import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user.dart';

/// LEARNING NOTES:
/// Responsible for: business rules and use-cases.
/// NOT allowed to: know about Dio, Flutter widgets, or databases.
/// 
/// PURPOSE: Defines the contract that the data layer repository must implement.
abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCachedUser();
}
