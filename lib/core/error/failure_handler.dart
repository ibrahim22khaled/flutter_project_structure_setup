import 'package:dio/dio.dart';
import 'failure.dart';
import 'exceptions.dart';

/// PURPOSE: Centralized logic to map Exceptions/DioException → Failure.
class FailureHandler {
  static Failure handleException(dynamic error) {
    if (error is DioException) {
      return handleDioException(error);
    } else if (error is ServerException) {
      return ServerFailure(message: error.message, errorMap: error.errorMap);
    } else if (error is ApiRequestException) {
      return RequestFailure(message: error.message);
    } else if (error is UnauthorizedException) {
      return UnAuthorizedFailure(message: error.message);
    } else if (error is CacheException) {
      return CacheFailure(message: error.message ?? 'Cache error'); // Fixed property name
    } else if (error is UnExpectedException) {
      return UnExpectedFailure(message: error.message);
    }
    return const UnExpectedFailure(message: 'An unexpected error occurred.');
  }

  static Failure handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure();

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Request was cancelled.');

      default:
        return const UnExpectedFailure(message: 'An unexpected error occurred.');
    }
  }

  static Failure _handleBadResponse(Response? response) {
    if (response == null) return const ServerFailure(message: 'Server error');

    final message = _extractMessage(response.data);

    switch (response.statusCode) {
      case 400:
      case 422:
        final fieldErrors = _extractFieldErrors(response.data);
        return ValidationFailure(
          message: message ?? 'Invalid input.',
          fieldErrors: fieldErrors,
        );

      case 401:
        return UnAuthorizedFailure(message: message ?? 'Session expired.');

      case 403:
        return const ServerFailure(message: 'You don\'t have permission.');

      case 404:
        return const ServerFailure(message: 'Resource not found.');

      case 500:
      case 502:
      case 503:
        return ServerFailure(message: message ?? 'Server error occurred.');

      default:
        return ServerFailure(message: message ?? 'Unexpected error occurred.');
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
          data['error'] as String? ??
          data['msg'] as String?;
    }
    return null;
  }

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
