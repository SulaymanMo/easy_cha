import 'package:easy_cha/feature/home/manager/socket_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import '../../../core/common/input.dart';
import '../../../core/constant/const_color.dart';

class ChatForm extends StatefulWidget {
  final int receiver;
  const ChatForm({super.key, required this.receiver});

  @override
  State<ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Input(
        onChanged: (val) {
          if (val != null && val != "") {
            context.read<SocketCubit>().isTyping(widget.receiver);
          }
        },
        hint: "Type here...",
        controller: _controller,
        fillColor: ConstColor.secondary.color,
        suffix: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              VerticalDivider(
                indent: 1.h,
                endIndent: 1.h,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.sticker,
                  color: ConstColor.text.color,
                ),
              ),
              // SizedBox(width: 0.5.w),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.camera,
                  color: ConstColor.text.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
