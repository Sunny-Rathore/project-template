import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';

import '../../data/models/common_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, CommonModel>> login(String email);
  Future<void> logout();
}
