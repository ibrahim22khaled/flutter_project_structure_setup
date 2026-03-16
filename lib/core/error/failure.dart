import 'package:equatable/equatable.dart';

/// PURPOSE: Defines the standard error objects that repositories return.
/// 
/// WHY sealed class: If a new Failure is added to the hierarchy, 
/// the compiler will force you to handle it in every switch statement.
sealed class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Server-side error (5xx)
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred.']);
}

/// Local storage or cache error
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local cache error occurred.']);
}

/// No internet connection - usually comes from NetworkInfo.isConnected check
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

/// Token expired or missing (401)
/// WHY separate: GoRouter needs this to trigger a redirect to the login screen.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Session expired. Please login again.']);
}

/// Invalid input data (400 / 422)
/// WHY separate: UI needs to display field-specific errors instead of a generic dialog.
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;
  const ValidationFailure({
    String message = 'Invalid input.',
    this.fieldErrors,
  }) : super(message);

  @override
  List<Object?> get props => [message, fieldErrors];
}
