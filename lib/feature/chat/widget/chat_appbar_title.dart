import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_cha/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../home/manager/socket_manager/socket_cubit.dart';
import '../../home/model/home_model/home_user_model.dart';

class ChatAppBarTitle extends StatelessWidget {
  final HomeUserModel user;
  const ChatAppBarTitle({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name, style: context.semi16),
      subtitle: BlocBuilder<SocketCubit, SocketState>(
        builder: (_, state) {
          return Text(
            state is UserConnected && state.isConnected ? "Online" : "Offline",
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
          InkWell(
            onTap: () {
              //   context.nav.pushNamedAndRemoveUntil(
              //   Routes.home,
              //   (_) => false,
              // );
              context.nav.pop();
            },
            borderRadius: BorderRadius.circular(50),
            child: Padding(
              padding: EdgeInsets.all(0.5.w),
              child: const Icon(Iconsax.arrow_left_2),
            ),
          ),
          SizedBox(width: 2.w),
          CircleAvatar(
            radius: 7.w,
            backgroundImage: CachedNetworkImageProvider(user.image),
          ),
        ],
      ),
    );
  }
}
