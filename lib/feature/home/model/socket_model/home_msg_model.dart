class HomeMsgModel {
  final int? msgid;
  final String msg;
  final int sender, receiver;

  const HomeMsgModel({
    this.msgid,
    required this.msg,
    required this.sender,
    required this.receiver,
  });

  factory HomeMsgModel.fromJson(Map<String, dynamic> json) {
    return HomeMsgModel(
      msgid: json["messageID"],
      msg: json["text"],
      sender: int.parse(json["sender"]),
      receiver: int.parse(json["receiver"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "messageID": msgid,
      "text": msg,
      "sender": sender,
      "receiver": receiver,
    };
  }
}
