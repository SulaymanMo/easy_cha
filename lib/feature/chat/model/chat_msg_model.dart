import 'package:flutter/foundation.dart';
import 'package:easy_cha/core/constant/const_string.dart';

class ChatMsgModel {
  int? id;
  String? text;
  dynamic image;
  dynamic file;
  String? type;
  dynamic sender;
  dynamic receiver;
  String? seenAt;
  String? createdAt;

  ChatMsgModel({
    this.id,
    this.text,
    this.image,
    this.file,
    this.type,
    this.sender,
    this.receiver,
    this.seenAt,
    this.createdAt,
  });

  factory ChatMsgModel.fromJson(Map<String, dynamic> json) {
    return ChatMsgModel(
      id: json['id'] as int?,
      text: json["text"],
      type: json["type"] as String?,
      sender: json['sender'] as int?,
      receiver: json['receiver'] as int?,
      seenAt: json['seen_at'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  factory ChatMsgModel.newMsg(Map<String, dynamic> json) {
    return ChatMsgModel(
      id: json['messageID'] as int?,
      text: json["text"],
      type: ConstString.textType,
      sender: json['sender'] as String?,
      receiver: json['receiver'] as String?,
      seenAt: "${DateTime.now().millisecondsSinceEpoch}",
    );
  }

  factory ChatMsgModel.file(
    Map<String, dynamic> json, {
    required dynamic fileName,
  }) {
    return ChatMsgModel(
      type: json["type"] as String?,
      id: json["messageID"] as int?,
      text: "${ConstString.path}${json["type"]}/$fileName",
      seenAt: "${DateTime.now().millisecondsSinceEpoch}",
      sender: json["sender"] as int?,
      receiver: json["receiver"] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'image': image,
        'file': file,
        'type': type,
        'sender': sender,
        'receiver': receiver,
        'seen_at': seenAt,
        'created_at': createdAt,
      };

  @override
  String toString() {
    debugPrint('''
    OVERRIDE toString for CHAT MSG MODEL:
    id: $id 
    text: $text 
    image: $image 
    file: $file 
    type: $type 
    sender: $sender 
    receiver: $receiver 
    seenAt: $seenAt 
    createdAt: $createdAt
    ''');
    return super.toString();
  }
}
