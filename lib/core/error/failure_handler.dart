import 'package:dio/dio.dart';
import 'failure.dart';

/// PURPOSE: Centralized logic to map DioException → Failure.
/// WHY here: To ensure all repositories use the same mapping logic
/// without duplicating it across the codebase.
class FailureHandler {

  static Failure handleDioException(DioException error) {
    switch (error.type) {

      // Connection issues and timeouts - all map to NetworkFailure
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure();

      // Server responded with a status code outside the 2xx range
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      // User or code cancelled the request
      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled.');

      default:
        return const ServerFailure('An unexpected error occurred.');
    }
  }

  /// WHY separate: To decouple status code logic from DioException type logic.
  static Failure _handleBadResponse(Response? response) {
    if (response == null) return const ServerFailure();

    // Attempt to extract the message from the response body.
    // Backends typically send {"message": "..."} or {"error": "..."}
    final message = _extractMessage(response.data);

    switch (response.statusCode) {
      case 400:
      case 422:
        // Attempt to extract field errors if present.
        // Example: {"errors": {"email": ["is invalid"]}}
        final fieldErrors = _extractFieldErrors(response.data);
        return ValidationFailure(
          message: message ?? 'Invalid input.',
          fieldErrors: fieldErrors,
        );

      case 401:
        return UnauthorizedFailure(message ?? 'Session expired.');

      case 403:
        return const ServerFailure('You don\'t have permission.');

      case 404:
        return const ServerFailure('Resource not found.');

      case 500:
      case 502:
      case 503:
        return ServerFailure(message ?? 'Server error occurred.');

      default:
        return ServerFailure(message ?? 'Unexpected error occurred.');
    }
  }

  /// Extracts the message from the response body.
  /// Checks multiple common keys since different backends use different structures.
  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
             data['error'] as String? ??
             data['msg'] as String?;
    }
    return null;
  }

  /// Extracts field errors if provided by the backend.
  /// Example: {"errors": {"email": ["is invalid", "is taken"]}}
  static Map<String, List<String>>? _extractFieldErrors(dynamic data) {
    if (data is! Map<String, dynamic>) return null;

    final errors = data['errors'];
    if (errors is! Map<String, dynamic>) return null;

    return errors.map((key, value) {
      final messages = value is List
          ? value.map((e) => e.toString()).toList()
          : [value.toString()];
      return MapEntry(key, messages);
    });
  }
}
