import 'package:flutter/cupertino.dart';

class BigAdviceScreen extends StatelessWidget {
  final String advice;

  BigAdviceScreen({this.advice});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        advice,
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
        textAlign: TextAlign.center,
      ),
    );
  }
}
