// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo_twitter/features/auth/auth_bloc.dart';
import 'package:demo_twitter/features/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'test_configs.dart';

void main() {
  setUp(() {
    return setWidgetTestConfig();
  });
  group('Login page widget test', () {
    Widget widget = Provider<AuthBloc>(
      create: (context) => blocInjector.authBloc,
      dispose: disposeBloc,
      child: const LoginPage(),
    );
    widget = wrapWithMaterialApp(widget);

    testWidgets('Login contain two text field', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(TextField), findsNWidgets(2));
    });
    testWidgets('Login contain email field', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.widgetWithText(TextField, "Email"),findsOneWidget);
    });
    testWidgets('Login contain password field', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.widgetWithText(TextField, "Password"),findsOneWidget);
    });
    testWidgets('Login contain login button', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.widgetWithText(MaterialButton, "Login"),findsOneWidget);
    });
  });
}
