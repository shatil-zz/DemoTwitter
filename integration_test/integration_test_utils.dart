import 'package:demo_twitter/di/bloc_injector.dart';
import 'package:demo_twitter/main.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../mock_utils/firebase_mock_utils.dart';
import 'package:demo_twitter/mock_main.dart' as app;

startAppForPostATwit(WidgetTester tester) async {
  blocInjector = await BlocInjector.create(
      firebaseAuth: MockFirebaseAuth(),
      firebaseFirestore: await FirebaseMockUtils.getMockFirebaseFirestore());
  app.main();
  //Wait for splash page to finish
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
}

userLogin(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.enterText(
      find.widgetWithText(TextField, "Email"), "test@gmail1.com");
  await tester.pumpAndSettle();
  await tester.enterText(find.widgetWithText(TextField, "Password"), "abc123");
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(MaterialButton, "Login"));
  await tester.pumpAndSettle();
}

createPost(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 2));
  await tester.enterText(find.byType(TextField), "Hello from widget test");
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(MaterialButton, "Post"));
  await tester.pump(const Duration(seconds: 1));
  expect(find.text("Hello from widget test"), findsOneWidget);
  await tester.pump(const Duration(seconds: 5));
}
