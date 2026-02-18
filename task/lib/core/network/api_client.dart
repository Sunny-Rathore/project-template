import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:task/core/network/exception_handler.dart';
import 'package:task/core/network/network_info.dart';

import '../errors/exceptions.dart';
import '../utils/api_constant.dart';

@singleton
class ApiClient {
  final NetworkInfo _networkInfo;
  late Dio _dio;

  // Constructor
  ApiClient(this._networkInfo) {
    BaseOptions options = BaseOptions(
      baseUrl:
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
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!await _networkInfo.isConnected) {
            return handler.reject(
              DioException(
                requestOptions: options,
                error: NoInternetException(),
                type: DioExceptionType.connectionError,
              ),
            );
          }
          // Handle pre-request actions like adding auth tokens
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          // Handle successful response
          return handler.next(response); // Continue with the response
        },
        onError: (DioException error, handler) {
          // Handle errors
          return handler.next(error); // Continue with the error
        },
      ),
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
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  // POST request
  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  // PUT request
  Future<Response> put(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.put(path, data: data, options: options);
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  // DELETE request
  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.delete(path, data: data, options: options);
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  // PATCH request
  Future<Response> patch(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.patch(path, data: data, options: options);
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  // You can also add a method to set custom headers
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
