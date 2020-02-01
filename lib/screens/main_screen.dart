import 'package:arch_sample/screens/qr_scanned_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arch_sample/widgets/fab_bottom_bar_item.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../tab_navigator.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {
  int _currentTabPosition = 0;
  Map<TabItem, GlobalKey<NavigatorState>> _tabs = {
    TabItem.first: GlobalKey<NavigatorState>(),
    TabItem.second: GlobalKey<NavigatorState>(),
    TabItem.third: GlobalKey<NavigatorState>(),
    TabItem.fourth: GlobalKey<NavigatorState>(),
  };

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //Check if keyboard is visible
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _tabs.values
            .toList()[_currentTabPosition]
            .currentState
            .maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTabPosition != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
        }
        //let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Advice"),
          elevation: 2.0,
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab //Hide FAB if keyboard is visible
            ? FloatingActionButton(
                onPressed: () async => {
                  await scanner.scan().then(
                      (value) => {_openQrcannedValueGlobally(value, context)})
                },
                child: Icon(Icons.add),
                elevation: 2.0,
              )
            : null,
        bottomNavigationBar: FABBottomAppBar(
          color: Colors.grey,
          selectedColor: Theme.of(context).accentColor,
          notchedShape: CircularNotchedRectangle(),
          selectedIndex: _currentTabPosition,
          onTabSelected: (index) => {
            setState(() {
              _currentTabPosition = index;
            })
          },
          items: [
            FABBottomAppBarItem(iconData: Icons.menu, text: 'This'),
            FABBottomAppBarItem(iconData: Icons.layers, text: 'Is'),
            FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Bottom'),
            FABBottomAppBarItem(iconData: Icons.info, text: 'Bar'),
          ],
        ),
        body: IndexedStack(
          index: _currentTabPosition,
          children: <Widget>[
            _buildOffstageNavigator(TabItem.first),
            _buildOffstageNavigator(TabItem.second),
            _buildOffstageNavigator(TabItem.third),
            _buildOffstageNavigator(TabItem.fourth),
          ],
        ),
      ),
    );
  }

  void _openQrcannedValueGlobally(String value, BuildContext context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => QrScannedScreen(
              advice: value,
            )));
  }

  void _selectTab(int tabIndex) {
    if (tabIndex == _currentTabPosition) {
      // pop to first route
      _tabs.values
          .toList()[_currentTabPosition]
          .currentState
          .popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTabPosition = tabIndex);
    }
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _tabs.keys.toList()[_currentTabPosition] != tabItem,
      child: TabNavigator(
        navigatorKey: _tabs[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
