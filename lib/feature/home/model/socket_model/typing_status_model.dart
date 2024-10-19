class TypingStatusModel {
  final int sender, receiver;

  const TypingStatusModel({
    required this.sender,
    required this.receiver,
  });

  factory TypingStatusModel.fromJson(Map<String, dynamic> json) {
    return TypingStatusModel(
      sender: json["sender"],
      receiver: json["receiver"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sender": sender,
      "receiver": receiver,
    };
  }
}
