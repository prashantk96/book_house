import 'package:book_house/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:book_house/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:book_house/features/auth/domain/entities/user_entity.dart';
import 'package:book_house/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;
  final AuthLocalDatasource local;

  AuthRepositoryImpl(this.remote, this.local);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final user = await remote.login(email: email, password: password);

    await local.saveUid(user.uid);

    return user;
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await remote.register(
      name: name,
      email: email,
      password: password,
    );

    await local.saveUid(user.uid);

    return user;
  }

  @override
  Future<UserEntity> googleLogin() async {
    final user = await remote.googleLogin();

    await local.saveUid(user.uid);

    return user;
  }

  @override
  Future<void> logout() async {
    await remote.logout();
    await local.clear();
  }

  @override
  Future<void> resetPassword(String email) async {
    await remote.resetPassword(email);
  }

  @override
  UserEntity? currentUser() {
    // Firebase session
    final firebaseUser = remote.currentUser();

    if (firebaseUser != null) {
      return firebaseUser;
    }

    return null;
  }

  Future<bool> isLoggedIn() async {
    final uid = await local.getUid();

    return uid != null && uid.isNotEmpty;
  }
}
