import 'package:book_house/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({required String email, required String password});

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> googleLogin();

  Future<void> logout();

  Future<void> resetPassword(String email);

  UserEntity? currentUser();
}
