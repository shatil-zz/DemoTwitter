import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';

@module
class BlocModule {
  FirebaseFirestore _firebaseFirestore;

  FirebaseAuth _firebaseAuth;

  BlocModule(this._firebaseFirestore, this._firebaseAuth);

  @provide
  FirebaseAuth firebaseAuth() => _firebaseAuth;

  @provide
  FirebaseFirestore firebaseFirestore() => _firebaseFirestore;
}
