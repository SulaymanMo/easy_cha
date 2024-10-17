import 'package:easy_cha/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/constant/const_color.dart';
import '../widget/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, 0),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          children: [
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
            SizedBox(height: 8.h),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
