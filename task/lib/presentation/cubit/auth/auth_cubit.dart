import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/domain/repositories/auth_repository.dart';
import 'package:task/domain/usecases/auth_usecases.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  // final AuthRepository _repository;
  final LoginUseCase _loginUseCase;
  AuthCubit(this._loginUseCase) : super(AuthInitial());

  FutureOr login(LoginParams loginParams) async {
    emit(AuthLoading());
    final result = await _loginUseCase(loginParams);
    //_loginUseCase(loginParams);
    result.fold(
      (Failure failure) => emit(AuthFailure(failure)),
      (model) => emit(AuthSuccess(model.message)),
    );
  }
}
