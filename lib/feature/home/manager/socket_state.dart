part of 'socket_cubit.dart';

sealed class SocketState {}

class SocketInitial extends SocketState {}

class SocketLoading extends SocketState {}

class SocketSuccess extends SocketState {}

class SocketFailure extends SocketState {}
