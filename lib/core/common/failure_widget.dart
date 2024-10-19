import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:easy_cha/core/constant/extension.dart';

class FailureWidget extends StatelessWidget {
  final String _error;
  const FailureWidget(this._error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.danger, size: 48.sp),
          SizedBox(height: 2.h),
          Text(_error, style: context.medium16),
        ],
      ),
    );
  }
}
