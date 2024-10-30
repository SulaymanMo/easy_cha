import 'current_user_model.dart';
import 'chat_msg_model.dart';

class ChatDataModel {
  List<ChatMsgModel>? messages;
  CurrentUserModel? currentUser;

  ChatDataModel({this.currentUser, this.messages});

  factory ChatDataModel.fromJson(Map<String, dynamic> json) => ChatDataModel(
        currentUser: json['currentUser'] == null
            ? null
            : CurrentUserModel.fromJson(json['currentUser'] as Map<String, dynamic>),
        messages: (json['messages'] as List<dynamic>?)
            ?.map((e) => ChatMsgModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'currentUser': currentUser?.toJson(),
        'messages': messages?.map((e) => e.toJson()).toList(),
      };
}
