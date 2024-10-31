import 'package:easy_cha/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constant/const_color.dart';

class EmptyChat extends StatelessWidget {
  const EmptyChat({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Iconsax.messages, size: 48.sp),
          SizedBox(height: 2.h),
          SizedBox(
            width: 50.w,
            child: Text(
              'No message here yet...',
              textAlign: TextAlign.center,
              style: context.medium16?.copyWith(
                color: ConstColor.icon.color,
              ),
            ),
          ),
          SizedBox(
            width: 75.w,
            child: Text(
              'Say hello for "$name"',
              textAlign: TextAlign.center,
              style: context.medium16?.copyWith(
                color: ConstColor.icon.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
