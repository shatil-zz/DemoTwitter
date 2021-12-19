import 'dart:async';
import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/di/firebase_clients.dart';
import 'package:demo_twitter/features/auth/login_response_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';

@provide
class FirebaseAuthProvider {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthProvider(this._firebaseAuth);

  Future<UserCredential> emailLogin(String email, String password) {
    return _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
  }

  bool isLoggedInUser() {
    return _firebaseAuth.currentUser != null;
  }
}
