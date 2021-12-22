import 'dart:ui';
import 'package:demo_twitter/base/base_bloc.dart';
import 'package:demo_twitter/di/bloc_injector.dart';
import 'package:demo_twitter/features/auth/auth_bloc.dart';
import 'package:demo_twitter/features/auth/login_screen.dart';
import 'package:demo_twitter/features/home/home_screen.dart';
import 'package:demo_twitter/features/home/twitter_bloc.dart';
import 'package:demo_twitter/features/launch_screen.dart';
import 'package:demo_twitter/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final BlocInjector blocInjector = await BlocInjector.create();
  runApp(MainWidget(blocInjector));
}

class MainWidget extends StatefulWidget {
  final BlocInjector blocInjector;

  const MainWidget(this.blocInjector, {Key? key}) : super(key: key);

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
      theme: ThemeData(
          primaryColor: Colors.green,
          splashColor: Colors.blueGrey,
          secondaryHeaderColor: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          dividerColor: Colors.transparent,
          primarySwatch: Colors.green,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.black87, fontSize: 16),
            bodyText2: TextStyle(color: Colors.black54, fontSize: 14),
            button: TextStyle(color: Colors.white),
            headline1: TextStyle(color: Colors.white),
            subtitle2: TextStyle(color: Colors.black45),
          )),
      home: Provider<AuthBloc>(
        create: (context) => widget.blocInjector.authBloc,
        dispose: disposeBloc,
        child: LaunchScreen(),
      ),
      onGenerateRoute: getGenerateRoute,
    );
  }

  Route getGenerateRoute(RouteSettings settings) {
    Widget _widget;
    if (settings.name == AppRoutes.userLogin) {
      _widget = Provider<AuthBloc>(
        create: (context) => widget.blocInjector.authBloc,
        dispose: disposeBloc,
        child: const LoginPage(),
      );
    } else if (settings.name == AppRoutes.home) {
      _widget = Provider<TwitterBloc>(
        create: (context) => widget.blocInjector.twitterBloc,
        dispose: disposeBloc,
        child: const HomePage(),
      );
    } else {
      _widget = LaunchScreen();
    }
    return _createRoute(settings, _widget);
  }

  disposeBloc(BuildContext context, Bloc bloc) {
    bloc.dispose();
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
