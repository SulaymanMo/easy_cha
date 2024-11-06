import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_cha/core/helper/service_locator.dart';
import 'package:easy_cha/core/service/api_service.dart';
import 'package:easy_cha/feature/auth/manager/auth_cubit.dart';
import 'package:easy_cha/feature/chat/manager/chat_manager/chat_cubit.dart';
import 'package:easy_cha/feature/chat/view/chat_view.dart';
import 'package:easy_cha/feature/home/manager/msg_manager/msg_cubit.dart';
import 'package:easy_cha/feature/home/manager/typing_msg_manager/typing_cubit.dart';
import 'package:easy_cha/feature/home/model/home_model/home_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:easy_cha/core/constant/extension.dart';
import 'last_msg_text.dart';
import 'msg_counter.dart';

class UserCard extends StatefulWidget {
  final int index;
  final HomeUserModel user;
  const UserCard({super.key, required this.user, required this.index});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => _navToUserChat(context),
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
              child: LastMsgText(user: widget.user),
            ),
            SizedBox(width: 2.w),
            MsgCounter(user: widget.user, index: widget.index),
          ],
        ),
      ),
    );
  }

  void _navToUserChat(BuildContext context) {
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
              BlocProvider<ChatCubit>(
                create: (_) => ChatCubit(
                  getIt.get<ApiService>(),
                  context.read<AuthCubit>(),
                ),
              ),
              // BlocProvider<FileCubit>.value(
              //   value: context.read<FileCubit>(),
              // ),
            ],
            child: ChatView(user: widget.user, index: widget.index),
          );
        },
      ),
    );
  }
}
