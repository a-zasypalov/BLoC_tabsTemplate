import 'package:arch_sample/bloc/advice_bloc.dart';
import 'package:arch_sample/widget/advice_qr_screen.dart';
import 'package:arch_sample/widget/fab_bottom_bar_item.dart';
import 'package:flutter/material.dart';

import 'package:qrscan/qrscan.dart' as scanner;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.indigo, accentColor: Colors.redAccent),
        home: HomeWidget());
  }
}

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {
  int _position = 0;
  List<Widget> tabs = <Widget>[
    AdviceQrScreen(bloc: AdviceBloc()),
    AdviceQrScreen(bloc: AdviceBloc()),
    AdviceQrScreen(bloc: AdviceBloc()),
    AdviceQrScreen(bloc: AdviceBloc()),
  ];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //Check if keyboard is visible
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
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
                await scanner.scan().then((value) => {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(value),
                      ))
                    })
              },
              child: Icon(Icons.add),
              elevation: 2.0,
            )
          : null,
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: Theme.of(context).accentColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) => {
          setState(() {
            _position = index;
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
        index: _position,
        children: tabs,
      ),
    );
  }
}
