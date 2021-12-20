import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/home/twit_model.dart';
import 'package:demo_twitter/features/home/twitter_bloc.dart';
import 'package:demo_twitter/features/home/twitter_list_widget.dart';
import 'package:demo_twitter/utils/app_sizes.dart';
import 'package:demo_twitter/utils/dialog_helper.dart';
import 'package:demo_twitter/utils/navigation_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenSate();
  }
}

class HomeScreenSate extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final twitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Container(
          padding: const EdgeInsets.all(AppSize.paddingNormal),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: twitController,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Type message";
                          }
                        },
                        maxLines: 3,
                        maxLength: 280,
                        buildCounter: null,
                        decoration: const InputDecoration(
                          labelText: "Please enter a message",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.paddingNormal,
                    ),
                    MaterialButton(
                      onPressed: postTwit,
                      child: Text(
                        "Post",
                        style: Theme.of(context).textTheme.button,
                      ),
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              const TwitterListWidget(
                key: Key("twit_list"),
              )
            ],
          )),
    );
  }

  postTwit() async {
    if (_formKey.currentState?.validate() ?? false) {
      showAnimatedNavigation(context, const AppProgressDialog());
      TwitterBloc twitBloc = Provider.of<TwitterBloc>(context, listen: false);
      Resource<TwitModel> resource =
          await twitBloc.postTwit(twitController.text);
      Navigator.pop(context);
      if (resource.status == ResourceStatus.success) {
        showSnackBarMessage(context, "Posted successfully",
            backgroundColor: Colors.green);
      } else if (resource.status == ResourceStatus.failed) {
        showSnackBarMessage(context, resource.message ?? "Failed");
      }
    }
  }
}
