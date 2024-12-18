import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';

import '../../../config/theme/color.dart';
import '../../../core/constant/dimensions.dart';

class AppBarAuth extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarAuth({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: IconButton(
          onPressed: () {
            context.popScreen();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 22,
          )),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 16.sp, color: AppColors.color723)),
      actions: [
        Center(
          child: Text(
            "Trợ giúp",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.color988, fontSize: 12.sp),
          ),
        ),
        const HSpacing(spacing: 16)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
