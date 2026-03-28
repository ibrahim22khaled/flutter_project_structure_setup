import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});

  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  final Map<String, dynamic>? errorMap;
  const ServerFailure({
    required super.message,
    this.errorMap,
  });

  @override
  List<Object?> get props => [message, errorMap];
}

class RequestFailure extends Failure {
  const RequestFailure({
    required super.message,
  });
}

class UnExpectedFailure extends Failure {
  const UnExpectedFailure({
    required super.message,
  });
}

class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection.'});
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;
  const ValidationFailure({
    String message = 'Invalid input.',
    this.fieldErrors,
  }) : super(message: message);

  @override
  List<Object?> get props => [message, fieldErrors];
}
