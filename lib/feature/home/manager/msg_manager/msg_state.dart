part of 'msg_cubit.dart';

sealed class MsgState {}

final class MsgInitial extends MsgState {}

class NewMsg extends MsgState {
  final HomeMsgModel model;
  NewMsg(this.model);
}
