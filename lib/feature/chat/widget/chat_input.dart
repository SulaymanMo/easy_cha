import 'package:easy_cha/core/constant/extension.dart';
import 'package:easy_cha/core/helper/show_msg.dart';
import 'package:easy_cha/feature/chat/model/send_file_model.dart';
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

  static const List<String> _files = ["Image", "File"];
  static const List<FileType> _types = [FileType.image, FileType.any];
  static const List<IconData> _icons = [Iconsax.gallery, Iconsax.document];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 2.h),
      color: context.theme.brightness == Brightness.dark
          ? ConstColor.dark.color
          : ConstColor.secondary.color,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<MsgCubit, MsgState>(
            listener: (_, state) {
              if (state is MsgFailure) {
                showMsg(
                  context,
                  title: "Oops!",
                  msg: state.error,
                  alertWidget: Icon(Iconsax.danger, size: 38.sp),
                  onPressed: () async {},
                );
              }
            },
            builder: (_, state) {
              if (state is FilesPickedState) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: TextButton(
                            onPressed: () {
                              context.read<MsgCubit>().removeAll(state.files);
                            },
                            child: const Text("Remove All"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.files.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          itemBuilder: (_, index) => Stack(
                            clipBehavior: Clip.hardEdge,
                            children: [
                              Card(
                                elevation: 10,
                                child: Image.file(
                                  state.files[index],
                                  height: 15.h,
                                ),
                              ),
                              Positioned(
                                top: 1.w,
                                right: 1.w,
                                child: GestureDetector(
                                  onTap: () =>
                                      context.read<MsgCubit>().removeFile(
                                            files: state.files,
                                            index: state.files.indexOf(
                                              state.files[index],
                                            ),
                                          ),
                                  child: const Icon(Iconsax.close_circle),
                                ),
                              ),
                            ],
                          ),
                          separatorBuilder: (_, index) => SizedBox(width: 3.w),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          SizedBox(height: 1.5.h),
          Form(
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
                      width: 2.w,
                      indent: 1.h,
                      endIndent: 1.h,
                    ),
                    // ! _____ PICK FILE BUTTON _____
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
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
                                          await context
                                              .read<MsgCubit>()
                                              .pickFiles(_types[index]);
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
                          },
                        );
                      },
                      icon: Icon(
                        Iconsax.gallery,
                        color: ConstColor.icon.color,
                      ),
                    ),
                    // ! _____ SEND BUTTON _____
                    BlocBuilder<MsgCubit, MsgState>(
                      builder: (_, state) {
                        return IconButton(
                          onPressed: () {
                            if (state is FilesPickedState) {
                              context.read<MsgCubit>().sendFiles(
                                    SendFileModel(
                                      type: "images",
                                      sender: 0,
                                      receiver: widget.user.id,
                                      files: state.files
                                          .map((e) => e.path)
                                          .toList(),
                                    ),
                                  );
                              return;
                            }
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
                        );
                      },
                    ),
                  ],
                ),
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
