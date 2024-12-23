import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_state.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/text_field_base.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

import '../../../core/constant/app_assets.dart';
import '../../../core/constant/dimensions.dart';
import '../../widget/loading/loading.dart';
import 'widget/pinput_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _phoneController;
  late final TextEditingController _passController;
  late final TextEditingController _rePassController;
  late final PageController _pageController;

  late final FocusNode _phoneNode;
  late final FocusNode _passNode;
  late final FocusNode _rePassNode;

  int indexPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    _phoneController = TextEditingController();
    _passController = TextEditingController();
    _rePassController = TextEditingController();
    _phoneNode = FocusNode();
    _passNode = FocusNode();
    _rePassNode = FocusNode();
    context.read<RegisterCubit>().changePage(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isRegister = Get.arguments as bool;

    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state.isContinueStep == true) {
        if (indexPage < 2) {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        } else {
          context.popScreen();
          Future.delayed(const Duration(seconds: 3), () {
            Get.back();
            Get.toNamed(AppRoutes.loginPage);
          });
          createAccountSuccessDialog(isRegister);
        }
      }
      if (state.titleFailedDialog != null) {
        showErrorDialog(state.titleFailedDialog!);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBarAuth(
          title: state.title ?? "",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const VSpacing(spacing: 4),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Expanded(
                          child: AnimatedContainer(
                            margin: const EdgeInsets.only(right: 5),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInCubic,
                            height: 6,
                            decoration: BoxDecoration(
                                color: indexPage >= index
                                    ? AppColors.color988
                                    : AppColors.color8E8,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      }),
                    ),
                  ),
                  const VSpacing(spacing: 16),
                  SizedBox(
                    height: indexPage != 2 ? 130.h : 230.h,
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        indexPage = value;
                        FocusScope.of(context).unfocus();
                        context.read<RegisterCubit>().changePage(value);
                      },
                      children: [
                        PhoneRegister(
                            focusNode: _phoneNode,
                            isForcus: state.isEnableContinue ?? false,
                            suffixClick: () {
                              _phoneController.clear();
                              context
                                  .read<RegisterCubit>()
                                  .validateUserName(null);
                            },
                            onChange: (value) {
                              context
                                  .read<RegisterCubit>()
                                  .validateUserName(value);
                            },
                            phoneController: _phoneController),
                        OtpRegister(
                          phone: _phoneController.text,
                          timeOutListener: () {
                            context.read<RegisterCubit>().timeOutOtp();
                          },
                          timeoutPressed: () {
                            context.read<RegisterCubit>().submitPhoneOrEmail(
                                _phoneController.text.trim(),
                                isReSent: true,
                                isRegister: isRegister);
                          },
                          onDone: (value) {
                            context.read<RegisterCubit>().validateOtp(value);
                          },
                        ),
                        CreatePasswordRegister(
                          passwordController: _passController,
                          rePasswordController: _rePassController,
                          state: state,
                          rePassNode: _rePassNode,
                          passNode: _passNode,
                        )
                      ],
                    ),
                  ),
                  AppButton(
                    text: "Tiếp tục",
                    textColor: state.isEnableContinue == true
                        ? AppColors.white
                        : AppColors.colorA4A,
                    onPressed: () {
                      switch (indexPage) {
                        case 0:
                          _phoneNode.unfocus();
                          context.read<RegisterCubit>().submitPhoneOrEmail(
                              _phoneController.text.trim(),
                              isReSent: false,
                              isRegister: isRegister);
                          break;
                        case 1:
                          context
                              .read<RegisterCubit>()
                              .sentOtp(email: _phoneController.text);
                          break;
                        case 2:
                          _passNode.unfocus();
                          _rePassNode.unfocus();
                          if (isRegister) {
                            context
                                .read<RegisterCubit>()
                                .createPasswordWithPhoneOrEmail(
                                    _rePassController.text,
                                    email: _phoneController.text);
                          } else {
                            context
                                .read<RegisterCubit>()
                                .resetPasswordWithPhoneOrEmail(
                                    _rePassController.text,
                                    email: _phoneController.text);
                          }

                          break;
                      }
                    },
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    isSafeArea: false,
                    backgroundColor: state.isEnableContinue == true
                        ? AppColors.color988
                        : AppColors.color8E8,
                    isEnable: state.isEnableContinue == true,
                  ),
                  const VSpacing(spacing: 20),
                  GestureDetector(
                    onTap: () {
                      context.popScreen();
                      context.pushWithNamed(context,
                          routerName: AppRoutes.loginPage);
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Đã có tài khoản? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.colorC5C),
                      ),
                      TextSpan(
                          text: "Đăng nhập",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: AppColors.color988,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.color988))
                    ])),
                  )
                ],
              ),
              Visibility(
                  visible: state.isLoading == true,
                  child: const LoadingWidget())
            ],
          ),
        ),
      );
    });
  }

  createAccountSuccessDialog(bool isRegister) {
    context.showDialogWidget(context,
        child: Dialog(
          backgroundColor: AppColors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const ImageAssetWidget(
                      image: AppAssets.imagesIcPartyHorn,
                      width: 24,
                      height: 24,
                    ),
                    const HSpacing(spacing: 6),
                    Text(
                      "Xin chúc mừng !",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const VSpacing(spacing: 8),
                Text(
                  isRegister == true
                      ? "Bạn đã đăng ký tài khoản\nthành công!"
                      : "Bạn đã tạo mật khẩu thành công!",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ));
  }

  showErrorDialog(String title) {
    context.showDialogWidget(context,
        child: Dialog(
            backgroundColor: AppColors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const VSpacing(spacing: 12),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const VSpacing(spacing: 6),
                  Text(
                    "Vui lòng thử lại",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  const VSpacing(spacing: 12),
                  Divider(
                    color: AppColors.color080.withOpacity(0.55),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          context.popScreen();
                        },
                        child: Text(
                          "OK",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.color988),
                        )),
                  )
                ],
              ),
            )));
  }
}

