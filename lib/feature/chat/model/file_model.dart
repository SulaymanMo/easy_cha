import 'dart:convert';

final class FileModel {
  final String type;
  final int sender, receiver;
  final List<Base64Encoder> files;

  const FileModel({
    required this.type,
    required this.sender,
    required this.receiver,
    required this.files,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      type: json["type"],
      files: json["files"],
      sender: json["sender"],
      receiver: json["receiver"],
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
