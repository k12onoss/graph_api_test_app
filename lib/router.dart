import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc.dart';
import 'package:graph_api_test_app/bloc/my_bloc_event.dart';
import 'package:graph_api_test_app/bloc/my_bloc_state.dart';
import 'package:graph_api_test_app/screens/insta_profile.dart';
import 'package:graph_api_test_app/screens/wrapper.dart';

class MyRouterDelegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  bool isLoggedIn;
  final _pages = <Page>[];
  late MyBlocState _previousHomeState;

  MyRouterDelegate(this.isLoggedIn) {
    _pages.add(MaterialPage(
      child: Wrapper(isLoggedIn),
      name: '/wrapper',
      key: const ValueKey('/wrapper'),
    ));
  }

  static late MyRouterDelegate? _myRouterDelegate;

  static void put(MyRouterDelegate myRouterDelegate) {
    _myRouterDelegate = myRouterDelegate;
  }

  static MyRouterDelegate find() {
    return _myRouterDelegate!;
  }

  void pushPage(String routeName, [Object? arguments]) {
    Widget child;

    switch (routeName) {
      case '/instaProfile':
        {
          _previousHomeState =
              BlocProvider.of<MyBloc>(navigatorKey!.currentState!.context)
                  .state;
          child = InstaProfile();
        }
        break;
      default:
        {
          child = Wrapper(isLoggedIn);
        }
    }

    _pages.add(
      MaterialPage(
        child: child,
        key: ValueKey(routeName),
        name: routeName,
        arguments: arguments,
      ),
    );

    notifyListeners();
  }

  @override
  Future<bool> popRoute() {
    if (_pages.length > 1) {
      final poppedPage = _pages.removeLast();

      if (poppedPage.name == '/instaProfile') {
        BlocProvider.of<MyBloc>(navigatorKey!.currentState!.context)
            .add(ReturnToHomeEvent(_previousHomeState));
      }

      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;

    popRoute();
    return true;
  }

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {}

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
    );
  }
}
