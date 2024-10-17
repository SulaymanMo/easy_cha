class TypingStatusModel {
  final int sender, receiver;
  const TypingStatusModel({required this.sender, required this.receiver});

  Map<String, dynamic> toJson() {
    return {
      "sender": sender,
      "receiver": receiver,
    };
  }
}
