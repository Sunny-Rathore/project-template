import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:task/core/network/exception_handler.dart';
import 'package:task/core/utils/json_utils.dart';
import 'package:task/data/models/common_model.dart';

import '../../core/network/api_client.dart';
import '../../core/utils/api_constant.dart';

abstract class AuthRemoteDataSource {
  Future<CommonModel> login(String email);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;
  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CommonModel> login(String email) async {
    try {
      Response response = await apiClient.post(
        ApiConstant.authLoginEndpoint,
        data: {'email': email},
      );
      return safeParseJson(response.data, CommonModel.fromJson);
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }
}
