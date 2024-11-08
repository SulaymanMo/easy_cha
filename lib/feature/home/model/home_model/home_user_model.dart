class HomeUserModel {
  final int id;
  final String email;
  final String name;
  final String image;
  final String? isOnline;
  String? text;
  final int? receiver;
  int? unreadCount;

  HomeUserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.image,
    this.isOnline,
    this.text,
    this.receiver,
    this.unreadCount,
  });

  factory HomeUserModel.fromJson(
    Map<String, dynamic> json,
    String? imgPath,
  ) =>
      HomeUserModel(
        id: json['id'] as int,
        email: json['email'] as String,
        name: json['name'] as String,
        image: imgPath != null ? "$imgPath${json['image']}" : "",
        isOnline: json['is_online'] as String?,
        text: json['text'] as String?,
        receiver: json['receiver'] as int?,
        unreadCount: json['unread_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'image': image,
        'is_online': isOnline,
        'text': text,
        'receiver': receiver,
        'unread_count': unreadCount,
      };
}
