import 'dart:convert';

import 'package:arch_sample/model/advice.dart';
import 'package:arch_sample/model/response.dart';
import 'package:http/http.dart';

class AdviceApiProvider {
  Client client = Client();

  Future<BaseTypedResponse<Advice>> getRandomAdvice() async {

    try {
      final response = await client.get(Uri.https('api.adviceslip.com', '/advice'));

      if (response.statusCode == 200) {
        return BaseTypedResponse<Advice>(
            data: Advice.fromJson(json.decode(response.body)['slip'])
        );
      } else {
        throw Exception(response.body);
      }

    } catch (SocketException) {
      throw SocketException;
    }

  }

}
