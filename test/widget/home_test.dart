import 'package:demo_twitter/features/auth/auth_bloc.dart';
import 'package:demo_twitter/features/auth/login_screen.dart';
import 'package:demo_twitter/features/home/home_screen.dart';
import 'package:demo_twitter/features/home/twitter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'test_configs.dart';

void main() {
  setUp(() {
    return setWidgetTestConfig();
  });
  group('Home page widget test', () {
    Widget widget = Provider<TwitterBloc>(
      create: (context) => blocInjector.twitterBloc,
      dispose: disposeBloc,
      child: const HomePage(),
    );
    widget = wrapWithMaterialApp(widget);

    testWidgets('Home page contains twit field', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(TextField), findsNWidgets(1));
      expect(find.widgetWithText(TextField, "Type message"), findsOneWidget);
    });
    testWidgets('Twit post test', (tester) async {
      await tester.pumpWidget(widget);
      await tester.enterText(find.byType(TextField), "Hello from widget test");
      await tester.pumpAndSettle();
      expect(find.text("Fake test twit from test module"), findsOneWidget);
      await tester.tap(find.widgetWithText(MaterialButton, "Post"));
      await tester.pump(const Duration(seconds: 5));
      await tester.enterText(find.byType(TextField), "Again Hello from widget test");
      expect(find.text("Hello from widget test"), findsOneWidget);
    });
  });
}
