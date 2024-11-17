import 'package:easy_cha/core/constant/extension.dart';
import 'package:easy_cha/feature/chat/model/send_file_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import '../../../core/common/input.dart';
import '../../../core/constant/const_color.dart';
import '../../../core/constant/const_string.dart';
import '../../home/manager/msg_manager/msg_cubit.dart';
import '../../home/manager/typing_msg_manager/typing_cubit.dart';
import '../../home/model/home_model/home_user_model.dart';
import 'media_bottom_sheet.dart';
import 'preview_before_send.dart';

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
          const PreviewBeforeSend(),
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
                      onPressed: () => _bottomSheet(context),
                      icon: Icon(
                        Iconsax.gallery,
                        color: ConstColor.icon.color,
                      ),
                    ),
                    // ! _____ SEND BUTTON _____
                    BlocBuilder<MsgCubit, MsgState>(
                      builder: (_, state) {
                        return IconButton(
                          onPressed: () async => await _send(state),
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

  void _bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BlocProvider<MsgCubit>.value(
        value: context.read<MsgCubit>(),
        child: const MediaBottomSheet(),
      ),
    );
  }

  Future<void> _send(MsgState state) async {
    if (state is FilesPickedState) {
      context.read<MsgCubit>().sendFiles(
            SendFileModel(
              type: ConstString.imageType,
              sender: 0,
              receiver: widget.user.id,
              files: state.files.map((e) => e.path).toList(),
            ),
          );
      // return;
    }
    if (_controller.text.trim().isEmpty) return;
    context.read<MsgCubit>().sendMsg(
          widget.user.id,
          _controller.text.trim(),
        );
    _controller.clear();
  }
}
