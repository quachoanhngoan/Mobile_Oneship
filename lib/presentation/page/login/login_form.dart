import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/home/home_page.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/login_form_field.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.obscureText,
    required this.isSavePassword,
    this.phoneController,
    this.passwordController,
    this.phoneFocusNode,
    this.passwordFocusNode,
    required this.formKey,
  });

  final ValueNotifier<bool> obscureText;
  final ValueNotifier<bool> isSavePassword;
  final TextEditingController? phoneController;
  final TextEditingController? passwordController;
  final FocusNode? phoneFocusNode;
  final FocusNode? passwordFocusNode;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LoginFormField(
            validator: (p0) {
              if (p0 == null || p0.isEmpty) {
                return 'Vui lòng nhập số điện thoại';
              }
              // if (ValidateHelper.validatePhone(p0) == false) {
              //   return 'Số điện thoại không hợp lệ';
              // }
              return null;
            },
            hintText: 'Nhập số điện thoại hoặc email',
            focusNode: phoneFocusNode,
            controller: phoneController,
            prefixIcon: AppAssets.imagesIconsUserAlt2,
            obscureText: false,
          ),
          SizedBox(height: AppDimensions.paddingSmall),
          ValueListenableBuilder(
            valueListenable: obscureText,
            builder: (context, snapshot, _) {
              return LoginFormField(
                hintText: 'Nhập mật khẩu',
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  if (p0.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }
                  return null;
                },
                controller: passwordController,
                focusNode: passwordFocusNode,
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
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.registerpage, arguments: false);
                      },
                      child: Text(
                        'Quên?',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
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
                              color:
                                  snapshot ? AppColors.primary : Colors.white,
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
                      Get.offNamed(AppRoutes.loginWithSMS);
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
      ),
    );
  }
}
