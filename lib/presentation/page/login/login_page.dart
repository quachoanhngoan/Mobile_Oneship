import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/bottom_go_to_register.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/loading_widget.dart';
import 'package:oneship_merchant_app/presentation/page/login/login_form.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/common/logo_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isSavePassword = ValueNotifier<bool>(false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode? passwordFocusNode;
  FocusNode? phoneFocusNode;

  TextEditingController? phoneController;
  TextEditingController? passwordController;
  final ValueNotifier<bool> isCanLogin = ValueNotifier<bool>(false);

  @override
  void initState() {
    phoneFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    phoneController = TextEditingController(text: prefManager.userName);
    passwordController = TextEditingController(text: prefManager.password);
    if (phoneController!.text.isNotEmpty &&
        passwordController!.text.isNotEmpty) {
      isCanLogin.value = true;
    }
    isSavePassword.value = true;
    listener();
    super.initState();
  }

  void listener() {
    phoneController!.addListener(() {
      if (passwordController!.text.isNotEmpty &&
          phoneController!.text.isNotEmpty) {
        isCanLogin.value = true;
      } else {
        isCanLogin.value = false;
      }
    });

    passwordController!.addListener(() {
      if (passwordController!.text.isNotEmpty &&
          phoneController!.text.isNotEmpty) {
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
                  LoginForm(
                    obscureText: obscureText,
                    isSavePassword: isSavePassword,
                    phoneController: phoneController,
                    passwordController: passwordController,
                    phoneFocusNode: phoneFocusNode,
                    passwordFocusNode: passwordFocusNode,
                    formKey: formKey,
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
                          onPressed: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            context.read<AuthCubit>().loginSubmit(
                                  phoneController!.text,
                                  passwordController!.text,
                                  isSavePassword.value,
                                );
                            // Get.toNamed(AppRoutes.homepage);
                          },
                          text: 'Đăng nhập',
                          textColor:
                              !snapshot ? AppColors.textButtonDisable : null,
                        );
                      }),
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
