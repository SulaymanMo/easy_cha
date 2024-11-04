part of 'msg_cubit.dart';

sealed class MsgState {}

final class MsgInitial extends MsgState {}

final class NewMsgState extends MsgState {
  final HomeMsgModel model;
  NewMsgState(this.model);
}

