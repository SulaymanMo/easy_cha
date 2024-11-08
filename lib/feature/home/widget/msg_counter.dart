import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../manager/msg_manager/msg_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/home_model/home_user_model.dart';
import 'package:easy_cha/core/constant/extension.dart';

class MsgCounter extends StatelessWidget {
  final int index;
  final HomeUserModel user;
  const MsgCounter({super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MsgCubit, MsgState>(
      listener: (_, state) {
        if (state is NewMsgState) {
          if (int.parse(state.model.sender) == user.id) {
            user.unreadCount = user.unreadCount! + 1;
          } 
            // print("======================");
        }
      },
      builder: (_, state) {
        return user.unreadCount! > 0
            ? CircleAvatar(
                radius: 3.w,
                child: Text(
                  "${user.unreadCount}",
                  style: context.regular14?.copyWith(color: Colors.white),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
