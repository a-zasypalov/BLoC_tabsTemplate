import 'package:arch_sample/bloc/advice_bloc.dart';
import 'package:arch_sample/model/advice.dart';
import 'package:flutter/material.dart';

class AdviceQrScreen extends StatefulWidget{
  AdviceBloc bloc;

  AdviceQrScreen({this.bloc});

  @override
  State<StatefulWidget> createState() {
    return AdviceQrScreenState();
  }
}

class AdviceQrScreenState extends State<AdviceQrScreen>  with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: widget.bloc.adviceStream,
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
                    "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${snapshot
                        .data.advice}",
                    height: 128,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    onPressed: () =>
                    {
                      widget.bloc.getRandomAdvice(true),
                    },
                    child: Text('Refresh'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    onPressed: () =>
                    {
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

        widget.bloc.getRandomAdvice(false);
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

}
