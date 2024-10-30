part of 'msg_cubit.dart';

sealed class MsgState {}

final class MsgInitial extends MsgState {}

class ReceivedMsg extends MsgState {
  final HomeMsgModel model;
  ReceivedMsg(this.model);
}
