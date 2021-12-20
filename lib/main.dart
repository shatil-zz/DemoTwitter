import 'dart:ui';
import 'package:demo_twitter/di/bloc_injector.dart';
import 'package:demo_twitter/features/auth/auth_bloc.dart';
import 'package:demo_twitter/features/auth/login_screen.dart';
import 'package:demo_twitter/features/home/home_screen.dart';
import 'package:demo_twitter/features/launch_screen.dart';
import 'package:demo_twitter/utils/app_routes.dart';
import 'package:demo_twitter/utils/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late BlocInjector blocInjector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  blocInjector = await BlocInjector.create();
  runApp(MainWidget());
}

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      home: Provider<AuthBloc>.value(
        value: blocInjector.authBloc,
        child: LaunchScreen(),
      ),
      onGenerateRoute: getGenerateRoute,
    );
  }

  Route getGenerateRoute(RouteSettings settings) {
    Widget _widget;
    if (settings.name == AppRoutes.userLogin) {
      _widget = Provider<AuthBloc>.value(
        value: blocInjector.authBloc,
        child: const LoginPage(),
      );
    } else if (settings.name == AppRoutes.home) {
      _widget = Provider<AuthBloc>.value(
        value: blocInjector.authBloc,
        child: const HomeScreen(),
      );
    } else {
      _widget = LaunchScreen();
    }
    return _createRoute(settings, _widget);
  }

  Route _createRoute(final RouteSettings _settings, final _widget) {
    return PageRouteBuilder(
      settings: _settings,
      pageBuilder: (context, animation, secondaryAnimation) => _widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
