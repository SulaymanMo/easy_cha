final class SendFileModel {
  final String type;
  final List files;
  final int sender, receiver;

  const SendFileModel({
    required this.type,
    required this.sender,
    required this.receiver,
    required this.files,
  });

  factory SendFileModel.fromJson(Map<String, dynamic> json) {
    return SendFileModel(
      type: json["type"] as String,
      files: json["files"],
      sender: int.parse(json["sender"] as String),
      receiver: int.parse(json["receiver"] as String),
    );
  }

  Map<String, dynamic> toJosn() {
    return {
      "type": type,
      "files": files,
      "sender": sender,
      "receiver": receiver,
    };
  }
}
