import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task/core/errors/failuare_mapper.dart';
import 'package:task/core/errors/exceptions.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/data/datasources/auth_remote_data_source.dart';
import 'package:task/data/models/common_model.dart';

import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, CommonModel>> login(String email) async {
    try {
      final result = await dataSource.login(email);
      return Right(result);
    } on AppException catch (e) {
      return Left(FailureMapper.fromException(e));
    } catch (e) {
      return Left(FailureMapper.fromError(e));
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
