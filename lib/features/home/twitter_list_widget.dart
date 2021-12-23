import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_twitter/base/base_resource.dart';
import 'package:demo_twitter/features/home/twit_model.dart';
import 'package:demo_twitter/features/home/twitter_bloc.dart';
import 'package:demo_twitter/utils/app_sizes.dart';
import 'package:demo_twitter/utils/format_helper.dart';
import 'package:flutter/material.dart';
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
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.modelList!.length,
                  itemBuilder: (context, index) {
                    TwitModel twitModel = resource!.modelList![index];
                    return Card(
                      margin: const EdgeInsets.all(AppSize.cardMargin),
                      elevation: AppSize.cardElevation,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSize.paddingNormal),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (twitModel.twit != null)
                              Text(
                                twitModel.twit ?? "",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            const SizedBox(
                              height: AppSize.textPaddingMedium,
                            ),
                            if (twitModel.twitBy != null)
                              Text(
                                "By ${twitModel.twitBy}",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            const SizedBox(
                              height: AppSize.textPaddingSmall,
                            ),
                            if (twitModel.createdAt != null)
                              Text(
                                "Posted at ${DateTimeFormatter.getDisplayDateTime(twitModel.createdAt)}",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        );
      },
    );
  }
}
