import 'package:equatable/equatable.dart';
import 'package:task/core/app_export.dart';
import 'package:task/data/models/common_model.dart';

import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/entities/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryImpl authRepository = AuthRepositoryImpl();
  AuthCubit() : super(AuthInitial());

  Future<void> loginRequest({required String email}) async {
    try {
      emit(AuthLoading());
      CommonModel result = await authRepository.login(email);
      emit(AuthSuccess(message: result.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    try {
      emit(AuthLoading());
      final User user = await authRepository.verifyOtp(email, otp);
      await PrefUtils.setId(user.id ?? "");
      await PrefUtils.setToken(user.accessToken ?? '');
      await PrefUtils.setIsOnboarded(user.isOnboarded ?? false);
      emit(AuthSuccess(isNewUser: user.isOnboarded));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
