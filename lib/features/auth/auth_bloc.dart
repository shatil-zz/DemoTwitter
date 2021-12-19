import 'package:demo_twitter/base/base_bloc.dart';
import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/auth/auth_repository.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class AuthBloc extends Bloc {
  final FirebaseAuthRepository _repository;

  AuthBloc(this._repository);

  final loginPublisher = PublishSubject<Resource>();

  Stream<Resource> get loginDataStream => loginPublisher.stream;

  emailLogin(String email, String password) async {
    loginPublisher.sink.add(Resource(status: ResourceStatus.loading));
    await Future.delayed(Duration(seconds: 10));
    loginPublisher.sink.add(await _repository.emailLogin(email, password));
  }

  bool get isLoggedInUser => _repository.isLoggedInUser();

  @override
  void dispose() {
    loginPublisher.close();
  }
}
