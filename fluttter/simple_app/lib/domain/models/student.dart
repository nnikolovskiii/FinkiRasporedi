class Student {
  String username;
  final String token;

  Student({
    required this.username,
    required this.token
  });


  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      username: json['username'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'token': token,
    };
  }
}