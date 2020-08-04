import 'package:flutter/material.dart';

class BigAdviceScreen extends StatelessWidget {
  final String advice;

  BigAdviceScreen({this.advice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              advice,
              style: TextStyle(fontSize: 32),
              //textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
