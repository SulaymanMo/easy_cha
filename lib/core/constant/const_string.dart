class Routes {
  static const String login = "/";
  static const String home = "/home";
  static const String chat = "/chat";
}

class ConstString {
  // ! _____ Api _____ ! //
  static const String baseUrl = "http://192.168.1.5:3000";
  static const String bearerToken =
      "4c308d676218643db75a309077b054878b82f6daa5065e8b5e133e82f251254f";
  static const String login = "api/login"; // in header
  static const String home = "api/home"; // in header
  static const String chat = "api/chat?id="; // as a query
  // ? _____
  // static const String path = "https://uss-eg.site/storage/chats/";
  static const String path = "http://192.168.1.5:3000/storage/chats/";
  static const String textType = "text";
  static const String fileType = "files";
  static const String imageType = "images";
  // ? _____
  // ! _____ Hive _____ ! //
  static const String userBox = "user_box";
  static const String userKey = "user_key";
}

enum SocketEvent {
  // ! Handle Listeners for me
  connect("connect"),
  disconnect("disconnect"),
  timeout("connect_timeout"),
  connectError("connect_error"),
  error("error"),
  closeConnection("close_connection"),

  // ! User Events
  newConnection("new_connection"), // ? check users connection
  seenMsg("seen_message"), // ? seen msg
  msg("new_text_message"), // ? send or receive msg
  file("new_file_message"), // ? send or receive file
  filesUploaded("files_uploaded"),
  startTyping("start_typing"),
  stopTyping("stop_typing");

  final String event;
  const SocketEvent(this.event);
}
