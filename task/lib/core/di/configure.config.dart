// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:task/core/network/api_client.dart' as _i811;
import 'package:task/core/network/network_info.dart' as _i116;
import 'package:task/data/datasources/auth_remote_data_source.dart' as _i137;
import 'package:task/data/repositories/auth_repository_impl.dart' as _i29;
import 'package:task/domain/repositories/auth_repository.dart' as _i446;
import 'package:task/domain/usecases/auth_usecases.dart' as _i639;
import 'package:task/presentation/cubit/auth/auth_cubit.dart' as _i231;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i116.NetworkInfo>(() => _i116.NetworkInfoImpl());
    gh.singleton<_i811.ApiClient>(
      () => _i811.ApiClient(gh<_i116.NetworkInfo>()),
    );
    gh.lazySingleton<_i137.AuthRemoteDataSource>(
      () => _i137.AuthRemoteDataSourceImpl(apiClient: gh<_i811.ApiClient>()),
    );
    gh.lazySingleton<_i446.AuthRepository>(
      () =>
          _i29.AuthRepositoryImpl(dataSource: gh<_i137.AuthRemoteDataSource>()),
    );
    gh.factory<_i639.LoginUseCase>(
      () => _i639.LoginUseCase(gh<_i446.AuthRepository>()),
    );
    gh.factory<_i231.AuthCubit>(
      () => _i231.AuthCubit(gh<_i639.LoginUseCase>()),
    );
    return this;
  }
}
