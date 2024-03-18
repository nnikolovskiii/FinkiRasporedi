class RegisterRequestModel {
  RegisterRequestModel({
    this.username,
    this.password,
    this.email,
  });
  late final String? username;
  late final String? password;
  late final String? email;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    return data;
  }
}