import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/home/twit_model.dart';
import 'package:demo_twitter/features/home/twitter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TwitterListWidget extends StatefulWidget {
  const TwitterListWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwitterListState();
  }
}

class TwitterListState extends State<TwitterListWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TwitterBloc>(context, listen: false).loadTwits();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<TwitterBloc>(
      builder: (context, bloc, child) {
        return StreamBuilder<Resource<TwitModel>>(
          stream: bloc.twitListStream,
          builder: (context, snapshot) {
            Resource<TwitModel>? resource = snapshot.data;
            if (resource?.modelList != null) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data?.modelList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Text(resource!.modelList![index].twit ?? "");
                  });
            }
            return Container();
          },
        );
      },
    );
  }
}
