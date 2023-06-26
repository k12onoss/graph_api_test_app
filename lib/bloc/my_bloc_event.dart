import 'package:graph_api_test_app/bloc/my_bloc_state.dart';
import 'package:graph_api_test_app/data/instagram_profile.dart';

abstract class MyBlocEvent {}

class LoginEvent extends MyBlocEvent {}

class LogoutEvent extends MyBlocEvent {}

class ShowHomeEvent extends MyBlocEvent {}

class ShowInstagramUserEvent extends MyBlocEvent {
  String pageID;

  ShowInstagramUserEvent(this.pageID);
}

class ShowMediaEvent extends MyBlocEvent {
  InstagramProfile profile;

  ShowMediaEvent(this.profile);
}

class ReturnToHomeEvent extends MyBlocEvent {
  MyBlocState state;

  ReturnToHomeEvent(this.state);
}
