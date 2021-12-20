import 'package:demo_twitter/base/base_bloc.dart';
import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/auth/auth_repository.dart';
import 'package:demo_twitter/features/auth/login_response_model.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class TwitterBloc extends Bloc {
  final FirebaseAuthRepository _repository;

  TwitterBloc(this._repository);

  final loginPublisher = PublishSubject<Resource<LoginResponseModel>>();

  Stream<Resource> get loginDataStream => loginPublisher.stream;

  emailLogin(String email, String password) async {
    loginPublisher.sink.add(Resource<LoginResponseModel>(status: ResourceStatus.loading));
    loginPublisher.sink.add(await _repository.emailLogin(email, password));
  }

  bool get isLoggedInUser => _repository.isLoggedInUser();

  @override
  void dispose() {
    loginPublisher.close();
  }
}
