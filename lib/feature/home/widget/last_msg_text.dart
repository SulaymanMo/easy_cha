import 'package:easy_cha/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/msg_manager/msg_cubit.dart';
import '../manager/typing_msg_manager/typing_cubit.dart';
import '../model/home_model/home_user_model.dart';

class LastMsgText extends StatelessWidget {
  final HomeUserModel user;
  const LastMsgText({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MsgCubit, MsgState>(
      listener: (_, state) {
        if (state is NewMsgState && int.parse(state.model.sender) == user.id) {
          user.text = state.model.text;
        }
      },
      builder: (_, msgState) {
        return BlocBuilder<TypingMsgCubit, TypingMsgState>(
          builder: (_, state) {
            return Text(
              user.text == null
                  ? "Let's chat with ${user.name}"
                  : state is ReceiverTypingMsg &&
                          state.sender == user.id &&
                          state.isSenderTyping
                      ? "typing..."
                      : "${user.text}",
              maxLines: 1,
              style: context.regular14,
              overflow: TextOverflow.ellipsis,
            );
          },
        );
      },
    );
  }
}
