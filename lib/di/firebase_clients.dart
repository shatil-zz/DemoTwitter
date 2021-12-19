import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseClients {
  FirebaseFirestore firebaseFirestore;

  FirebaseAuth firebaseAuth;

  FirebaseClients(this.firebaseFirestore, this.firebaseAuth);
}
