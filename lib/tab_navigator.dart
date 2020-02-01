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
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, String advice) {
    var routeBuilders = _routeBuilders(context, advice: advice);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.qr](context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {String advice}) {
    return {
      TabNavigatorRoutes.root: (context) => AdviceQrScreen(
            bloc: AdviceBloc(),
            onPush: (advice) => _push(context, advice),
          ),
      TabNavigatorRoutes.qr: (context) => BigAdviceScreen(
            advice: advice,
          )
    };
  }

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
}