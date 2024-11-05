import 'package:easy_cha/core/common/custom_image.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:easy_cha/core/constant/extension.dart';
import 'package:easy_cha/core/constant/const_color.dart';

import '../../../core/constant/const_string.dart';
import '../model/chat_msg_model.dart';

class ChatMsg extends StatelessWidget {
  final bool isMe;
  final ChatMsgModel msg;
  const ChatMsg({required this.isMe, required this.msg, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: msg.type != "text"
              ? EdgeInsets.all(1.w)
              : EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.75.h),
          decoration: BoxDecoration(
            color: isMe
                ? ConstColor.primary.color
                : context.theme.brightness == Brightness.dark
                    ? ConstColor.iconDark.color
                    : ConstColor.secondary.color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.w),
              topRight: Radius.circular(4.w),
              bottomRight: isMe ? Radius.zero : Radius.circular(4.w),
              bottomLeft: isMe ? Radius.circular(4.w) : Radius.zero,
            ),
          ),
          child: msg.type == ConstString.imageType
              ? CustomImage(image: msg.text)
              : msg.type == ConstString.fileType
                  ? Container(
                      width: 50.w,
                      height: 10.h,
                      color: Colors.red,
                    )
                  : Text(
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
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
