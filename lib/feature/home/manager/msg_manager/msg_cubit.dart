import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/socket_model/home_msg_model.dart';
import '../../../../core/constant/const_string.dart';
import 'package:easy_cha/feature/home/manager/socket_manager/socket_cubit.dart';

part 'msg_state.dart';

class MsgCubit extends Cubit<MsgState> {
  final SocketCubit _socketCubit;
  MsgCubit(this._socketCubit) : super(MsgInitial());

  // ! Receive msg from users
  void receiveMsg() {
    _socketCubit.socket.on(SocketEvent.msg.event, (data) {
      emit(NewMsg(HomeMsgModel.fromJson(data)));
      // ! here add to chat msgs
    });
    emit(MsgInitial());
  }

  // ! Send msg to user (used in chat)
  void sendMsg(int receiver, String msg) {
    _socketCubit.socket.emit(
      SocketEvent.msg.event,
      jsonEncode(
        HomeMsgModel(
          sender: _socketCubit.user.id,
          receiver: receiver,
          msg: msg,
        ).toJson(),
      ),
    );
    emit(NewMsg(HomeMsgModel(
      sender: _socketCubit.user.id,
      receiver: receiver,
      msg: msg,
    )));
  }
}
