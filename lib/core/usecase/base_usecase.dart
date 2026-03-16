import 'package:dartz/dartz.dart';
import '../error/failure.dart';

/// PURPOSE: A blueprint for all UseCases in the domain layer.
/// 
/// We use [Either] from the dartz package to enforce error handling.
/// A junior might ask: Why "Either"?
/// Answer: "Either" forces the caller to handle BOTH the success case (Right)
/// and the failure case (Left) explicitly. You can't accidentally ignore an error using Either.
abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// A simple class used as a parameter when a usecase doesn't require any inputs.
/// What is NoParams for? 
/// Answer: It standardizes the method signature. Instead of having some usecases
/// take no arguments and others take Params objects, they ALL take exactly one parameter.
class NoParams {
  const NoParams();
}
