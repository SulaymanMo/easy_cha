class LoginPostModel {
  final String email, password, deviceToken;
  const LoginPostModel({
    required this.email,
    required this.password,
    required this.deviceToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": email,
      "password": password,
      "device_token": deviceToken,
    };
  }
}
