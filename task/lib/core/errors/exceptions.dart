abstract class AppException implements Exception {
  final String message;
  final dynamic originalError;

  const AppException({required this.message, this.originalError});
  @override
  String toString() => '$runtimeType(message:$message,error:$originalError)';
}

class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required super.message,
    super.originalError,
    this.statusCode,
  });
}

class CacheException extends AppException {
  const CacheException({required super.message, super.originalError});
}

class NetworkException extends AppException {
  const NetworkException({required super.message, super.originalError});
}

class NoInternetException extends AppException {
  const NoInternetException({
    super.message = 'No Internet Connection',
    super.originalError,
  });
}

class JsonParseException extends AppException {
  const JsonParseException({required super.message, super.originalError});
}

class UnknownException extends AppException {
  const UnknownException({required super.message, super.originalError});
}

class CacheNotFoundException extends AppException {
  const CacheNotFoundException({required super.message, super.originalError});
}
