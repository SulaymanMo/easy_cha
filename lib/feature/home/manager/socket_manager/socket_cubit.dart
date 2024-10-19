import 'dart:async';
import 'dart:convert';
import 'package:easy_cha/core/constant/const_string.dart';
import 'package:easy_cha/feature/home/manager/home_manager/home_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../auth/model/user_model.dart';
import '../../model/typing_status_model.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  Timer? _timer;
  static UserModel? _user;
  late final StreamSubscription _subscription;
  SocketCubit(HomeCubit cubit) : super(SocketInitial()) {
    _subscription = cubit.stream.listen((HomeState state) {
      if (state is HomeSuccess) {
        _user = cubit.user;
        _initListeners();
        _subscription.cancel();
      }
    });
  }

  // ! Check sender if typing or not
  void senderTyping(int receiver) {
    _socket.emit(
      SocketEvent.startTyping.event,
      TypingStatusModel(sender: _user!.id, receiver: receiver).toJson(),
    );
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 1700),
      () => _socket.emit(
        SocketEvent.stopTyping.event,
        TypingStatusModel(sender: _user!.id, receiver: receiver).toJson(),
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

  static Socket get _socket => io(
        ConstString.baseUrl,
        // <String, dynamic>{
        //   "transports": ["websocket", "polling"],
        //   "query": {
        //     "userid": _user!.id,
        //     "token": _user!.token,
        //     "event": "chat",
        //   },
        //   "autoConnect": true,
        //   "reconnection": true,
        // },
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

  void userConnection() {
    _socket.on(SocketEvent.newConnection.event, (data) {
      emit(Connected(true));
    });
    _socket.on(SocketEvent.closeConnection.event, (data) {
      emit(Connected(false));
    });
  }

  void sendMsg(int receiver, String msg) {
    _socket.emit(
      "new_text_message",
      json.encode({
        "sender": _user!.id,
        "receiver": receiver,
        "text": msg,
      }),
    );
  }

  void receiveMsg() {
    _socket.on("new_text_message", (data) {});
  }

  // void _getLocalUser() {
  //   final data = _box.get(ConstString.userKey, defaultValue: {});
  //   final Map<String, dynamic> user = Map.from(data);
  //   _user = UserModel.fromJson(user);
  // }

  @override
  Future<void> close() {
    _subscription.cancel();
    _timer?.cancel();
    _socket
      ..clearListeners()
      ..dispose();
    return super.close();
  }
}
