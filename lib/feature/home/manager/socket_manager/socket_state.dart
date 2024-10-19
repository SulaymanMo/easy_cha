part of 'socket_cubit.dart';

sealed class SocketState {}

class SocketInitial extends SocketState {}

class SocketLoading extends SocketState {}

class SocketSuccess extends SocketState {}

class SocketFailure extends SocketState {}

class ReceiverTyping extends SocketState {
  final String receiverId;
  final bool isReceiverTyping;
  ReceiverTyping(this.isReceiverTyping, this.receiverId);
}

class UserConnected extends SocketState {
  final bool isConnected;
  UserConnected(this.isConnected);
}
