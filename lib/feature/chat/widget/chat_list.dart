import 'package:easy_cha/feature/chat/manager/chat_manager/chat_cubit.dart';
import 'package:easy_cha/feature/home/manager/msg_manager/msg_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../home/model/home_model/home_user_model.dart';
import 'chat_msg.dart';

class ChatList extends StatefulWidget {
  final HomeUserModel user;
  const ChatList({super.key, required this.user});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late final ScrollController _controller;

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _scrollDown();
    // context.read<MsgCubit>().receiveMsg();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChatCubit read = context.read<ChatCubit>();
    return BlocConsumer<MsgCubit, MsgState>(
      listener: (_, state) {
        if (state is NewMsgState) {
          read.msgs.add(state.model);
          _scrollDown();
        }
      },
      builder: (_, state) {
        return ListView.separated(
          controller: _controller,
          itemCount: context.read<ChatCubit>().msgs.length,
          padding: EdgeInsets.only(
            top: 2.h,
            left: 6.w,
            right: 6.w,
            bottom: 12.h,
          ),
          itemBuilder: (_, index) {
            return ChatMsg(
              msg: context.read<ChatCubit>().msgs[index],
              isMe: widget.user.id == read.msgs[index].receiver,
            );
          },
          separatorBuilder: (_, index) => SizedBox(height: 1.5.h),
        );
      },
    );
  }
}
