import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:tuncjob/repositories/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final fa.FirebaseAuth _firebaseAuth;

  AuthRepository({fa.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? fa.FirebaseAuth.instance;

  @override
  Future<fa.User?> signUp(
      {required String email, required String password}) async {
    try {
      final credential =
          await fa.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      return user;
    } on fa.FirebaseAuthException catch (e) {
      // FirebaseAuthException türünden hataları ele al
      log("Firebase Auth Hatası: ${e.message}");
      // İsterseniz farklı bir işlem yapabilir veya hatayı tekrar throw edebilirsiniz.
      return null;
    } catch (e) {
      // FirebaseAuthException dışındaki genel hataları ele al
      log("Beklenmeyen bir hata oluştu: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<fa.User?> get user => _firebaseAuth.userChanges();
}
