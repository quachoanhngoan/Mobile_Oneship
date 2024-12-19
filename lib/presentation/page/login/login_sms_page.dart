import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/helper/validate.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/login/get_sms_page.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/bottom_go_to_register.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/loading_widget.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/login_form_field.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/common/logo_widget.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

class LoginSmsPage extends StatefulWidget {
  const LoginSmsPage({super.key});

  @override
  State<LoginSmsPage> createState() => _LoginSmsPageState();
}

class _LoginSmsPageState extends State<LoginSmsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode? phoneFocusNode;

  TextEditingController? phoneController;
  final ValueNotifier<bool> isCanLogin = ValueNotifier<bool>(false);

  @override
  void initState() {
    phoneFocusNode = FocusNode();

    phoneController = TextEditingController();
    listener();
    super.initState();
  }

  void listener() {
    phoneController!.addListener(() {
      if (phoneController!.text.isNotEmpty) {
        isCanLogin.value = true;
      } else {
        isCanLogin.value = false;
      }
    });
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
                  LoginFormField(
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      if (ValidateHelper.validatePhone(p0) == false) {
                        return 'Số điện thoại không hợp lệ';
                      }
                      return null;
                    },
                    hintText: 'Nhập số điện thoại',
                    focusNode: phoneFocusNode,
                    controller: phoneController,
                    prefixIcon: AppAssets.imagesIconsPhone,
                    obscureText: false,
                  ),
                  SizedBox(height: 24.sp),
                  ValueListenableBuilder(
                      valueListenable: isCanLogin,
                      builder: (context, snapshot, _) {
                        return AppButton(
                          isEnable: snapshot,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.sp,
                            horizontal: AppDimensions.padding,
                          ),
                          margin: EdgeInsets.zero,
                          onPressed: () async {
                            if (phoneController != null &&
                                phoneController!.text.isEmpty) {
                              return;
                            }

                            final phone = ValidateHelper.phoneFormat(
                                phoneController!.text);
                            if (!verifyPhone(phone)) {
                              return;
                            }
                            Get.to(() => GetSmsPage(
                                  phone: phone,
                                ));
                          },
                          text: 'Tiếp tục',
                          textColor:
                              !snapshot ? AppColors.textButtonDisable : null,
                        );
                      }),
                  SizedBox(height: 24.sp),
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(AppRoutes.loginPage);
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

                  const Spacer(),
                  //chưa có tài khoản(no underline) , đăng ký ngay( under line),
                  const BottomGoToRegister(),

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

bool verifyPhone(String phone) {
  // Xác thực số điện thoại Việt Nam (10 hoặc 11 chữ số sau mã vùng)
  final regex = RegExp(r'^\+84[35789]\d{8}$');
  if (!regex.hasMatch(phone)) {
    dialogService.showAlertDialog(
        title: 'Lỗi',
        context: Get.context!,
        description: 'Số điện thoại không hợp lệ',
        buttonTitle: 'OK',
        onPressed: () {
          Get.back();
        });
    return false;
  }
  return true;
}
