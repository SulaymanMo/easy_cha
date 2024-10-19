import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_cha/feature/chat/view/chat_view.dart';
import 'package:easy_cha/feature/home/model/home_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:easy_cha/core/constant/extension.dart';
import '../manager/socket_manager/socket_cubit.dart';

class UserCard extends StatelessWidget {
  final HomeUserModel user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final socketState = context.read<SocketCubit>().state;
    return Card(
      child: ListTile(
        onTap: () {
          // context.nav.pushNamed(Routes.chat, arguments: user);
          context.nav.push(
            MaterialPageRoute(
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<SocketCubit>(),
                  child: ChatView(user),
                );
              },
            ),
          );
        },
        leading: CircleAvatar(
          radius: 7.w,
          backgroundImage: CachedNetworkImageProvider(user.image),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                user.name,
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
              child: Text(
                socketState is ReceiverTyping &&
                        socketState.isReceiverTyping &&
                        socketState.receiverId == "${user.id}"
                    ? "Typing..."
                    : user.text ?? "Let's chat with ${user.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.regular14,
              ),
            ),
            SizedBox(width: 2.w),
            user.unreadCount != null && user.unreadCount != 0
                ? CircleAvatar(
                    radius: 3.w,
                    child: Text(
                      "${user.unreadCount}",
                      style: context.regular14?.copyWith(color: Colors.white),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
