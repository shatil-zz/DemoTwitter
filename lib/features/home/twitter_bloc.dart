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
  late final Stream<Resource<TwitModel>> twitListStream;

  TwitterBloc(this._repository){
    twitListStream=_repository.getTwitList();
  }

  Future<Resource<TwitModel>> postTwit(String twit) async {
    return _repository.postTwit(twit);
  }

  @override
  void dispose() {
    //Dispose the items here
  }
}
