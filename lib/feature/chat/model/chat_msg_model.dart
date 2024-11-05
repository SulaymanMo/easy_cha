import 'package:easy_cha/core/constant/const_string.dart';
import 'package:flutter/foundation.dart';

class ChatMsgModel {
  int? id;
  String? text;
  dynamic image;
  dynamic file;
  String? type;
  int? sender;
  int? receiver;
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
    String? type = json["type"];
    return ChatMsgModel(
      id: json['id'] as int?,
      text: type != "text"
          ? "${ConstString.path}$type/${json['text'] as String?}"
          : json["text"] as String?,
      image: "${ConstString.path}images/${json['image'] as dynamic}",
      file: json['file'] as dynamic,
      type: type,
      sender: json['sender'],
      receiver: json['receiver'],
      seenAt: json['seen_at'] as String?,
      createdAt: json['created_at'] as String?,
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
