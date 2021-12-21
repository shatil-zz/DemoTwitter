import 'package:demo_twitter/base/base_bloc.dart';
import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/auth/auth_repository.dart';
import 'package:demo_twitter/features/auth/login_response_model.dart';
import 'package:inject/inject.dart';

@provide
class AuthBloc extends Bloc {
  final FirebaseAuthRepository _repository;

  AuthBloc(this._repository);

  Future<Resource<LoginResponseModel>> emailLogin(
      String email, String password) async {
    return _repository.emailLogin(email, password);
  }

  bool get isLoggedInUser => _repository.isLoggedInUser();

  initializeUserInfo()=> _repository.initializeUserInfo();

  @override
  void dispose() {
  }
}
