import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:easy_cha/core/constant/extension.dart';
import 'package:easy_cha/core/constant/const_color.dart';

class ChatMsg extends StatelessWidget {
  const ChatMsg({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.75.h),
          decoration: BoxDecoration(
            color: ConstColor.mainLight.color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w),
              topRight: Radius.circular(10.w),
              bottomLeft: Radius.circular(10.w),
            ),
          ),
          child: Text(
            "Hello Every One",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 15.5.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 0.5.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "03:24 PM",
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
