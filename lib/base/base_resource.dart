import 'package:demo_twitter/base/response_parser.dart';

class Resource {
  ResourceStatus status;
  dynamic data;
  String? message;
  int code;

  Resource(
      {this.data,
      this.message,
      this.status = ResourceStatus.empty,
      this.code = 0});

  T? getModel<T>() {
    return ResponseParser.fromJson(data);
  }

  List<T>? getListOfModel<T>() {
    List<T> modelList = [];
    for (dynamic json in (data as List)) {
      modelList.add(ResponseParser.fromJson(json));
    }
    return modelList;
  }

  @override
  String toString() {
    return 'Resource{status: $status, data: $data, message: $message, code: $code}';
  }
}

enum ResourceStatus { empty, loading, success, failed }
