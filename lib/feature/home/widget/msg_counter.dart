import 'package:easy_cha/feature/home/manager/home_manager/home_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../manager/msg_manager/msg_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/home_model/home_user_model.dart';
import 'package:easy_cha/core/constant/extension.dart';

class MsgCounter extends StatefulWidget {
  final int index;
  final HomeUserModel user;
  const MsgCounter({super.key, required this.user, required this.index});

  @override
  State<MsgCounter> createState() => _MsgCounterState();
}

class _MsgCounterState extends State<MsgCounter> {
  @override
  void deactivate() {
    print("object");
    super.deactivate();
  }

  @override
  void dispose() {
    print("object");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int counter =
        context.read<HomeCubit>().counters[widget.index][widget.user.id]!;
    return BlocBuilder<MsgCubit, MsgState>(
      builder: (_, state) {
        if (state is NewMsgState) {
          if (state.model.sender == widget.user.id) {
            return CircleAvatar(
              radius: 3.w,
              child: Text(
                "${++counter}",
                style: context.regular14?.copyWith(color: Colors.white),
              ),
            );
          } else if (counter > 0) {
            return CircleAvatar(
              radius: 3.w,
              child: Text(
                "$counter",
                style: context.regular14?.copyWith(color: Colors.white),
              ),
            );
          }
          // context.read<HomeCubit>().counters[index][user.id] = 0;
          // counter = 0;
          return const SizedBox.shrink();
        } else if (counter > 0) {
          return CircleAvatar(
            radius: 3.w,
            child: Text(
              "$counter",
              style: context.regular14?.copyWith(color: Colors.white),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
