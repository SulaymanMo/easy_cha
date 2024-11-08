import 'dart:async';
import '../socket_manager/socket_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/const_string.dart';
import '../../model/socket_model/typing_status_model.dart';

part 'typing_state.dart';

class TypingMsgCubit extends Cubit<TypingMsgState> {
  static Timer? _timer;
  final SocketCubit _cubit;
  TypingMsgCubit(this._cubit) : super(TypingInitial());

  // ! Check receiver typing (used in home & chat)
  void isReceiverTyping() {
    _cubit.socket.on(
      SocketEvent.startTyping.event,
      (data) {
        emit(ReceiverTypingMsg(true, int.parse(data["sender"])));
      },
    );
    _cubit.socket.on(
      SocketEvent.stopTyping.event,
      (data) {
        emit(ReceiverTypingMsg(false, int.parse(data["sender"])));
      },
    );
  }

  // ! Check sender typing (used in chat)
  void isSenderTyping(int receiver) {
    _cubit.socket.emit(
      SocketEvent.startTyping.event,
      TypingStatusModel(sender: _cubit.user.id, receiver: receiver).toJson(),
    );
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 1700),
      () => _cubit.socket.emit(
        SocketEvent.stopTyping.event,
        TypingStatusModel(sender: _cubit.user.id, receiver: receiver).toJson(),
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
