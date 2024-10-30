import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_cha/core/constant/extension.dart';
import 'package:easy_cha/feature/home/manager/socket_manager/socket_cubit.dart';
import 'package:easy_cha/feature/home/model/home_model/home_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../widget/chat_input.dart';
import '../widget/chat_msg.dart';
import 'package:flutter/material.dart';

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
    // context.read<MsgCubit>().sendMsg(widget.user.id);
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
        toolbarHeight: 10.h,
        title: ListTile(
          title: Text(
            widget.user.name,
            style: context.semi16,
          ),
          subtitle: BlocBuilder<SocketCubit, SocketState>(
            builder: (_, state) {
              return Text(
                state is UserConnected && state.isConnected
                    ? "Online"
                    : "Offline",
                style: context.regular14?.copyWith(
                  color: state is UserConnected && state.isConnected
                      ? Colors.green.shade800
                      : Colors.red.shade800,
                ),
              );
            },
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  //   context.nav.pushNamedAndRemoveUntil(
                  //   Routes.home,
                  //   (_) => false,
                  // );
                  context.nav.pop();
                },
                child: const Icon(Iconsax.arrow_left_2),
              ),
              SizedBox(width: 2.w),
              CircleAvatar(
                radius: 7.w,
                backgroundImage: CachedNetworkImageProvider(widget.user.image),
              ),
            ],
          ),
        ),
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
        )),
      ),
      body: Stack(
        children: [
          ListView.separated(
            itemCount: 2,
            reverse: true,
            padding: EdgeInsets.only(
              left: 6.w,
              right: 6.w,
              top: 2.h,
              bottom: 12.h,
            ),
            itemBuilder: (_, index) => const ChatMsg(),
            separatorBuilder: (_, index) => SizedBox(height: 1.5.h),
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
