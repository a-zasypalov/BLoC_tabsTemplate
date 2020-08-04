import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QrScannedScreen extends StatelessWidget {
  final String advice;

  QrScannedScreen({this.advice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$advice",
                height: 256,
                width: 256,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                advice,
                //textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}