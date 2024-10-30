import 'dart:async';
import 'dart:convert';
import 'package:easy_cha/core/constant/const_string.dart';
import 'package:easy_cha/feature/auth/manager/auth_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../auth/model/user_model.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  late final Socket socket;
  late final UserModel user;
  SocketCubit(AuthCubit cubit) : super(SocketInitial()) {
    user = cubit.user!;
    _initSocket();
  }

  // ! Seen Sender msg (used in chat, receiver is me & sender is other)
  void seenMsg(int receiver) {
    socket.emit(
      SocketEvent.seenMsg.event,
      jsonEncode({"sender": receiver, "receiver": user.id}),
    );
  }

  // ! Check reciever connection (used in chat)
  void userConnection() {
    socket.on(SocketEvent.newConnection.event, (data) {
      emit(UserConnected(true));
    });
    socket.on(SocketEvent.closeConnection.event, (data) {
      emit(UserConnected(false));
    });
  }

  void _initSocket() {
    try {
      socket = io(
        ConstString.baseUrl,
        <String, dynamic>{
          "transports": ["websocket", "polling"],
          "query": {
            "userid": user.id,
            "token": user.token,
            "event": "chat",
          },
          "autoConnect": true,
          "reconnection": true,
        },
      );
      _socketListeners();
    } catch (e) {
      debugPrint("Eror ====================================");
    }
  }

  // ! Handle user listeners (for me)
  void _socketListeners() async {
    socket.on(
      SocketEvent.connect.event,
      (data) => debugPrint("Connected"),
    );
    socket.on(
      SocketEvent.disconnect.event,
      (data) => debugPrint("Disconnected"),
    );
    socket.on(
      SocketEvent.timeout.event,
      (timeout) => debugPrint("Connection Timeout: $timeout"),
    );
    socket.on(
      SocketEvent.connectError.event,
      (error) => debugPrint("Connection Error: $error"),
    );
    socket.on(
      SocketEvent.error.event,
      (error) => debugPrint("Socket error: $error"),
    );
  }

  @override
  Future<void> close() {
    // _timer?.cancel();
    socket.dispose();
    return super.close();
  }
}
