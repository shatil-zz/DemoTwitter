import 'package:demo_twitter/di/bloc_injector.dart';
import 'package:demo_twitter/main.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test_driver.dart';
import '../mock_utils/firebase_mock_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final BlocInjector blocInjector = await BlocInjector.create(
      firebaseAuth: MockFirebaseAuth(),
      firebaseFirestore: await FirebaseMockUtils.getMockFirebaseFirestore());
  runApp(MainWidget(blocInjector));
  return integrationDriver();
}
