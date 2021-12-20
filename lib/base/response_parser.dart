import 'package:demo_twitter/features/auth/login_response_model.dart';
import 'package:demo_twitter/features/home/twit_model.dart';

class ResponseParser {
  static T fromJson<T>(Map<String, dynamic> json) {
    switch (T) {
      case LoginResponseModel:
        return LoginResponseModel.fromJson(json) as T;
      case TwitModel:
        return TwitModel.fromJson(json) as T;
    }
    throw UnimplementedError("Model not added in ResponseParser");
  }
}
