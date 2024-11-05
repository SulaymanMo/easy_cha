import 'package:easy_cha/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/msg_manager/msg_cubit.dart';
import '../manager/typing_msg_manager/typing_cubit.dart';
import '../model/home_model/home_user_model.dart';

class LastMsgText extends StatefulWidget {
  final HomeUserModel user;
  const LastMsgText({super.key, required this.user});

  @override
  State<LastMsgText> createState() => _LastMsgTextState();
}

class _LastMsgTextState extends State<LastMsgText> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MsgCubit, MsgState>(
      builder: (_, msgState) {
        return BlocBuilder<TypingMsgCubit, TypingMsgState>(
          builder: (_, state) {
            if (state is ReceiverTypingMsg &&
                state.isSenderTyping &&
                state.senderId == "${widget.user.id}") {
              return Text("Typing...", style: context.regular14);
            } else if (msgState is NewMsgState) {
              if (msgState.model.sender == widget.user.id) {
                _msg = msgState.model.text!;
                return Text(
                  _msg,
                  maxLines: 1,
                  style: context.regular14,
                  overflow: TextOverflow.ellipsis,
                );
              } else if (_msg.isNotEmpty) {
                return Text(
                  _msg,
                  maxLines: 1,
                  style: context.regular14,
                  overflow: TextOverflow.ellipsis,
                );
              } else if (widget.user.text != null) {
                return Text(
                  "${widget.user.text}",
                  maxLines: 1,
                  style: context.regular14,
                  overflow: TextOverflow.ellipsis,
                );
              }
              return Text(
                "Let's chat with ${widget.user.name}",
                maxLines: 1,
                style: context.regular14,
                overflow: TextOverflow.ellipsis,
              );
            } else if (widget.user.text != null) {
              return Text(
                "${widget.user.text}",
                maxLines: 1,
                style: context.regular14,
                overflow: TextOverflow.ellipsis,
              );
            } else {
              return Text(
                "Let's chat with ${widget.user.name}",
                maxLines: 1,
                style: context.regular14,
                overflow: TextOverflow.ellipsis,
              );
            }
          },
        );
      },
    );
  }
}
