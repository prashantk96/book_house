sealed class AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class LoginPressed extends AuthEvent {
  final String email;
  final String password;

  LoginPressed({required this.email, required this.password});
}

class RegisterPressed extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterPressed({
    required this.name,
    required this.email,
    required this.password,
  });
}

class GoogleLoginPressed extends AuthEvent {}

class LogoutPressed extends AuthEvent {}

// class ResetPasswordPressed extends AuthEvent {
//   final String email;

//   ResetPasswordPressed(this.email);
// }
