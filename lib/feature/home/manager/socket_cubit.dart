import 'dart:async';
import 'package:easy_cha/core/constant/const_string.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:easy_cha/feature/home/model/typing_status_model.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  Timer? _timer;
  static const int sender = 1000004;
  SocketCubit() : super(SocketInitial()) {
    _initListeners();
  }

  void isTyping(int receiver) {
    _socket.emit(
      SocketEvent.startTyping.event,
      TypingStatusModel(sender: sender, receiver: receiver).toJson(),
    );
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 1700),
      () => _socket.emit(
        SocketEvent.endTyping.event,
        TypingStatusModel(sender: sender, receiver: receiver).toJson(),
      ),
    );
  }

  static final Socket _socket = io(
    "http://192.168.1.5:2000",
    <String, dynamic>{
      "transports": ["websocket", "polling"],
      "query": {
        "userid": 1000005,
        "token":
            "1622b5a356c1283cdc6bd5c086b3d2f4c420d0882c577b264526eb3ba86c391c",
        "event": "chat",
      },
      "autoConnect": true,
      "reconnection": true,
    },
  );

  static void _initListeners() {
    _socket.on(
      SocketEvent.connect.event,
      (data) => debugPrint("Connected"),
    );
    _socket.on(
      SocketEvent.disconnect.event,
      (data) => debugPrint("Disconnected"),
    );
    _socket.on(
      SocketEvent.timeout.event,
      (timeout) => debugPrint("Connection Timeout: $timeout"),
    );
    _socket.on(
      SocketEvent.connectError.event,
      (error) => debugPrint("Connection Error: $error"),
    );
    _socket.on(
      SocketEvent.error.event,
      (error) => debugPrint("Socket error: $error"),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _socket
      ..clearListeners()
      ..dispose();
    return super.close();
  }
}
