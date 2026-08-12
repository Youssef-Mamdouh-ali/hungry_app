import 'package:firebase_auth/firebase_auth.dart';

import '../exceptions/auth_exceptions.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource(this.firebaseAuth);

  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential =
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      return credential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getErrorMessage(e.code),
      );
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getErrorMessage(e.code),
      );
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getErrorMessage(e.code),
      );
    }
  }

  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Please enter a valid email';

      case 'user-not-found':
        return 'No account found with this email';

      case 'wrong-password':
        return 'Incorrect email or password';

      case 'invalid-credential':
        return 'Incorrect email or password';

      case 'email-already-in-use':
        return 'This email is already registered';

      case 'weak-password':
        return 'Password is too weak';

      case 'network-request-failed':
        return 'Please check your internet connection';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later';

      default:
        return 'Something went wrong. Please try again';
    }
  }
}