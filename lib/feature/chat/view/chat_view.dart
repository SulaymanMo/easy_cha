import 'package:easy_cha/core/constant/const_color.dart';
import 'package:easy_cha/core/constant/extension.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../widget/chat_input.dart';
import '../widget/chat_msg.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 0,
        toolbarHeight: 10.h,
        title: ListTile(
          title: Text(
            "Sulayman Mo Ali",
            style: context.semi16,
          ),
          subtitle: Text(
            "Online",
            style: context.regular14?.copyWith(
              color: Colors.green.shade800,
            ),
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => context.nav.pop(),
                child: const Icon(Iconsax.arrow_left_2),
              ),
              SizedBox(width: 2.w),
              CircleAvatar(radius: 7.w),
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
        backgroundColor: ConstColor.white.color,
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
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: 2.h,
                left: 6.w,
                right: 6.w,
                bottom: 2.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.w),
              ),
              child: const ChatForm(receiver: 1000004),
            ),
          ),
        ],
      ),
    );
  }
}
