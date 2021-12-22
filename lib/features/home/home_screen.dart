import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/home/twit_model.dart';
import 'package:demo_twitter/features/home/twitter_bloc.dart';
import 'package:demo_twitter/features/home/twitter_list_widget.dart';
import 'package:demo_twitter/utils/app_sizes.dart';
import 'package:demo_twitter/utils/dialog_helper.dart';
import 'package:demo_twitter/utils/format_validator.dart';
import 'package:demo_twitter/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenSate();
  }
}

class HomeScreenSate extends State<HomePage> with FieldValidators {
  final _formKey = GlobalKey<FormState>();
  final twitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                          validator: validateTwit,
                          maxLines: 3,
                          maxLength: 280,
                          textAlignVertical: TextAlignVertical.center,
                          buildCounter: null,
                          decoration: const InputDecoration(
                            labelText: "Type message",
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
      ),
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
        twitController.text = "";
        FocusScope.of(context).unfocus();
        showSnackBarMessage(context, "Posted successfully",
            backgroundColor: Colors.green);
      } else if (resource.status == ResourceStatus.failed) {
        showSnackBarMessage(context, resource.message ?? "Failed");
      }
    }
  }
}
