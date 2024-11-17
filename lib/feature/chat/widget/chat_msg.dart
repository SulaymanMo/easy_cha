import 'package:easy_cha/core/common/custom_image.dart';
import 'package:easy_cha/core/helper/service_locator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:easy_cha/core/constant/extension.dart';
import 'package:easy_cha/core/constant/const_color.dart';

import '../../../core/constant/const_string.dart';
import '../../../core/helper/file_downloader.dart';
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
                  ? Padding(
                      padding: EdgeInsets.all(1.h),
                      child: InkWell(
                        onTap: () async {
                          await getIt
                              .get<FileDownloader>()
                              .downloadFile(msg.text!, "files");
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Iconsax.document, size: 38.sp),
                            SizedBox(height: 1.5.h),
                            Flexible(
                              child: Text(
                                "File Name",
                                style: context.medium14,
                              ),
                            ),
                          ],
                        ),
                      ),
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
        isMe
            ? Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Text(
                    _formatTimestampTo12Hour(msg.seenAt),
                    style: context.regular14,
                  ),
                  SizedBox(width: 1.5.w),
                  Icon(Icons.check_outlined, size: 16.sp),
                ],
              )
            : Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Icon(Icons.check_outlined, size: 16.sp),
                  SizedBox(width: 1.5.w),
                  Text(
                    _formatTimestampTo12Hour(msg.seenAt),
                    style: context.regular14,
                  ),
                ],
              ),
      ],
    );
  }

  String _formatTimestampTo12Hour(String? seenAt) {
    if (seenAt == null || seenAt.isEmpty) return "";
    // ! Parse the string as an integer (timestamp in milliseconds)
    int timestamp = int.parse(seenAt);
    // ! Convert the timestamp to a DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    // ! Format the DateTime to hh:mm a (12-hour format with AM/PM)
    String formattedTime = DateFormat('hh:mm a').format(date);
    return formattedTime;
  }
}
