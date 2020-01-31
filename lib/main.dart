import 'package:arch_sample/bloc/advice_bloc.dart';
import 'package:arch_sample/widget/advice_qr_screen.dart';
import 'package:arch_sample/widget/fab_bottom_bar_item.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _position = 0;
  List<Widget> tabs = <Widget>[
    AdviceQrScreen(bloc: AdviceBloc()),
    AdviceQrScreen(bloc: AdviceBloc()),
    AdviceQrScreen(bloc: AdviceBloc()),
    AdviceQrScreen(bloc: AdviceBloc()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Advice"),
            elevation: 0,
            centerTitle: true,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            elevation: 2.0,
          ),
          bottomNavigationBar: FABBottomAppBar(
            color: Colors.grey,
            selectedColor: Colors.red,
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
          )),
    );
  }
}
