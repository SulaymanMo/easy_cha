part of 'typing_cubit.dart';

sealed class TypingMsgState {}

final class TypingInitial extends TypingMsgState {}

final class ReceiverTypingMsg extends TypingMsgState {
  final String senderId;
  final bool isSenderTyping;
  ReceiverTypingMsg(this.isSenderTyping, this.senderId);
}
