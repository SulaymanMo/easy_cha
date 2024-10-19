import 'home_user_data_model.dart';

class HomeModel {
  final bool? status;
  final HomeUserDataModel? data;

  const HomeModel({this.status, this.data});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json['status'] as bool?,
        data: json['data'] == null
            ? null
            : HomeUserDataModel.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
      };
}
