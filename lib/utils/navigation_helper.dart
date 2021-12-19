import 'package:flutter/cupertino.dart';

Future showAnimatedNavigation(
  BuildContext context,
  Widget widget,
) async {
  await WidgetsBinding.instance?.waitUntilFirstFrameRasterized;
  return Navigator.of(context).push(createRoute(widget));
}

Route createRoute(final Widget _overlayMessage) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => _overlayMessage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
