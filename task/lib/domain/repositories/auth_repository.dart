import 'package:task/domain/entities/user.dart';

import '../../data/models/common_model.dart';

abstract class AuthRepository {
  Future<CommonModel> login(String email);
  Future<User> verifyOtp(String email, String otp);
  Future<void> logout();
  Future<String> signup(String email, String password, String name);
}
