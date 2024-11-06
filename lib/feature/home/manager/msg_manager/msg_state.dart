part of 'msg_cubit.dart';

sealed class MsgState {}

final class MsgInitial extends MsgState {}

final class NewMsgState extends MsgState {
  final ChatMsgModel model;
  NewMsgState(this.model);
}

final class MsgFailure extends MsgState {
  final String error;
  MsgFailure(this.error);
}

final class FilesPickedState extends MsgState {
  final List<File> files;
  FilesPickedState(this.files);
}