class PhoneRegister extends StatelessWidget {
  final TextEditingController phoneController;
  final bool isForcus;
  final FocusNode focusNode;
  final Function(String?) onChange;
  final Function suffixClick;
  const PhoneRegister(
      {super.key,
      required this.phoneController,
      required this.isForcus,
      required this.onChange,
      required this.suffixClick,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Chúng tôi sẽ gửi mã xác nhận OTP đến số điện thoại hoặc email đăng ký.",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.color723, fontWeight: FontWeight.w500),
        ),
        const VSpacing(spacing: 20),
        TextFieldBase(
          focusNode: focusNode,
          controller: phoneController,
          hintText: "Nhập SĐT hoặc email",
          onChanged: (value) {
            onChange(value);
          },
          prefix: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: ImageAssetWidget(
              image: AppAssets.imagesIcPerson,
              width: 12,
              height: 16,
              fit: BoxFit.contain,
              color: isForcus ? AppColors.black : AppColors.color2B3,
            ),
          ),
          suffix: isForcus
              ? IconButton(
                  onPressed: () {
                    suffixClick();
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: AppColors.color2B3,
                    size: 18,
                  ))
              : Container(width: 18),
        ),
      ],
    );
  }
}

class OtpRegister extends StatelessWidget {
  final Function(String) onDone;
  final Function() timeoutPressed;
  final Function() timeOutListener;
  final String phone;
  const OtpRegister(
      {super.key,
      required this.phone,
      required this.onDone,
      required this.timeoutPressed,
      required this.timeOutListener});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Mã xác thực OTP đã được gửi đến $phone",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.color723, fontWeight: FontWeight.w500),
        ),
        const VSpacing(spacing: 20),
        PinputWidget(
          timeOutPressed: timeoutPressed,
          onDone: onDone,
          timeOutListener: timeOutListener,
        )
      ],
    );
  }
}

class CreatePasswordRegister extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  final FocusNode? passNode;
  final FocusNode? rePassNode;
  final RegisterState state;

  const CreatePasswordRegister({
    super.key,
    this.passNode,
    this.rePassNode,
    required this.passwordController,
    required this.rePasswordController,
    required this.state,
  });

  @override
  State<CreatePasswordRegister> createState() => _CreatePasswordRegisterState();
}

class _CreatePasswordRegisterState extends State<CreatePasswordRegister> {
  bool obscureTextPass = true;
  bool obscureTextRePass = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            "Mật khẩu phải có độ dài từ 8-16 ký tự, bao gồm ít nhất một chữ in hoa, một chữ in thường và chỉ chứa các chữ cái, số hoặc các ký tự thông thường.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.color723, fontWeight: FontWeight.w500),
          ),
          const VSpacing(spacing: 12),
          TextFieldPassRegister(
              focusNode: widget.passNode,
              suffixClick: () {
                setState(() {
                  obscureTextPass = !obscureTextPass;
                });
              },
              errorText: widget.state.errorPass,
              obscureText: obscureTextPass,
              onChange: (value) {
                context
                    .read<RegisterCubit>()
                    .validatePass(value, widget.rePasswordController.text);
              },
              controller: widget.passwordController,
              hintText: "Nhập mật khẩu",
              iSHintTextVisible: widget.state.showHintTextPass == true),
          const VSpacing(spacing: 16),
          TextFieldPassRegister(
              focusNode: widget.rePassNode,
              suffixClick: () {
                setState(() {
                  obscureTextRePass = !obscureTextRePass;
                });
              },
              errorText: widget.state.errorRepass,
              obscureText: obscureTextRePass,
              onChange: (value) {
                context
                    .read<RegisterCubit>()
                    .validatePass(widget.passwordController.text, value);
              },
              controller: widget.rePasswordController,
              hintText: "Nhập lại mật khẩu",
              iSHintTextVisible: widget.state.showHintTextRePass == true)
        ],
      ),
    );
  }
}

class TextFieldPassRegister extends StatelessWidget {
  final TextEditingController controller;
  final bool iSHintTextVisible;
  final String hintText;
  final Function(String?) onChange;
  final bool obscureText;
  final Function suffixClick;
  final String? errorText;
  final FocusNode? focusNode;
  const TextFieldPassRegister(
      {super.key,
      this.focusNode,
      required this.onChange,
      required this.controller,
      required this.hintText,
      required this.iSHintTextVisible,
      required this.obscureText,
      required this.suffixClick,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Visibility(
          visible: iSHintTextVisible,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text.rich(
              TextSpan(
                text: hintText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.color2B3, fontWeight: FontWeight.w500),
                children: const [
                  TextSpan(
                      text: '*',
                      style: TextStyle(fontSize: 14, color: AppColors.red)),
                ],
              ),
            ),
          ),
        ),
        TextFieldBase(
          controller: controller,
          obscureText: obscureText,
          focusNode: focusNode,
          hintText: "",
          errorText: errorText,
          onChanged: (value) {
            onChange(value);
          },
          suffix: IconButton(
              onPressed: () {
                suffixClick();
              },
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.color2B3,
                size: 18,
              )),
        ),
      ],
    );
  }
}
