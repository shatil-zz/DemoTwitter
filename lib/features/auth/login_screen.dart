import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/auth/auth_bloc.dart';
import 'package:demo_twitter/features/auth/login_response_model.dart';
import 'package:demo_twitter/utils/app_routes.dart';
import 'package:demo_twitter/utils/app_sizes.dart';
import 'package:demo_twitter/utils/dialog_helper.dart';
import 'package:demo_twitter/utils/format_validator.dart';
import 'package:demo_twitter/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> with FieldValidators {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: validateEmail,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: AppSize.paddingNormal,
              ),
              TextFormField(
                controller: passwordController,
                maxLength: 16,
                validator: validatePassword,
                obscuringCharacter: "*",
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                onEditingComplete: submitLoginRequest,
              ),
              const SizedBox(
                height: AppSize.paddingNormal,
              ),
              MaterialButton(
                onPressed: submitLoginRequest,
                minWidth: double.infinity,
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.button,
                ),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  submitLoginRequest() async {
    if (_formKey.currentState?.validate() ?? false) {
      showAnimatedNavigation(context, const AppProgressDialog());
      AuthBloc authBloc = Provider.of<AuthBloc>(context, listen: false);
      Resource<LoginResponseModel> resource = await authBloc.emailLogin(
          emailController.text.trim(), passwordController.text);
      Navigator.pop(context);
      if (resource.status == ResourceStatus.success) {
        authBloc.initializeUserInfo();
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } else if (resource.status == ResourceStatus.failed) {
        showSnackBarMessage(context, resource.message ?? "Failed");
      }
    }
  }
}
