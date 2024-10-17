class LoginPostModel {
  final String email, password;
  const LoginPostModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {"username": email, "password": password};
  }
}
