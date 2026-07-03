import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/current_user_usecase.dart';
import '../../domain/usecases/google_login_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase login;

  final RegisterUseCase register;

  final GoogleLoginUseCase google;

  final LogoutUseCase logout;

  final CurrentUserUseCase current;

  AuthBloc({
    required this.login,
    required this.register,
    required this.google,
    required this.logout,
    required this.current,
  }) : super(AuthInitial()) {
    on<CheckAuthStatus>(_check);

    on<LoginPressed>(_login);

    on<RegisterPressed>(_register);

    on<GoogleLoginPressed>(_google);

    on<LogoutPressed>(_logout);
  }

  Future<void> _check(CheckAuthStatus event, Emitter<AuthState> emit) async {
    final user = current();

    if (user == null) {
      emit(AuthUnauthenticated());
    } else {
      emit(AuthAuthenticated(user));
    }
  }

  Future<void> _login(LoginPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await login(email: event.email, password: event.password);

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _register(RegisterPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await register(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _google(
    GoogleLoginPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await google();

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _logout(LogoutPressed event, Emitter<AuthState> emit) async {
    await logout();

    emit(AuthUnauthenticated());
  }
}
