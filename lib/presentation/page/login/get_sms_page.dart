import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/login/auth/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/login/loading_widget.dart';
import 'package:oneship_merchant_app/presentation/page/register/widget/pinput_widget.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/common/logo_widget.dart';

class GetSmsPage extends StatefulWidget {
  const GetSmsPage({super.key});

  @override
  State<GetSmsPage> createState() => _GetSmsPageState();
}

class _GetSmsPageState extends State<GetSmsPage> {
  final ValueNotifier<String?> idToken = ValueNotifier<String?>(null);
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
                'Đăng nhập',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              leading: const SizedBox.shrink(),
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
                  const LogoWidget(),
                  const SizedBox(height: 50),
                  PinputWidget(onDone: (value) {
                    idToken.value = value;
                  }),
                  SizedBox(height: 24.sp),
                  ValueListenableBuilder(
                      valueListenable: idToken,
                      builder: (context, snapshot, _) {
                        return AppButton(
                          isEnable: snapshot != null,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.sp,
                            horizontal: AppDimensions.padding,
                          ),
                          margin: EdgeInsets.zero,
                          onPressed: () {
                            // context.read<AuthCubit>().loginSMS(
                            //       phoneController!.text,
                            //     );
                            // Get.toNamed(AppRoutes.homepage);
                          },
                          text: 'Đăng nhập',
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
                      'Đăng nhập bằng mật khẩu',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                  ),

                  const Spacer(),
                  //chưa có tài khoản(no underline) , đăng ký ngay( under line),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chưa có tài khoản?',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: AppDimensions.paddingSmall),
                      GestureDetector(
                        onTap: () {
                          // Get.toNamed(AppRoutes.register);
                        },
                        child: Text(
                          'Đăng ký',
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
                  SizedBox(height: 24.sp),
                ],
              ),
            ),
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.loadingState.isLoading) {
                return const LoadingWidget();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
