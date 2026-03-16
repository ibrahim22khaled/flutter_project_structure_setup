import 'package:dio/dio.dart';
import 'failure.dart';

/// PURPOSE: Centralized logic to map Exceptions (like DioException) to our Failure types.
class FailureHandler {
  static Failure handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        // You could parse the statusCode and message here depending on your backend
        return const ServerFailure('Invalid response from the server.');
      default:
        return const ServerFailure('An unexpected error occurred.');
    }
  }
}
