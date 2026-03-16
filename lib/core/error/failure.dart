/// PURPOSE: Defines the standard error objects that repositories return.
sealed class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Error occurred.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local cache error occurred.']);
}

/// Returned when NetworkInfo.isConnected is false.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No Internet Connection.']);
}
