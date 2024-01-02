import "package:firebase_auth/firebase_auth.dart" as fa;

abstract class BaseAuthRepository {
  Stream<fa.User?> get user;
  Future<fa.User?> signUp({required String email, required String password});
}
