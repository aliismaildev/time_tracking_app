import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:result_type/result_type.dart';
import 'package:time_tracking_app/utils/firebase_global_instances.dart';

class AuthService {
  Future<Result<UserCredential, Object>> register({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await fireBaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Success(userCredential);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      if (e.code == 'weak-password') {
        return Failure('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Failure('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());

      return Failure(e);
    }

    return Failure('Please try again.');
  }

  //logOut

  Future<void> logOut() async => await fireBaseAuth.signOut();
}
