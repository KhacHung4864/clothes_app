// ignore_for_file: no_leading_underscores_for_local_identifiers

class UserModel {
  String? message;
  UserData? data;
  String? status;
  String? token;

  UserModel({this.message, this.data, this.status, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    data = json["data"] == null ? null : UserData.fromJson(json["data"]);
    status = json["status"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    _data["status"] = status;
    _data["token"] = token;
    return _data;
  }
}

class UserData {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPassword;

  UserData({this.userId, this.userName, this.userEmail, this.userPassword});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    userName = json["user_name"];
    userEmail = json["user_email"];
    userPassword = json["user_password"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_id"] = userId;
    _data["user_name"] = userName;
    _data["user_email"] = userEmail;
    _data["user_password"] = userPassword;
    return _data;
  }
}
