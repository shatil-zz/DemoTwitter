import 'package:demo_twitter/base/response_parser.dart';

class Resource<T> {
  ResourceStatus status;
  T? model;
  List<T>? modelList;
  String? message;
  int code;

  Resource(
      {this.model,
      this.modelList,
      this.message,
      this.status = ResourceStatus.empty,
      this.code = 0});

  factory Resource.fromDynamic(
      {dynamic data,
      String? message,
      ResourceStatus status = ResourceStatus.empty,
      int code = 0}) {
    if (data is Map<String, dynamic>) {
      return Resource(
          model: ResponseParser.fromJson<T>(data),
          message: message,
          status: status,
          code: code);
    } else if (data is List) {
      List<T> modelList = [];
      for (dynamic json in data) {
        modelList.add(ResponseParser.fromJson(json));
      }
      return Resource(
          modelList: modelList, message: message, status: status, code: code);
    } else {
      return Resource(
          model: data as T, message: message, status: status, code: code);
    }
  }

  @override
  String toString() {
    return 'Resource{status: $status, data: $model, message: $message, code: $code}';
  }
}

enum ResourceStatus { empty, loading, success, failed }
