import 'package:easy_cha/core/common/input.dart';
import 'package:easy_cha/core/constant/const_color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../widget/user_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // toolbarHeight: 7.5.h,
        title: Padding(
          padding: EdgeInsets.only(left: 6.w, right: 4.w),
          child: const Input(
            hint: "Search Message",
            prefix: Iconsax.search_normal,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 6.w),
              padding: EdgeInsets.all(3.5.w),
              decoration: BoxDecoration(
                color: ConstColor.white.color,
                borderRadius: BorderRadius.circular(3.5.w),
              ),
              child: const Icon(Iconsax.edit),
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: 1,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        itemBuilder: (_, index) {
          return const UserCard();
        },
        separatorBuilder: (_, index) => SizedBox(height: 1.5.h),
      ),
    );
  }
}
