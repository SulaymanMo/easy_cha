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

  factory ChatMsgModel.fromJson(Map<String, dynamic> json) => ChatMsgModel(
        id: json['id'] as int?,
        text: json['text'] as String?,
        image: json['image'] as dynamic,
        file: json['file'] as dynamic,
        type: json['type'] as String?,
        sender: json['sender'] as int?,
        receiver: json['receiver'] as int?,
        seenAt: json['seen_at'] as String?,
        createdAt: json['created_at'] as String?,
      );

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
}
