import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../core/helper/show_msg.dart';
import '../../home/manager/msg_manager/msg_cubit.dart';

class PreviewBeforeSend extends StatelessWidget {
  const PreviewBeforeSend({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MsgCubit, MsgState>(
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
                            onTap: () => context.read<MsgCubit>().removeFile(
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
    );
  }
}
