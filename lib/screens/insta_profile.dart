import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc_event.dart';
import 'package:graph_api_test_app/bloc/my_bloc_state.dart';
import 'package:graph_api_test_app/data/instagram_profile.dart';

import '../data/media.dart';

class InstaProfile extends StatelessWidget {
  final ValueNotifier<bool> notifier = ValueNotifier<bool>(false);

  InstaProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: BlocBuilder<MyBloc, MyBlocState>(
          builder: (context, state) {
            if (state is GetInstagramUserState) {
              return Column(
                children: [
                  _profile(state.instaProfile),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<MyBloc>(context)
                          .add(ShowMediaEvent(state.instaProfile));
                    },
                    child: const Text('Get posts'),
                  ),
                ],
              );
            } else if (state is GetMediaState) {
              return Column(
                children: [
                  _profile(state.profile),
                  _mediaList(state.medias),
                ],
              );
            }
            return Container();
          },
        ));
  }

  Widget _profile(InstagramProfile profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(profile.profilePictureUrl),
              ),
              title: Text(profile.name),
              subtitle: Text(profile.username),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Followers: ${profile.followersCount}'),
              Text('Following: ${profile.followsCount}'),
              Text('Media: ${profile.mediaCount}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mediaList(List<Media> medias) {
    return Flexible(
      child: ListView.builder(
        itemCount: medias.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(medias[index].mediaUrl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () => notifier.value = !notifier.value,
                    label: const Text('Comments'),
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.heart_fill),
                    label: Text('${medias[index].likeCount}'),
                  ),
                ],
              ),
              _commentsList(medias[index].comments),
              const Divider(
                thickness: 3.0,
                indent: 2.0,
                endIndent: 2.0,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _commentsList(List comments) {
    return Flexible(
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, _) => value == true
            ? SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(comments[index]['username']),
                      subtitle: Text(comments[index]['text']),
                    );
                  },
                ),
              )
            : Container(),
      ),
    );
  }
}
