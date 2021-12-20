class UserInfo {
  String? email;
  String? refreshToken;
  String? userId;

  static final _info = UserInfo._internal();

  UserInfo._internal();

  factory UserInfo() {
    return _info;
  }
}

final UserInfo userInfo = UserInfo();
