import 'dart:async';
import 'package:demo_twitter/features/auth/auth_bloc.dart';
import 'package:demo_twitter/main.dart';
import 'package:demo_twitter/utils/app_routes.dart';
import 'package:demo_twitter/utils/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaunchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LaunchScreenState();
  }
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitAndCheckLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Icon(
          Icons.group,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  waitAndCheckLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    AuthBloc authBloc = Provider.of<AuthBloc>(context, listen: false);
    if (authBloc.isLoggedInUser) {
      authBloc.initializeUserInfo();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.userLogin);
    }
  }
}
