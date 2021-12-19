import 'package:demo_twitter/features/auth/login_response_model.dart';

class ResponseParser {
  static T fromJson<T>(Map<String, dynamic> json) {
    switch (T) {
      case LoginResponseModel:
        return LoginResponseModel.fromJson(json) as T;
    }
    throw UnimplementedError("Model not added in ResponseParser");
  }
}
