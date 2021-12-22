import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_twitter/features/home/twit_model.dart';
import 'package:demo_twitter/utils/app_routes.dart';
import 'package:demo_twitter/utils/user_info.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class FirebaseMockUtils {
  static String userEmail="test@gmail.com";
  static String userPassword="abc123";
  static Future<MockFirebaseAuth> getMockFirebaseAuthAlreadySignedIn() async{
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    UserCredential userCredential= await mockFirebaseAuth.signInWithEmailAndPassword(
        email: userEmail, password: userPassword);
    userInfo.email=userCredential.user?.email??"";
    userInfo.refreshToken =userCredential.user?.refreshToken;
    return mockFirebaseAuth;
  }

  static Future<FakeFirebaseFirestore> getMockFirebaseFirestore() async{
    FakeFirebaseFirestore firebaseFirestore = FakeFirebaseFirestore();
    await firebaseFirestore.collection(FirestorePath.twits).add(TwitModel(
            "Fake test twit from test module",
            "test1@gmail.com",
            FieldValue.serverTimestamp(),
            "qwefhvadshjvasd")
        .toJson());
    return firebaseFirestore;
  }
}
