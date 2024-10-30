import 'package:easy_cha/core/common/input.dart';
import 'package:easy_cha/core/common/skeleton.dart';
import 'package:easy_cha/feature/home/manager/home_manager/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../core/common/failure_widget.dart';
import '../../../core/constant/const_color.dart';
import '../widget/user_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await context.read<HomeCubit>().getUsers(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (_, state) {
            if (state is HomeSuccess) {
              return ListView.separated(
                itemCount: state.users.length,
                separatorBuilder: (_, index) => SizedBox(height: 1.5.h),
                itemBuilder: (_, index) => UserCard(user: state.users[index]),
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              );
            } else if (state is HomeFailure) {
              return FailureWidget(state.error);
            } else {
              return ListView.separated(
                itemCount: 10,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                itemBuilder: (_, index) => Skeleton(
                  height: 9.h,
                  width: double.infinity,
                ),
                separatorBuilder: (_, index) => SizedBox(height: 1.5.h),
              );
            }
          },
        ),
      ),
    );
  }
}
