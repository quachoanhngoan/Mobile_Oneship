import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:pinput/pinput.dart';

import '../../../../config/config.dart';

class PinputWidget extends StatelessWidget {
  final Function(String) onDone;
  //function to get value from Pinput
  final Function onTapResend;
  const PinputWidget({
    super.key,
    required this.onDone,
    required this.onTapResend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 30, bottom: 20),
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          Pinput(
            controller: context.read<AuthCubit>().otpController,
            length: 6,
            defaultPinTheme: PinTheme(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.colorA8A, width: 1),
              ),
            ),
            onChanged: (value) {
              if (value.length == 6) {
                onDone(value);
                // controller.clear();
              }
            },
            showCursor: false,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () async {
                  await onTapResend();
                  // if (state.timeCount == 0) {
                  //   Get.context?.read<AuthCubit>().countDownTime();
                  // }
                },
                child: RichText(
                    text: TextSpan(children: [
                  if (state.timeCount != 0) ...[
                    TextSpan(
                        text: "Mã OTP hết hạn sau ",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.color723,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: "${state.timeCount}s",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.color723,
                            fontWeight: FontWeight.w700))
                  ] else ...[
                    TextSpan(
                        text: "Bạn không nhận được mã? ",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.color723,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: "Gửi lại",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.color988,
                            fontWeight: FontWeight.w700))
                  ]
                ])),
              );
            },
          )
        ],
      ),
    );
  }
}
