import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_api_test_app/data/api.dart';
import 'package:graph_api_test_app/database.dart';
import 'package:graph_api_test_app/router.dart';
import '../data/media.dart';
import 'my_bloc_event.dart';
import 'my_bloc_state.dart';

class MyBloc extends Bloc<MyBlocEvent, MyBlocState> {
  MyBloc() : super(InitialState()) {
    FacebookAPI api = FacebookAPI();
    Database database = Database();

    on<MyBlocEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          await api.login();

          MyRouterDelegate.find().pushPage('/home');
          emit(LoggedInState());
        } else if (event is LogoutEvent) {
          await api.logout();

          emit(LoggedOutState());
        } else if (event is ShowHomeEvent) {
          final profile = await api.getProfile();
          final pages = await api.getUsersPages();

          emit(GetHomeDataState(
            profile: profile,
            pages: pages,
          ));
        } else if (event is ShowInstagramUserEvent) {
          final instaID = await api.getInstagramAccountID(event.pageID);
          final instaProfile = await api.getInstagramUser(instaID);

          database.updateFollowersAndFollowing(
            followers: instaProfile.followersCount,
            following: instaProfile.followsCount,
          );

          emit(GetInstagramUserState(instaProfile));
        } else if (event is ShowMediaEvent) {
          final medias = await Future.wait(
            List.generate(
              event.profile.mediaIDs.length,
              (index) => api.getMedia(event.profile.mediaIDs[index]),
            ),
          );

          for (Media media in medias) {
            database.updateCommentsAndLikes(
              media.id,
              comments: media.comments,
              likes: media.likeCount,
            );
          }

          emit(GetMediaState(medias: medias, profile: event.profile));
        }
      },
    );
  }
}
