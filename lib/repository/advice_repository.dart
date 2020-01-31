import 'package:arch_sample/model/advice.dart';
import 'package:arch_sample/model/response.dart';
import 'package:arch_sample/network/advice_api_provider.dart';

class AdviceRepository {

  final adviceApiProvider = AdviceApiProvider();

  Future<BaseTypedResponse<Advice>> getRandomAdvice() =>
      adviceApiProvider.getRandomAdvice();

}