
class Advice {
  String slip_id;
  String advice;

  Advice({this.slip_id, this.advice});

  Advice.fromJson(Map<String, dynamic> parsedJson) {
    slip_id = parsedJson['slip_id'];
    advice = parsedJson['advice'];
  }
}
