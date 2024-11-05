import 'package:easy_cha/core/common/failure_widget.dart';
import 'package:easy_cha/feature/chat/manager/chat_manager/chat_cubit.dart';
import 'package:easy_cha/feature/home/manager/msg_manager/msg_cubit.dart';
import 'package:easy_cha/feature/home/model/home_model/home_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../home/manager/socket_manager/socket_cubit.dart';
import '../widget/chat_appbar_title.dart';
import '../widget/chat_input.dart';
import '../widget/chat_list.dart';
import 'package:flutter/material.dart';
import '../widget/empty_chat.dart';

class ChatView extends StatefulWidget {
  final int index;
  final HomeUserModel user;
  const ChatView({super.key, required this.user, required this.index});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
    final msgState = context.read<MsgCubit>().state;
    context.read<SocketCubit>().userConnection();
    context.read<ChatCubit>().getMsgs(widget.user.id);
    if (msgState is NewMsgState && msgState.model.sender == widget.user.id) {
      context.read<MsgCubit>().seenMsg(receiver: widget.user.id, index: 2);
      debugPrint("${widget.user.id} || ${msgState.model.sender}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // final bool isOnline =
    //     widget.user.isOnline != null && widget.user.isOnline == "1";
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 0,
        // toolbarHeight: 10.h,
        title: ChatAppBarTitle(user: widget.user),
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.video),
          ),
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.call),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.w),
            bottomRight: Radius.circular(8.w),
          ),
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            builder: (_, state) {
              if (state is ChatSuccess) {
                return state.model.isEmpty
                    ? EmptyChat(name: widget.user.name)
                    : ChatList(user: widget.user);
              } else if (state is ChatFailure) {
                return FailureWidget(state.error);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ChatInput(user: widget.user),
          ),
        ],
      ),
    );
  }
}
