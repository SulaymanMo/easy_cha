import 'chat_data_model.dart';

class ChatModel {
  bool? status;
  ChatDataModel? data;

  ChatModel({this.status, this.data});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        status: json['status'] as bool?,
        data: json['data'] == null
            ? null
            : ChatDataModel.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
      };
}
