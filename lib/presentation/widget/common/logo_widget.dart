import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/config.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'GOO+ ĐỐI TÁC',
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 28.sp,
            color: AppColors.primary,
          ),
    );
  }
}
