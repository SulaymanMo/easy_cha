import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:easy_cha/core/constant/extension.dart';
import 'package:easy_cha/core/constant/const_color.dart';

import '../model/chat_msg_model.dart';

class ChatMsg extends StatelessWidget {
  final bool isMe;
  final ChatMsgModel msg;
  const ChatMsg({required this.isMe, required this.msg, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.75.h),
          decoration: BoxDecoration(
            color: isMe
                ? ConstColor.primary.color
                : context.theme.brightness == Brightness.dark
                    ? ConstColor.iconDark.color
                    : ConstColor.secondary.color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w),
              topRight: Radius.circular(10.w),
              bottomRight: isMe ? Radius.zero : Radius.circular(10.w),
              bottomLeft: isMe ? Radius.circular(10.w) : Radius.zero,
            ),
          ),
          child: Text(
            msg.text ?? "",
            textAlign: isMe ? TextAlign.end : TextAlign.start,
            style: TextStyle(
              fontSize: 15.5.sp,
              color: isMe ? Colors.black : ConstColor.white.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 0.5.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              msg.seenAt ?? "",
              style: context.regular14,
            ),
            SizedBox(width: 2.w),
            const Icon(Icons.trending_up),
          ],
        ),
      ],
    );
  }
}
