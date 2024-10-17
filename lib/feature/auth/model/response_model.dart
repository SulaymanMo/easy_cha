import 'user_model.dart';

class ResponseModel {
  final bool status;
  final String? message;
  final UserModel? data;

  const ResponseModel({required this.status, this.message, this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json["status"],
      message: json["message"] ?? "",
      data: UserModel.fromJson(json["data"] ?? {}),
    );
  }
}
