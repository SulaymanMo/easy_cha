import 'package:easy_cha/core/constant/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../core/constant/const_color.dart';
import '../../home/manager/msg_manager/msg_cubit.dart';

class MediaBottomSheet extends StatelessWidget {
  const MediaBottomSheet({super.key});
  static const List<String> _files = ["Image", "File"];
  static const List<FileType> _types = [FileType.image, FileType.any];
  static const List<IconData> _icons = [Iconsax.gallery, Iconsax.document];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.w,
        right: 4.w,
        bottom: 4.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              "You can send 5 files at once. The maximum file size is 1MB.",
              style: context.medium16?.copyWith(
                color: ConstColor.icon.color,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 4.w,
            runSpacing: 1.5.h,
            // alignment: WrapAlignment.spaceEvenly,
            children: List.generate(
              _files.length,
              (index) => BottomSheetItem(
                type: _files[index],
                iconData: _icons[index],
                onTap: () async {
                  await context.read<MsgCubit>().pickFiles(_types[index]);
                  if (context.mounted) {
                    context.nav.pop();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  final String type;
  final IconData iconData;
  final Future<void> Function() onTap;

  const BottomSheetItem({
    super.key,
    required this.type,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 32.sp),
            SizedBox(height: 1.h),
            Text(type, style: context.regular14),
          ],
        ),
      ),
    );
  }
}
