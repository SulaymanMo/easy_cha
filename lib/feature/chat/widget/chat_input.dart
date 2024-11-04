import 'package:easy_cha/core/constant/extension.dart';
import 'package:easy_cha/feature/chat/manager/file_manager/pick_file_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import '../../../core/common/input.dart';
import '../../../core/constant/const_color.dart';
import '../../home/manager/msg_manager/msg_cubit.dart';
import '../../home/manager/typing_msg_manager/typing_cubit.dart';
import '../../home/model/home_model/home_user_model.dart';

class ChatInput extends StatefulWidget {
  final HomeUserModel user;
  const ChatInput({super.key, required this.user});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
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

  static const List<String> _files = ["Image", "Video", "File"];
  static const List<IconData> _icons = [
    Iconsax.gallery,
    Iconsax.video,
    Iconsax.document,
  ];
  static const List<FileType> _types = [
    FileType.image,
    FileType.video,
    FileType.any,
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Input(
        onChanged: (val) {
          if (val != null && val != "" && val.isNotEmpty) {
            context.read<TypingMsgCubit>().isSenderTyping(widget.user.id);
          }
        },
        hint: "Type here...",
        controller: _controller,
        suffix: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              VerticalDivider(
                indent: 1.h,
                endIndent: 1.h,
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 4.w,
                          right: 4.w,
                          bottom: 4.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Pick a Choise",
                              style: context.medium16,
                            ),
                            SizedBox(height: 2.h),
                            Wrap(
                              spacing: 4.w,
                              alignment: WrapAlignment.spaceEvenly,
                              runSpacing: 1.5.h,
                              children: List.generate(
                                _files.length,
                                (index) => BottomSheetFile(
                                  type: _files[index],
                                  iconData: _icons[index],
                                  onTap: () async {
                                    await context
                                        .read<PickFileCubit>()
                                        .pickFiles(_types[index]);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  // context.read<PickFileCubit>().pickFiles("fileType");
                },
                icon: Icon(
                  Iconsax.sticker,
                  color: ConstColor.icon.color,
                ),
              ),
              // SizedBox(width: 0.5.w),
              IconButton(
                onPressed: () {
                  if (_controller.text.trim().isEmpty) return;
                  // ! Send
                  context.read<MsgCubit>().sendMsg(
                        widget.user.id,
                        _controller.text.trim(),
                      );
                  // ! Clear
                  _controller.clear();
                },
                icon: Icon(
                  Iconsax.send_1,
                  color: ConstColor.icon.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetFile extends StatelessWidget {
  final String type;
  final IconData iconData;
  final Future<void> Function() onTap;

  const BottomSheetFile({
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
