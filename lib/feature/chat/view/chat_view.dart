import 'package:easy_cha/core/common/failure_widget.dart';
import 'package:easy_cha/feature/chat/manager/chat_cubit.dart';
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
  final HomeUserModel user;
  const ChatView(this.user, {super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
    context.read<SocketCubit>()
      ..userConnection()
      ..seenMsg(widget.user.id);
    context.read<ChatCubit>().getMsgs(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    // final bool isOnline =
    //     widget.user.isOnline != null && widget.user.isOnline == "1";
    return Scaffold(
      extendBody: true,
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
          BlocConsumer<ChatCubit, ChatState>(
            listener: (_, ChatState state) {},
            builder: (_, state) {
              if (state is ChatSuccess) {
                return state.model.isEmpty
                    ? EmptyChat(name: widget.user.name)
                    : ChatList(
                        user: widget.user,
                        msgs: context.read<ChatCubit>().msgs,
                      );
              } else if (state is ChatFailure) {
                return FailureWidget(state.error);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Positioned(
            bottom: 2.h,
            left: 6.w,
            right: 6.w,
            child: ChatForm(user: widget.user),
          ),
        ],
      ),
    );
  }
}
