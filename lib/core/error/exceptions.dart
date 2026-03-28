class ServerException implements Exception {
  final String message;
  final Map<String, dynamic>? errorMap;
  ServerException({
    this.errorMap,
    required this.message,
  });
}

class ApiRequestException implements Exception {
  final String message;
  final Map<String, dynamic>? errorMap;
  ApiRequestException({
    this.errorMap,
    required this.message,
  });
}

class NoCachedUserException implements Exception {}

class CacheException implements Exception {
  final String? message;
  CacheException({this.message});
}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({required this.message});
}

class NoCacheOrderException implements Exception {}

class CacheUserAcssesToken implements Exception {}

class ResetPasswordException implements Exception {}

class OrderTypeException implements Exception {}

class StatusException implements Exception {
  final String message;
  StatusException({required this.message});
}

class UnExpectedException implements Exception {
  final String message;
  UnExpectedException({required this.message});
}
