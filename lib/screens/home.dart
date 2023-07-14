import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc_event.dart';
import 'package:graph_api_test_app/bloc/my_bloc_state.dart';
import 'package:graph_api_test_app/data/profile.dart';
import 'package:graph_api_test_app/main.dart';
import 'package:graph_api_test_app/router.dart';
import '../data/facebook_page.dart';

class Home extends StatelessWidget {
  final ValueNotifier<bool> _buttonNotifier = ValueNotifier<bool>(false);
  late final String _pageID;

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<MyBloc>(context).add(LogoutEvent());
              isLoggedIn.value = false;
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          )
        ],
      ),
      body: BlocBuilder<MyBloc, MyBlocState>(
        builder: (context, state) {
          if (state is GetHomeDataState) {
            return Column(
              children: [
                _profile(state.profile),
                _pages(state.pages.listOfPages),
                ValueListenableBuilder(
                  valueListenable: _buttonNotifier,
                  builder: (context, value, _) => value == true
                      ? ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<MyBloc>(context)
                                .add(ShowInstagramUserEvent(_pageID));
                            MyRouterDelegate.find().pushPage('/instaProfile');
                          },
                          child: const Text('Get Insta account'),
                        )
                      : Container(),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _profile(Profile profile) {
    return Column(
      children: [
        if (profile.imageUrl != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profile.imageUrl!),
          ),
        Text('Name: ${profile.name}'),
        if (profile.email != null) Text('Email: ${profile.email}'),
      ],
    );
  }

  Widget _pages(List<FacebookPage> pages) {
    return Expanded(
      child: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return GestureDetector(
            onTap: () {
              _pageID = pages[index].id;
              _buttonNotifier.value = true;
            },
            child: Card(
              child: ListTile(
                title: Text(page.name),
              ),
            ),
          );
        },
      ),
    );
  }
}
