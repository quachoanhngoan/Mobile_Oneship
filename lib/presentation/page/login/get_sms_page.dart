import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/loading_widget.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/pinput_widget.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';

class GetSmsPage extends StatefulWidget {
  const GetSmsPage({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<GetSmsPage> createState() => _GetSmsPageState();
}

class _GetSmsPageState extends State<GetSmsPage> {
  final ValueNotifier<String?> idToken = ValueNotifier<String?>(null);
  final ValueNotifier<String?> valueSMS = ValueNotifier<String?>(null);
  // String smsCode = '';
  @override
  void initState() {
    context.read<AuthCubit>().verifyPhoneNumber(widget.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'Nhập mã xác thực OTP',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              // leading: const SizedBox.shrink(),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    showCupertinoDialog<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Thông báo'),
                        content:
                            const Text('Tính năng này đang được phát triển'),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            /// This parameter indicates the action would perform
                            /// a destructive action such as deletion, and turns
                            /// the action's text color to red.
                            isDestructiveAction: true,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Yes',
                                style: TextStyle(color: AppColors.primary)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Trợ giúp',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Mã xác thực OTP đã được gửi đến số điện thoại ${formatPhone(widget.phone)}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 50),
                  PinputWidget(
                    onDone: (value) {
                      valueSMS.value = value;
                    },
                    onTapResend: () {
                      context.read<AuthCubit>().verifyPhoneNumber(widget.phone);
                    },
                  ),
                  SizedBox(height: 24.sp),
                  ValueListenableBuilder(
                      valueListenable: valueSMS,
                      builder: (context, snapshot, _) {
                        return AppButton(
                          isEnable: snapshot != null && snapshot.length == 6,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.sp,
                            horizontal: AppDimensions.padding,
                          ),
                          margin: EdgeInsets.zero,
                          onPressed: () {
                            context.read<AuthCubit>().verifyOTP(
                                  snapshot!,
                                );
                          },
                          text: 'Tiếp tục',
                          textColor: snapshot == null
                              ? AppColors.textButtonDisable
                              : null,
                        );
                      }),
                  SizedBox(height: 24.sp),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginPage);
                    },
                    child: Text(
                      'Đăng nhập bằng Mật khẩu',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.loadingState.isLoading || state.getSmsState.isLoading) {
                return const LoadingWidget();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  //+84916308704 => (+84) 916 308 704
  String formatPhone(String phone) {
    // if (phone.length < 10) {
    //   return phone;
    // }
    return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}';
  }
}
