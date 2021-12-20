import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_twitter/di/bloc_module.dart';
import 'package:demo_twitter/features/auth/auth_bloc.dart';
import 'package:demo_twitter/features/auth/auth_repository.dart';
import 'package:demo_twitter/features/home/twitter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';

import 'bloc_injector.inject.dart' as g;

@Injector([BlocModule])
abstract class BlocInjector {
  @provide
  FirebaseAuth get firebaseAuth;

  @provide
  FirebaseFirestore get firebaseFirestore;

  @provide
  @singleton
  FirebaseAuthRepository get authRepository;

  @provide
  AuthBloc get authBloc;

  @provide
  TwitterBloc get twitterBloc;

  static Future<BlocInjector> create(
      {FirebaseFirestore? firebaseFirestore, FirebaseAuth? firebaseAuth}) {
    return g.BlocInjector$Injector.create(BlocModule(
        firebaseFirestore ?? FirebaseFirestore.instance,
        firebaseAuth ?? FirebaseAuth.instance));
  }
}
