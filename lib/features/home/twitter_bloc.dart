import 'package:demo_twitter/base/base_bloc.dart';
import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/auth/auth_repository.dart';
import 'package:demo_twitter/features/auth/login_response_model.dart';
import 'package:demo_twitter/features/home/twit_model.dart';
import 'package:demo_twitter/features/home/twitter_repository.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class TwitterBloc extends Bloc {
  final FirebaseTwitterRepository _repository;

  TwitterBloc(this._repository);

  final twitListPublisher = PublishSubject<Resource<TwitModel>>();

  Stream<Resource<TwitModel>> get twitListStream => twitListPublisher.stream;

  Future<Resource<TwitModel>> postTwit(String twit) async {
    return _repository.postTwit(twit);
  }

  loadTwits() {
    twitListPublisher.sink
        .add(Resource<TwitModel>(status: ResourceStatus.loading));
    twitListPublisher.sink.addStream(_repository.getTwitList());
  }

  @override
  void dispose() {
    twitListPublisher.close();
  }
}
