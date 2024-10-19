class UserModel {
  final int id;
  final String email, image, token;

  const UserModel({
    required this.id,
    required this.email,
    required this.image,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json["email"],
      image: json["image"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "image": image,
      "token": token,
    };
  }
}
