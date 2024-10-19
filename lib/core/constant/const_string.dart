class Routes {
  static const String login = "/";
  static const String home = "/home";
  static const String chat = "/chat";
}

class ConstString {
  // ! _____ Api _____ ! //
  static const String baseUrl = "https://uss-eg.site";
  static const String bearerToken =
      "4c308d676218643db75a309077b054878b82f6daa5065e8b5e133e82f251254f";
  static const String login = "api/login";
  static const String home = "api/home";
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
  msg("new_text_message"), // ? send or receive msg
  startTyping("start_typing"),
  stopTyping("stop_typing");

  final String event;
  const SocketEvent(this.event);
}
