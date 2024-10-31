import 'package:easy_cha/core/constant/extension.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

void showMsg(
  BuildContext context, {
  required String title,
  required String msg,
  required Widget alertWidget,
  required Future Function() onPressed,
}) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h, child: alertWidget),
            SizedBox(height: 1.5.h),
            Text(title, style: context.bold18?.copyWith(letterSpacing: 1.5.sp)),
            SizedBox(height: 1.5.h),
            Text(
              msg,
              style: context.medium16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.5.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.nav.pop();
                    },
                    child: const Text("Undo"),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      await onPressed();
                      if (context.mounted) context.nav.pop();
                    },
                    child: const Text(
                      "Yes, Cancel",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
