import 'package:dio/dio.dart';
import 'package:task/core/errors/exceptions.dart';
import 'dart:io' as io;

class ExceptionHandler {
  ExceptionHandler._();

  static AppException handle(Object error) {
    if (error is AppException) return error;
    if (error is io.SocketException) {
      return NoInternetException();
    }
    if (error is DioException) return _dioException(error);
    return UnknownException(
      message: 'Unknown Exception occurred',
      originalError: error,
    );
  }

  static AppException _dioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout => NetworkException(
        message: 'Connection Timeout',
        originalError: e,
      ),
      DioExceptionType.sendTimeout => NetworkException(
        message: 'Request Send Timeout',
        originalError: e,
      ),
      DioExceptionType.receiveTimeout => NetworkException(
        message: 'Received Timeout',
        originalError: e,
      ),
      DioExceptionType.connectionError => NoInternetException(),
      DioExceptionType.badCertificate => ServerException(
        message: 'Bad Certificate Exception',
        originalError: e,
      ),
      DioExceptionType.cancel => ServerException(
        message: 'Request was Canceled',
        originalError: e,
      ),
      DioExceptionType.badResponse => ServerException(
        message: _extractMessage(e.response),
        statusCode: e.response?.statusCode,
      ),
      DioExceptionType.unknown => UnknownException(
        message: 'Unknown Exception occurred',
        originalError: e,
      ),
    };
  }

  static String _extractMessage(Response? response) {
    final data = response?.data;
    if (data is Map<String, dynamic>) {
      return data['message'] ?? data['error'] ?? data['details'];
    }
    return 'Unknown Exception';
  }
}
