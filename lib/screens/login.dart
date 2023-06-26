import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc_event.dart';
import 'package:graph_api_test_app/main.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,
              ),
              child: Text(
                'Please login with your facebook developer account to continue:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<MyBloc>(context).add(LoginEvent());
                isLoggedIn.value = true;
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
