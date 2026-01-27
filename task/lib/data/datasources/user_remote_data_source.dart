import 'package:dio/dio.dart';

import '../../core/network/api_client.dart';
import '../../core/utils/api_constant.dart';
import '../../core/utils/pref_utils.dart';

class UserRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  Future<Response> fetchUser(String id) async {
    try {
      _apiClient.setHeaders({
        'Authorization': 'Bearer ${PrefUtils.getToken()}',
      });
      Response response = await _apiClient.get('${ApiConstant.userDetail}/$id');
      return response;
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> updateUser(Map<String, dynamic> data) async {
    try {
      print(data);
      _apiClient.setHeaders({
        'Authorization': 'Bearer ${PrefUtils.getToken()}',
      });
      final Map<String, dynamic> fields = Map.from(data);
      fields.remove('profileImage');
      if (data['profileImage'] != null && data['profileImage'].isNotEmpty) {
        if (!data['profileImage'].contains('https://')) {
          fields['profileImage'] = await MultipartFile.fromFile(
            data['profileImage'],
          );
        }
      }
      FormData formData = FormData.fromMap(fields);
      Response response = await _apiClient.put(
        ApiConstant.updateUser,
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> deleteUser(String id) async {
    try {
      Response response = await _apiClient.delete(
        ApiConstant.deleteUser,
        data: {'aocId': id},
      );
      return response;
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> updateMatrics(Map<String, dynamic> data) async {
    try {
      _apiClient.setHeaders({
        'Authorization': 'Bearer ${PrefUtils.getToken()}',
      });
      Response response = await _apiClient.put(
        ApiConstant.updateMetric,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception(e);
    }
  }
}
