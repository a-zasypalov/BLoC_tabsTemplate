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
  TabNavigator({this.navigatorKey, this.tabItem, this.globalNavigator});

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
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }

  //Navigation routes
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {String advice}) {
    return {

      //Route to first screen
      TabNavigatorRoutes.root: (context) => AdviceQrScreen(
        bloc: AdviceBloc(),
        onPush: (advice) => _push(context, advice), //listener
        onGlobalPush: (advice) => _globalPush(context, advice), //listener
      ),

      //Route to second screen
      TabNavigatorRoutes.qr: (context) => BigAdviceScreen(
        advice: advice,
      )

    };
  }


  //Open second screen locally
  void _push(BuildContext context, String advice) {
    var routeBuilders = _routeBuilders(context, advice: advice);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.qr](context),
      ),
    );
  }

  //Open second screen globally
  void _globalPush(BuildContext context, String advice) {
    var routeBuilders = _routeBuilders(context, advice: advice);

    globalNavigator.push(
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.qr](context),
      ),
    );
  }
}
