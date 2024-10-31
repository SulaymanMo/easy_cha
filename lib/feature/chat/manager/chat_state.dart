part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {
  final List<ChatMsgModel> model;
  ChatSuccess(this.model);
}

final class ChatFailure extends ChatState {
  final String error;
  ChatFailure(this.error);
}

final class ChatLoading extends ChatState {}
