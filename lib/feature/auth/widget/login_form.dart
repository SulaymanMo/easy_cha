import 'package:easy_cha/core/constant/extension.dart';
import 'package:easy_cha/core/helper/show_msg.dart';
import 'package:easy_cha/feature/auth/manager/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../core/common/input.dart';
import '../../../core/constant/const_string.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _emailController;
  late TextEditingController _passController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp passRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  @override
  void initState() {
    super.initState();
    _passController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Input(
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter your email";
              } else if (!emailRegex.hasMatch(val)) {
                return "Please enter a vaild email adress";
              }
              return null;
            },
            hint: "Email",
            prefix: Iconsax.sms,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 1.5.h),
          Input(
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter your password";
              }
              // else if (!passRegex.hasMatch(val)) {
              //   return "Password must be at least 8 characters long, contain a letter, a number, and a special character";
              // }
              return null;
            },
            maxLines: 1,
            hint: "Password",
            obscureText: true,
            prefix: Iconsax.lock,
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 0.5.h),
          TextButton(
            onPressed: () {},
            child: const Text("Forgot password?"),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: double.infinity,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (_, state) {
                if (state is AuthFailure) {
                  showMsg(
                    context,
                    title: "Oops!",
                    msg: state.error,
                    alertWidget: const SizedBox(),
                    onPressed: () async {},
                  );
                } else if (state is AuthSuccess) {
                  context.nav.pushNamed(Routes.home);
                }
              },
              builder: (_, state) {
                return OutlinedButton(
                  onPressed: () async => await _login(context),
                  child: const Text("Continue"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await context
          .read<AuthCubit>()
          .login(_emailController.text, _passController.text);
    }
    setState(() {
      _autovalidate = AutovalidateMode.always;
    });
  }
}
