import 'package:demo_twitter/base/base_bloc.dart';
import 'package:demo_twitter/di/bloc_injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../mock_utils/firebase_mock_utils.dart';

late BlocInjector blocInjector;

setWidgetTestConfig() async {
  blocInjector = await BlocInjector.create(
      firebaseAuth: await FirebaseMockUtils.getMockFirebaseAuthAlreadySignedIn(),
      firebaseFirestore: await FirebaseMockUtils.getMockFirebaseFirestore());
}

disposeBloc(BuildContext context, Bloc bloc) {
  bloc.dispose();
}

Widget wrapWithMaterialApp(Widget widget) {
  return MaterialApp(home: widget);
}
