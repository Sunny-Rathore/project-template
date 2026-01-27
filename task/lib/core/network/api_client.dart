import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../errors/exceptions.dart';
import '../utils/api_constant.dart';

class ApiClient {
  late Dio _dio;

  // Constructor
  ApiClient({String? baseUrl}) {
    BaseOptions options = BaseOptions(
      baseUrl:
          baseUrl ??
          ApiConstant.baseUrl, // Set a default base URL if none is provided
      connectTimeout: const Duration(seconds: 10), // Set connection timeout
      receiveTimeout: const Duration(seconds: 10), // Set receiving timeout
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);

    // Optional: Set up interceptors
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        enabled: kDebugMode,
        maxWidth: 90,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Handle pre-request actions like adding auth tokens
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          // Handle successful response
          return handler.next(response); // Continue with the response
        },
        onError: (DioException error, handler) {
          // Handle errors
          debugPrint('Request failed: ${error.response?.statusCode}');
          return handler.next(error); // Continue with the error
        },
      ),
    ]);
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.put(path, data: data, options: options);
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.delete(path, data: data, options: options);
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  // PATCH request
  Future<Response> patch(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.patch(path, data: data, options: options);
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  // You can also add a method to set custom headers
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  Exception handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      throw NoInternetException('Connection timeout. Please try again later.');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      throw NoInternetException('Receive timeout. Please try again later.');
    } else if (e.type == DioExceptionType.cancel) {
      throw Exception('Request was cancelled.');
    } else if (e.type == DioExceptionType.connectionError) {
      throw Exception('No Internet Connection');
    } else {
      throw e;
    }
  }
}
