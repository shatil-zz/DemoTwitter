import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_twitter/features/home/twit_model.dart';
import 'package:demo_twitter/utils/app_routes.dart';
import 'package:inject/inject.dart';

@provide
class FirebaseTwitterProvider {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseTwitterProvider(this._firebaseFirestore);

  Future<DocumentSnapshot<Map<String, dynamic>>> postTwit(
      TwitModel twitModel) async {
    Map<String, dynamic> request = twitModel.toJson();
    request["createdAt"] = FieldValue.serverTimestamp();
    return (await _firebaseFirestore
            .collection(FirestorePath.twits)
            .add(request))
        .snapshots()
        .first;
  }

  Stream<QuerySnapshot> getTwitList() {
    return _firebaseFirestore
        .collection(FirestorePath.twits)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }
}
