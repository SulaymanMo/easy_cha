class CurrentUserModel {
  int? id;
  String? name;
  String? email;
  String? image;
  String? isOnline;

  CurrentUserModel({this.id, this.name, this.email, this.image, this.isOnline});

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) => CurrentUserModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        image: json['image'] as String?,
        isOnline: json['is_online'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'image': image,
        'is_online': isOnline,
      };
}
