import 'dart:convert';
import 'package:easy_cha/feature/home/manager/home_manager/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/socket_model/home_msg_model.dart';
import '../../../../core/constant/const_string.dart';
import 'package:easy_cha/feature/home/manager/socket_manager/socket_cubit.dart';

part 'msg_state.dart';

class MsgCubit extends Cubit<MsgState> {
  final HomeCubit _homeCubit;
  final SocketCubit _socketCubit;
  MsgCubit(this._socketCubit, this._homeCubit) : super(MsgInitial());

  // ! Receive msg from users (used in home & chat view)
  void receiveMsg() {
    _socketCubit.socket.on(SocketEvent.msg.event, (data) {
      emit(NewMsgState(HomeMsgModel.fromJson(data)));
    });
  }

  // ! Send msg to user (used in chat)
  void sendMsg(int receiver, String msg) {
    final HomeMsgModel homeMsg = HomeMsgModel(
      sender: _socketCubit.user.id,
      receiver: receiver,
      msg: msg,
    );
    _socketCubit.socket.emit(
      SocketEvent.msg.event,
      jsonEncode(homeMsg.toJson()),
    );
    emit(NewMsgState(homeMsg));
  }

  // ! Seen Sender msg (used in ChatView, receiver is me & sender is other)
  void seenMsg({required int receiver, required int index}) {
    _socketCubit.socket.emit(
      SocketEvent.seenMsg.event,
      jsonEncode({"sender": _socketCubit.user.id, "receiver": receiver}),
    );
    // print(
        // "userid: ${_homeCubit.counters[index].keys.first} || user counter: ${_homeCubit.counters[index][_socketCubit.user.id]}");
    _homeCubit.counters[index][_socketCubit.user.id] = 0;
    // print("user counter: ${_homeCubit.counters[index][_socketCubit.user.id]}");
    // emit(MsgInitial());
  }
}
