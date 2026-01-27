import 'package:dio/dio.dart';

import '../../core/network/api_client.dart';
import '../../core/utils/api_constant.dart';

class AuthRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  Future<Response> login(String email) async {
    try {
      Response response = await _apiClient.post(
        ApiConstant.login,
        data: {'email': email},
      );
      return response;
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      Response response = await _apiClient.post(
        ApiConstant.verifyOtp,
        data: {'email': email, 'otp': otp},
      );
      return response;
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      rethrow;
    }
  }
}
