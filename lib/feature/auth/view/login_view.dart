import 'package:easy_cha/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../../core/constant/const_color.dart';
import '../widget/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -.2),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          children: [
            SvgPicture.asset("assets/images/bird.svg", height: 16.h),
            SizedBox(height: 3.h),
            Text(
              "Hi, Welcome Back",
              style: context.semi20,
              textAlign: TextAlign.center,
            ),
            Text(
              "Hope you’re doing fine",
              textAlign: TextAlign.center,
              style: context.medium16?.copyWith(
                color: ConstColor.text.color,
              ),
            ),
            SizedBox(height: 6.h),
            const LoginForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account yet?",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ConstColor.icon.color,
                  ),
                ),
                SizedBox(width: 1.w),
                TextButton(
                  onPressed: () {},
                  child: const Text("Sign up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
