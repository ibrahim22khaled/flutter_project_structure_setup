// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/auth_local_datasource.dart'
    as _i992;
import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_cached_user_usecase.dart'
    as _i389;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../helpers/local_storage/language_prefrence_helper.dart' as _i61;
import '../localization/app_language_cubit.dart' as _i811;
import '../localization/localization_container.dart' as _i430;
import '../network/api_client.dart' as _i557;
import '../network/auth_interceptor.dart' as _i908;
import '../network/network_info.dart' as _i932;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModule = _$CoreModule();
    gh.lazySingleton<_i895.Connectivity>(() => coreModule.connectivity);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => coreModule.secureStorage);
    gh.lazySingleton<_i430.LocalizationContainer>(
        () => _i430.LocalizationContainer());
    gh.lazySingleton<_i61.LanguagePreferencesHelper>(
        () => _i61.LanguagePreferencesHelper(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i811.AppLanguageCubit>(() => _i811.AppLanguageCubit(
          gh<_i61.LanguagePreferencesHelper>(),
          gh<_i430.LocalizationContainer>(),
        ));
    gh.lazySingleton<_i932.NetworkInfo>(
        () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()));
    gh.factory<_i908.AuthInterceptor>(
        () => _i908.AuthInterceptor(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i992.AuthLocalDataSource>(
        () => _i992.AuthLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i557.ApiClient>(
        () => _i557.ApiClient(gh<_i908.AuthInterceptor>()));
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
        () => _i161.AuthRemoteDataSourceImpl(gh<_i557.ApiClient>()));
    gh.lazySingleton<_i787.AuthRepository>(() => _i153.AuthRepositoryImpl(
          remoteDataSource: gh<_i161.AuthRemoteDataSource>(),
          localDataSource: gh<_i992.AuthLocalDataSource>(),
          networkInfo: gh<_i932.NetworkInfo>(),
        ));
    gh.factory<_i389.GetCachedUserUseCase>(
        () => _i389.GetCachedUserUseCase(gh<_i787.AuthRepository>()));
    gh.factory<_i188.LoginUseCase>(
        () => _i188.LoginUseCase(gh<_i787.AuthRepository>()));
    gh.factory<_i48.LogoutUseCase>(
        () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i117.AuthCubit>(() => _i117.AuthCubit(
          gh<_i188.LoginUseCase>(),
          gh<_i48.LogoutUseCase>(),
          gh<_i389.GetCachedUserUseCase>(),
        ));
    return this;
  }
}

class _$CoreModule extends _i464.CoreModule {}
