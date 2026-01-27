import 'package:task/data/datasources/auth_remote_data_source.dart';
import 'package:task/data/models/common_model.dart';
import 'package:task/domain/entities/user.dart';

import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource = AuthRemoteDataSource();

  @override
  Future<CommonModel> login(String email) async {
    try {
      final response = await dataSource.login(email);
      return CommonModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<String> signup(String email, String password, String name) {
    throw UnimplementedError();
  }

  @override
  Future<User> verifyOtp(String email, String otp) async {
    try {
      final response = await dataSource.verifyOtp(email: email, otp: otp);
      User user = UserModel.fromJson(response.data['data']['user_data']);
      user = user.copyWith(accessToken: response.data['data']['accessToken']);
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
