class BaseTypedResponse<T> {

  int? status;
  T data;
  String? error;

  BaseTypedResponse({this.status, this.error, required this.data});

}