class ReceiveMsgModel {
  final String msg;
  final int sender, receiver, msgid;

  const ReceiveMsgModel({
    required this.msg,
    required this.sender,
    required this.receiver,
    required this.msgid,
  });

  factory ReceiveMsgModel.fromJson(Map<String, dynamic> json) {
    return ReceiveMsgModel(
      msg: json["text"],
      sender: json["sender"],
      receiver: json["receiver"],
      msgid: json["messageID"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": msg,
      "messageID": msgid,
      "sender": sender,
      "receiver": receiver,
    };
  }
}
