import 'package:arch_sample/model/advice.dart';
import 'package:arch_sample/model/response.dart';
import 'package:arch_sample/repository/advice_repository.dart';
import 'package:rxdart/rxdart.dart';

class AdviceBloc {

  final _repository = AdviceRepository();
  final _adviceFetcher = PublishSubject<Advice>();

  Observable<Advice> get adviceStream => _adviceFetcher.stream;

  getRandomAdvice(bool refresh) async {

    if (refresh) {
      _adviceFetcher.sink.add(null);
    }

    try {
      BaseTypedResponse<Advice> response = await _repository.getRandomAdvice();

      if (response.data != null) {
        _adviceFetcher.sink.add(response.data);
      }

    } catch (SocketException) {
      _adviceFetcher.sink.addError("No internet!");
    }

  }

  dispose() {
    _adviceFetcher.close();
  }

}
