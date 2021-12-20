import 'dart:ui';

import 'package:demo_twitter/utils/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppProgressDialog extends StatelessWidget {
  const AppProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Ink(
          child: InkWell(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(AppSize.paddingNormal),
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: AppSize.dialogSize,
                      height: AppSize.dialogSize,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ),
  );
}
