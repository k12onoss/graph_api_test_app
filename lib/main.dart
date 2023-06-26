import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc.dart';
import 'package:graph_api_test_app/data/api.dart';
import 'package:graph_api_test_app/router.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

final ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // print(
    //     "Native called background task: $backgroundTask"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager().registerPeriodicTask(
    "periodic-task-identifier",
    "simplePeriodicTask",
    // When no frequency is provided the default 15 minutes is set.
    // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
    frequency: const Duration(hours: 24),
  );
  isLoggedIn.value = await getAuthStatus();
  runApp(const MyApp());
}

Future<bool> getAuthStatus() async {
  return await FacebookAPI().isLoggedIn;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoggedIn,
      builder: (BuildContext context, bool value, Widget? child) {
        final routerDelegate = MyRouterDelegate(value);
        MyRouterDelegate.put(routerDelegate);

        return MaterialApp(
          home: BlocProvider(
            create: (context) => MyBloc(),
            child: Router(
              routerDelegate: routerDelegate,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          ),
        );
      },
    );
  }
}
