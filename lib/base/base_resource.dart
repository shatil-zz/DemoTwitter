import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Resource<T> fromDynamic<T>(
      {dynamic data,
      String? message,
      ResourceStatus status = ResourceStatus.empty,
      int code = 0}) {
    if (data is Map<String, dynamic>) {
      return Resource<T>(
          model: ResponseParser.fromJson<T>(data),
          message: message,
          status: status,
          code: code);
    } else if (data is List<QueryDocumentSnapshot<Map<String, dynamic>>>) {
      List<T> modelList = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> json in data) {
        modelList.add(ResponseParser.fromJson<T>(json.data()));
      }
      return Resource<T>(
          modelList: modelList, message: message, status: status, code: code);
    } else {
      return Resource<T>(
          model: data as T, message: message, status: status, code: code);
    }
  }

  @override
  String toString() {
    return 'Resource{status: $status, data: $model, message: $message, code: $code}';
  }
}

enum ResourceStatus { empty, loading, success, failed }
