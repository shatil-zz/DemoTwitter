import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/auth/auth_provider.dart';
import 'package:demo_twitter/features/auth/login_response_model.dart';
import 'package:demo_twitter/features/home/firebase_twitter_provider.dart';
import 'package:demo_twitter/features/home/twit_model.dart';
import 'package:demo_twitter/utils/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';

abstract class TwitterRepository {
  Future<Resource> postTwit(String message);

  Stream<Resource> getTwitList();
}

@provide
class FirebaseTwitterRepository implements TwitterRepository {
  final FirebaseTwitterProvider _provider;

  FirebaseTwitterRepository(this._provider);

  @override
  Future<Resource<TwitModel>> postTwit(String twit) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _provider.postTwit(TwitModel(twit, userInfo.email,
              null, userInfo.userId));
      return Resource.fromDynamic(
          data: documentSnapshot.data(), status: ResourceStatus.success);
    } catch (ex) {
      return Resource<TwitModel>(
          status: ResourceStatus.failed, message: ex.toString());
    }
  }

  @override
  Stream<Resource<TwitModel>> getTwitList() {
    // TODO: implement getTwitList
    return _provider.getTwitList().map<Resource<TwitModel>>((event) {
      return Resource.fromDynamic<TwitModel>(data: event.docs);
    });
  }
}
