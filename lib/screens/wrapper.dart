import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc_event.dart';
import 'package:graph_api_test_app/screens/home.dart';
import 'package:graph_api_test_app/screens/login.dart';

import '../bloc/my_bloc.dart';

class Wrapper extends StatelessWidget {
  final bool isLoggedIn;

  const Wrapper(this.isLoggedIn, {super.key});

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      BlocProvider.of<MyBloc>(context).add(ShowHomeEvent());
      return Home();
    }
    return isLoggedIn ? Home() : const Login();
  }
}
