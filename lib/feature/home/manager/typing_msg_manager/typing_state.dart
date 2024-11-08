part of 'typing_cubit.dart';

sealed class TypingMsgState {}

final class TypingInitial extends TypingMsgState {}

final class ReceiverTypingMsg extends TypingMsgState {
  final int sender;
  final bool isSenderTyping;
  ReceiverTypingMsg(this.isSenderTyping, this.sender);
}
