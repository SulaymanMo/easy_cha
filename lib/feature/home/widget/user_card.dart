import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/const_string.dart';
import 'package:easy_cha/core/constant/extension.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          context.nav.pushNamed(Routes.chat);
        },
        leading: CircleAvatar(radius: 7.w),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "Manar",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.semi16,
              ),
            ),
            SizedBox(width: 2.w),
            Text("12:40 PM", style: context.regular14),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "The last message shown here",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.regular14,
              ),
            ),
            SizedBox(width: 2.w),
            CircleAvatar(
              radius: 3.w,
              child: Text(
                "3",
                style: context.regular14?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
