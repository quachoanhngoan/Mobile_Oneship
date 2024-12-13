import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/login_form_field.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/common/logo_widget.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isSavePassword = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                    content: const Text('Tính năng này đang được phát triển'),
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
          child: Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const LogoWidget(),
                const SizedBox(height: 50),
                LoginForm(
                    obscureText: obscureText, isSavePassword: isSavePassword),
                SizedBox(height: 24.sp),
                AppButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.sp,
                    horizontal: AppDimensions.padding,
                  ),
                  margin: EdgeInsets.zero,
                  onPressed: () {
                    Get.toNamed(AppRoutes.homepage);
                  },
                  text: 'Đăng nhập',
                  textColor: AppColors.textButtonDisable,
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
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.obscureText,
    required this.isSavePassword,
  });

  final ValueNotifier<bool> obscureText;
  final ValueNotifier<bool> isSavePassword;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LoginFormField(
          hintText: 'Nhập số điện thoại',
          prefixIcon: AppAssets.imagesIconsUserAlt2,
          obscureText: false,
        ),
        SizedBox(height: AppDimensions.paddingSmall),
        ValueListenableBuilder(
          valueListenable: obscureText,
          builder: (context, snapshot, _) {
            return LoginFormField(
              hintText: 'Nhập mật khẩu',
              prefixIcon: AppAssets.imagesIconsLockAlt,
              obscureText: snapshot,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    icon: ImageAssetWidget(
                      image: snapshot
                          ? AppAssets.imagesIconsEyeOff
                          : AppAssets.imagesIconsEye,
                      height: 20,
                      width: 20,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      obscureText.value = !obscureText.value;
                    },
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: AppColors.placeHolderColor,
                  ),
                  SizedBox(width: AppDimensions.paddingSmall),
                  Text(
                    'Quên?',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 12.sp),
        //luuw pass
        Row(
          children: [
            GestureDetector(
              onTap: () {
                isSavePassword.value = !isSavePassword.value;
              },
              child: Row(
                children: [
                  ValueListenableBuilder(
                      valueListenable: isSavePassword,
                      builder: (context, snapshot, _) {
                        return Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: snapshot
                                  ? AppColors.primary
                                  : AppColors.placeHolderColor,
                              width: 1,
                            ),
                            color: snapshot ? AppColors.primary : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: snapshot
                              ? const ImageAssetWidget(
                                  image: AppAssets.imagesIconsIcon,
                                  width: 20,
                                  height: 20,
                                  color: Colors.white,
                                )
                              : const SizedBox.shrink(),
                        );
                      }),
                  SizedBox(width: AppDimensions.paddingSmall),
                  Text(
                    'Lưu mật khẩu',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            //dang nhap bằng sms ( under line)
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.loginWithSMS);
                  },
                  child: Text(
                    'Đăng nhập bằng SMS',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
