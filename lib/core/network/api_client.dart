import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_constants.dart';
import 'auth_interceptor.dart';

/// PURPOSE: Provides a fully configured Dio instance for making network requests.
@lazySingleton
class ApiClient {
  final Dio dio;

  /// We inject the AuthInterceptor directly into the constructor.
  /// @lazySingleton ensures we only ever create one instance of ApiClient (and thus one Dio).
  ApiClient(AuthInterceptor authInterceptor) : dio = Dio() {
    dio.options.baseUrl = ApiConstants.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    // Add our auth interceptor to inject the token into every request
    dio.interceptors.add(authInterceptor);

    // Why logging must be disabled in release:
    // Security! Tokens (like JWTs) and sensitive user payloads would be printed 
    // to the console, and could be intercepted or read from the device logs.
    if (kDebugMode) {
      // pretty_dio_logger is a dev-only tool that formats JSON responses nicely
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }
  }
}
