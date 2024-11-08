class SendMsgModel {
  final int? msgid;
  final String msg;
  final int sender, receiver;

  const SendMsgModel({
    this.msgid,
    required this.msg,
    required this.sender,
    required this.receiver,
  });

  factory SendMsgModel.fromJson(Map<String, dynamic> json) {
    return SendMsgModel(
      msgid: json["messageID"],
      msg: json["text"],
      sender: int.parse(json["sender"]),
      receiver: int.parse(json["receiver"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // "messageID": msgid,
      "text": msg,
      "sender": sender,
      "receiver": receiver,
    };
  }
}
