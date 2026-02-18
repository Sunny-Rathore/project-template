import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/data/models/common_model.dart';
import 'package:task/domain/repositories/auth_repository.dart';
import 'package:task/domain/usecases/base_uscase.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

@injectable
class LoginUseCase extends UseCase<CommonModel, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, CommonModel>> call(params) =>
      _repository.login(params.email);
}
