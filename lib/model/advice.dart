
class Advice {
  String? slipId;
  String? advice;

  Advice({this.slipId, this.advice});

  Advice.fromJson(Map<String, dynamic> parsedJson) {
    slipId = parsedJson['slip_id'];
    advice = parsedJson['advice'];
  }
}
