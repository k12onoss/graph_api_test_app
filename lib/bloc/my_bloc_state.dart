import 'package:graph_api_test_app/data/facebook_page.dart';
import 'package:graph_api_test_app/data/instagram_profile.dart';
import 'package:graph_api_test_app/data/profile.dart';

import '../data/media.dart';

abstract class MyBlocState {}

class InitialState extends MyBlocState {}

class LoggedInState extends MyBlocState {}

class LoggedOutState extends MyBlocState {}

class GetHomeDataState extends MyBlocState {
  Profile profile;
  PageAPIResponse pages;

  GetHomeDataState ({required this.profile, required this.pages,});
}

class GetInstagramUserState extends MyBlocState {
  InstagramProfile instaProfile;

  GetInstagramUserState(this.instaProfile);
}

class GetMediaState extends MyBlocState {
  InstagramProfile profile;
  List<Media> medias;

  GetMediaState({required this.profile, required this.medias});
}
