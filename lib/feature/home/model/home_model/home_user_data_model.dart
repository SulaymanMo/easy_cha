import 'home_user_model.dart';

class HomeUserDataModel {
  final String? imagePath;
  final List<HomeUserModel>? users;

  const HomeUserDataModel({this.imagePath, this.users});

  factory HomeUserDataModel.fromJson(Map<String, dynamic> json) =>
      HomeUserDataModel(
        imagePath: json['image_path'] as String?,
        users: (json['users'] as List<dynamic>?)
            ?.map((user) => HomeUserModel.fromJson(user, json["image_path"]))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'image_path': imagePath,
        'users': users?.map((e) => e.toJson()).toList(),
      };
}
