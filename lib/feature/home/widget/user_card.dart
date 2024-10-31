import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_cha/core/helper/service_locator.dart';
import 'package:easy_cha/core/service/api_service.dart';
import 'package:easy_cha/feature/auth/manager/auth_cubit.dart';
import 'package:easy_cha/feature/chat/manager/chat_cubit.dart';
import 'package:easy_cha/feature/chat/view/chat_view.dart';
import 'package:easy_cha/feature/home/manager/msg_manager/msg_cubit.dart';
import 'package:easy_cha/feature/home/manager/typing_msg_manager/typing_cubit.dart';
import 'package:easy_cha/feature/home/model/home_model/home_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:easy_cha/core/constant/extension.dart';

class UserCard extends StatefulWidget {
  final HomeUserModel user;
  const UserCard({super.key, required this.user});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  int _counter = 0;
  String _msg = "";

  @override
  void initState() {
    super.initState();
    _counter = widget.user.unreadCount!;
    context.read<MsgCubit>().receiveMsg();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<TypingMsgCubit>.value(
                      value: context.read<TypingMsgCubit>(),
                    ),
                    BlocProvider<MsgCubit>.value(
                      value: context.read<MsgCubit>(),
                    ),
                    BlocProvider(
                      create: (_) => ChatCubit(
                        getIt.get<ApiService>(),
                        context.read<AuthCubit>(),
                      ),
                    ),
                  ],
                  child: ChatView(widget.user),
                );
              },
            ),
          );
        },
        leading: CircleAvatar(
          radius: 7.w,
          backgroundImage: CachedNetworkImageProvider(widget.user.image),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.semi16,
              ),
            ),
            SizedBox(width: 2.w),
            Text("12:40 PM", style: context.regular14),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: BlocBuilder<MsgCubit, MsgState>(
                builder: (_, msgState) {
                  return BlocBuilder<TypingMsgCubit, TypingMsgState>(
                    builder: (_, state) {
                      if (state is ReceiverTypingMsg &&
                          state.isSenderTyping &&
                          state.senderId == "${widget.user.id}") {
                        return Text("Typing...", style: context.regular14);
                      } else if (msgState is NewMsg) {
                        if (msgState.model.sender == widget.user.id) {
                          _msg = msgState.model.msg;
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
              ),
            ),
            SizedBox(width: 2.w),
            BlocBuilder<MsgCubit, MsgState>(
              builder: (_, state) {
                if (state is NewMsg) {
                  if (state.model.sender == widget.user.id) {
                    return CircleAvatar(
                      radius: 3.w,
                      child: Text(
                        "${++_counter}",
                        style: context.regular14?.copyWith(color: Colors.white),
                      ),
                    );
                  } else if (_counter > 0) {
                    return CircleAvatar(
                      radius: 3.w,
                      child: Text(
                        "$_counter",
                        style: context.regular14?.copyWith(color: Colors.white),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                } else if (_counter > 0) {
                  return CircleAvatar(
                    radius: 3.w,
                    child: Text(
                      "$_counter",
                      style: context.regular14?.copyWith(color: Colors.white),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
