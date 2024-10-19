import 'dart:async';
import 'dart:convert';
import 'package:easy_cha/core/constant/const_string.dart';
import 'package:easy_cha/feature/auth/manager/auth_cubit.dart';
import 'package:easy_cha/feature/home/model/socket_model/receive_msg_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../auth/model/user_model.dart';
import '../../model/socket_model/typing_status_model.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  static Timer? _timer;
  static late final Socket _socket;
  static late final UserModel _user;
  SocketCubit(AuthCubit cubit) : super(SocketInitial()) {
    _user = cubit.user;
    _initSocket();
  }

  // ! Check sender if typing or not
  void senderTyping(int receiver) {
    _socket.emit(
      SocketEvent.startTyping.event,
      TypingStatusModel(sender: _user.id, receiver: receiver).toJson(),
    );
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 1700),
      () => _socket.emit(
        SocketEvent.stopTyping.event,
        TypingStatusModel(sender: _user.id, receiver: receiver).toJson(),
      ),
    );
  }

  // ! Check receiver if typing or not
  void isReceiverTyping() {
    _socket.on(
      SocketEvent.startTyping.event,
      (data) {
        emit(ReceiverTyping(true, data["sender"]));
      },
    );
    _socket.on(
      SocketEvent.stopTyping.event,
      (data) {
        emit(ReceiverTyping(false, data["sender"]));
      },
    );
  }

  static void _initSocket() {
    try {
      _socket = io(
        ConstString.baseUrl,
        <String, dynamic>{
          "transports": ["websocket", "polling"],
          "query": {
            "userid": _user.id,
            "token": _user.token,
            "event": "chat",
          },
          "autoConnect": true,
          "reconnection": true,
        },
      );
      _socketListeners();
    } catch (e) {
      print("Eror ====================================");
    }
  }

  static void _socketListeners() async {
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

  void userConnection() {
    _socket.on(SocketEvent.newConnection.event, (data) {
      emit(UserConnected(true));
    });
    _socket.on(SocketEvent.closeConnection.event, (data) {
      emit(UserConnected(false));
    });
  }

  void sendMsg(int receiver, String msg) {
    _socket.emit(
      SocketEvent.msg.event,
      json.encode({"sender": _user.id, "receiver": receiver, "text": msg}),
    );
  }

  void receiveMsg() {
    _socket.on(SocketEvent.msg.event, (data) {
      emit(ReceivedMsg(data));
    });
  }

  @override
  Future<void> close() {
    _socket.dispose();
    _timer?.cancel();
    // _socket.dispose();
    return super.close();
  }
}
