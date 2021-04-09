import 'package:arch_sample/screens/big_advice_screen.dart';
import 'package:flutter/material.dart';

import 'bloc/advice_bloc.dart';
import 'screens/advice_qr_screen.dart';

enum TabItem { first, second, third, fourth }

class TabNavigatorRoutes {
  static const String root = '/';
  static const String qr = '/qr';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem, required this.globalNavigator});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final NavigatorState globalNavigator;

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }

  //Navigation routes
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {dynamic data}) {
    Widget rootItem;
    switch (tabItem) {
      case TabItem.first:
        rootItem = AdviceQrScreen(
          bloc: AdviceBloc(),
          onPush: (advice) => _push(context, TabNavigatorRoutes.qr, data: advice), //listener
          onGlobalPush: (advice) => _globalPush(context, TabNavigatorRoutes.qr, data: advice), //listener
          onPushReplacement: (advice) => _replaceScreen(context, TabNavigatorRoutes.qr, data: advice),
        );
        break;
      case TabItem.second:
        rootItem = AdviceQrScreen(
          bloc: AdviceBloc(),
          onPush: (advice) => _push(context, TabNavigatorRoutes.qr, data: advice), //listener
          onGlobalPush: (advice) => _globalPush(context, TabNavigatorRoutes.qr, data: advice), //listener
          onPushReplacement: (advice) => _replaceScreen(context, TabNavigatorRoutes.qr, data: advice),
        );
        break;
      case TabItem.third:
        rootItem = AdviceQrScreen(
          bloc: AdviceBloc(),
          onPush: (advice) => _push(context, TabNavigatorRoutes.qr, data: advice), //listener
          onGlobalPush: (advice) => _globalPush(context, TabNavigatorRoutes.qr, data: advice), //listener
          onPushReplacement: (advice) => _replaceScreen(context, TabNavigatorRoutes.qr, data: advice),
        );
        break;
      case TabItem.fourth:
        rootItem = Center();
        break;
    }

    return {
      TabNavigatorRoutes.root: (context) => rootItem,

      TabNavigatorRoutes.qr: (context) => BigAdviceScreen(advice: data)
    };
  }


  //Open screen locally
  void _push(BuildContext context, String route, {dynamic data}) {
    var routeBuilders = _routeBuilders(context, data: data);

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => routeBuilders[route]!(context),
      ),
    );
  }

  //Replace screen locally
  void _replaceScreen(BuildContext context, String route, {dynamic data}) {
    var routeBuilders = _routeBuilders(context, data: data);

    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => routeBuilders[route]!(context),
      ),
    );
  }

  //Open screen globally
  void _globalPush(BuildContext context, String route, {data: dynamic}) {
    var routeBuilders = _routeBuilders(context, data: data);

    globalNavigator.push(
      MaterialPageRoute(
        builder: (context) => routeBuilders[route]!(context),
      ),
    );
  }

  //Replace screen globally
  void _globalReplaceScreen(BuildContext context, String route) {
    var routeBuilders = _routeBuilders(context);

    globalNavigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => routeBuilders[route]!(context),
      ),
    );
  }

  void _globalPopWithCallback(BuildContext context) {
    globalNavigator.pop(true);
  }

  void _globalPushWithCallback(
      BuildContext context, String route, StatefulWidget callback) async {
    var routeBuilders = _routeBuilders(context, data: callback);

    final result = await globalNavigator.push(
      MaterialPageRoute(
        builder: (context) => routeBuilders[route]!(context),
      ),
    );

    if (result != null) {
      callback.createState();
    }
  }

  void _globalPushReplacementWithCallback(
      BuildContext context, String route, StatefulWidget callback) async {
    var routeBuilders = _routeBuilders(context, data: callback);

    final result = await globalNavigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => routeBuilders[route]!(context),
      ),
    );

    if (result != null) {
      callback.createState();
    }
  }

}
