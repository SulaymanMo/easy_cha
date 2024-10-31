import 'package:easy_cha/feature/home/manager/msg_manager/msg_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../home/model/home_model/home_user_model.dart';
import '../model/chat_msg_model.dart';
import 'chat_msg.dart';

class ChatList extends StatefulWidget {
  const ChatList({
    super.key,
    required this.user,
    required this.msgs,
  });

  final HomeUserModel user;
  final List<ChatMsgModel> msgs;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late final ScrollController _controller;

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _scrollDown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MsgCubit, MsgState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _controller,
          itemCount: widget.msgs.length,
          padding: EdgeInsets.only(
            top: 2.h,
            left: 6.w,
            right: 6.w,
            bottom: 12.h,
          ),
          itemBuilder: (_, index) => ChatMsg(
            msg: widget.msgs[index],
            isMe: widget.user.id == widget.msgs[index].receiver,
          ),
          separatorBuilder: (_, index) => SizedBox(height: 1.5.h),
        );
      },
    );
  }
}

// ! access on list of msgs