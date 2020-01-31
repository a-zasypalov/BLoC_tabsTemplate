import 'package:arch_sample/bloc/advice_bloc.dart';
import 'package:arch_sample/model/advice.dart';
import 'package:flutter/material.dart';

class AdviceQrScreen extends StatelessWidget {
  AdviceBloc bloc = AdviceBloc();

  @override
  Widget build(BuildContext context) {
    bloc.getRandomAdvice(false);

    return StreamBuilder(
      stream: bloc.adviceStream,
      builder: (context, AsyncSnapshot<Advice> snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    snapshot.data.advice,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${snapshot.data.advice}",
                    height: 128,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    onPressed: () => {
                      bloc.getRandomAdvice(true),
                    },
                    child: Text('Refresh'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    onPressed: () => {

                    },
                    child: Text('Push'),
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
