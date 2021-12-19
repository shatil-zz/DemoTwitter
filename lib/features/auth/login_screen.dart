import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/auth/auth_bloc.dart';
import 'package:demo_twitter/utils/app_sizes.dart';
import 'package:demo_twitter/utils/dialog_helper.dart';
import 'package:demo_twitter/utils/navigation_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthBloc>(context,listen: false).loginDataStream.listen((event) {
      if (event.status == ResourceStatus.loading) {
        showAnimatedNavigation(
            context,
            const CircularProgressIndicator(
                color: Colors.white, backgroundColor: Colors.transparent));
      } else if (event.status == ResourceStatus.success) {
        Navigator.pop(context);
      } else if (event.status == ResourceStatus.failed) {
        showSnackBarMessage(context, event.message ?? "Failed");
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please enter your email";
                  }
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please enter your password";
                  }
                },
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                onEditingComplete: submitLoginRequest,
              ),
            ],
          ),
        ),
      ),
    );
  }

  submitLoginRequest() {
    if (_formKey.currentState?.validate() ?? false) {
      Provider.of<AuthBloc>(context,listen: false)
          .emailLogin(emailController.text, passwordController.text);
    }
  }
}
