import 'package:book_house/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDatasource({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  }) : _firebaseAuth = firebaseAuth,
       _googleSignIn = googleSignIn {
    print('AuthRemoteDatasource created');
    print(_firebaseAuth);
    print(_googleSignIn);
  }

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return _mapUser(credential.user!);
  }

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user!.updateDisplayName(name);
    await credential.user!.reload();

    final user = _firebaseAuth.currentUser!;

    return _mapUser(user);
  }

  Future<UserEntity> googleLogin() async {
    try {
      print("STEP 1");

      final googleUser = await _googleSignIn.signIn();

      print("STEP 2");

      if (googleUser == null) {
        throw Exception('Cancelled');
      }

      final googleAuth = await googleUser.authentication;

      print("STEP 3");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print("STEP 4");

      final result = await _firebaseAuth.signInWithCredential(credential);

      print("STEP 5");

      return _mapUser(result.user!);
    } catch (e, s) {
      print(e);
      print(s);
      rethrow;
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  UserEntity? currentUser() {
    final user = _firebaseAuth.currentUser;

    if (user == null) return null;

    return _mapUser(user);
  }

  UserEntity _mapUser(User user) {
    return UserEntity(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL,
      provider: user.providerData.isNotEmpty
          ? user.providerData.first.providerId
          : 'password',
      createdAt: user.metadata.creationTime,
    );
  }
}
