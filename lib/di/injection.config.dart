// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:book_house/core/network/dio_client.dart' as _i1063;
import 'package:book_house/core/network/network_module.dart' as _i176;
import 'package:book_house/core/services/local_storage_service.dart' as _i437;
import 'package:book_house/di/injection.dart' as _i579;
import 'package:book_house/features/auth/data/datasource/auth_local_datasource.dart'
    as _i100;
import 'package:book_house/features/auth/data/datasource/auth_remote_datasource.dart'
    as _i849;
import 'package:book_house/features/auth/data/repositories/auth_repository_impl.dart'
    as _i69;
import 'package:book_house/features/auth/domain/repositories/auth_repository.dart'
    as _i418;
import 'package:book_house/features/auth/domain/usecases/current_user_usecase.dart'
    as _i258;
import 'package:book_house/features/auth/domain/usecases/google_login_usecase.dart'
    as _i829;
import 'package:book_house/features/auth/domain/usecases/login_usecase.dart'
    as _i513;
import 'package:book_house/features/auth/domain/usecases/logout_usecase.dart'
    as _i894;
import 'package:book_house/features/auth/domain/usecases/register_usecase.dart'
    as _i43;
import 'package:book_house/features/auth/presentation/bloc/auth_bloc.dart'
    as _i503;
import 'package:book_house/features/dashboard/presentation/cubit/dashboard_cubit.dart'
    as _i250;
import 'package:book_house/features/home/data/datasource/book_remote_datasource.dart'
    as _i76;
import 'package:book_house/features/home/data/repositories/book_repository_impl.dart'
    as _i673;
import 'package:book_house/features/home/domain/repositories/book_repository.dart'
    as _i211;
import 'package:book_house/features/home/domain/usecases/get_books_usecase.dart'
    as _i731;
import 'package:book_house/features/home/presentation/cubit/home_cubit.dart'
    as _i153;
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i757;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

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
    final firebaseModule = _$FirebaseModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i250.DashboardCubit>(() => _i250.DashboardCubit());
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.lazySingleton<_i437.LocalStorageService>(
        () => _i437.LocalStorageService());
    gh.lazySingleton<_i1063.DioClient>(() => networkModule.dioClient);
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i100.AuthLocalDatasource>(
        () => _i100.AuthLocalDatasource(gh<_i437.LocalStorageService>()));
    gh.factory<_i757.OnboardingBloc>(
        () => _i757.OnboardingBloc(gh<_i437.LocalStorageService>()));
    gh.lazySingleton<_i849.AuthRemoteDatasource>(
        () => _i849.AuthRemoteDatasource(
              firebaseAuth: gh<_i59.FirebaseAuth>(),
              googleSignIn: gh<_i116.GoogleSignIn>(),
            ));
    gh.lazySingleton<_i418.AuthRepository>(() => _i69.AuthRepositoryImpl(
          gh<_i849.AuthRemoteDatasource>(),
          gh<_i100.AuthLocalDatasource>(),
        ));
    gh.lazySingleton<_i76.BookRemoteDatasource>(
        () => _i76.BookRemoteDatasource(gh<_i361.Dio>()));
    gh.lazySingleton<_i211.BookRepository>(
        () => _i673.BookRepositoryImpl(gh<_i76.BookRemoteDatasource>()));
    gh.factory<_i258.CurrentUserUseCase>(
        () => _i258.CurrentUserUseCase(gh<_i418.AuthRepository>()));
    gh.factory<_i43.RegisterUseCase>(
        () => _i43.RegisterUseCase(gh<_i418.AuthRepository>()));
    gh.factory<_i513.LoginUseCase>(
        () => _i513.LoginUseCase(gh<_i418.AuthRepository>()));
    gh.factory<_i894.LogoutUseCase>(
        () => _i894.LogoutUseCase(gh<_i418.AuthRepository>()));
    gh.factory<_i829.GoogleLoginUseCase>(
        () => _i829.GoogleLoginUseCase(gh<_i418.AuthRepository>()));
    gh.factory<_i503.AuthBloc>(() => _i503.AuthBloc(
          login: gh<_i513.LoginUseCase>(),
          register: gh<_i43.RegisterUseCase>(),
          google: gh<_i829.GoogleLoginUseCase>(),
          logout: gh<_i894.LogoutUseCase>(),
          current: gh<_i258.CurrentUserUseCase>(),
        ));
    gh.lazySingleton<_i731.GetBooksUsecase>(
        () => _i731.GetBooksUsecase(gh<_i211.BookRepository>()));
    gh.factory<_i153.HomeCubit>(
        () => _i153.HomeCubit(gh<_i731.GetBooksUsecase>()));
    return this;
  }
}

class _$FirebaseModule extends _i579.FirebaseModule {}

class _$NetworkModule extends _i176.NetworkModule {}
