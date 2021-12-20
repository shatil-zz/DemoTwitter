import 'dart:async';
import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/auth/auth_provider.dart';
import 'package:demo_twitter/features/auth/login_response_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';

abstract class AuthRepository {
  Future<Resource> emailLogin(String email, String password);

  bool isLoggedInUser();
}

@provide
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthProvider _provider;

  FirebaseAuthRepository(this._provider);

  @override
  Future<Resource<LoginResponseModel>> emailLogin(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _provider.emailLogin(email, password);
      return Resource<LoginResponseModel>(
          model: LoginResponseModel(userCredential.user?.uid,
              userCredential.user?.email, userCredential.user?.refreshToken),
          status: ResourceStatus.success);
    } catch (ex) {
      return Resource(message: "Login Failed", status: ResourceStatus.failed);
    }
  }

  @override
  bool isLoggedInUser() {
    return _provider.isLoggedInUser();
  }
}
