import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.token,
    required this.username,
  });
  late final String token;
  late final String username;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['username'] = username;
    return data;
  }
}

class Data {
  Data({
    required this.username,
    required this.email,
    required this.token,
  });
  late final String username;
  late final String email;
  late final String token;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}