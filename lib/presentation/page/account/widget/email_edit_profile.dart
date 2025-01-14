import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/data/model/user/user_model.dart';
import 'package:oneship_merchant_app/presentation/page/account/cubit/edit_profile_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/account/cubit/edit_profile_state.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/login/widget/loading_widget.dart';
import 'package:oneship_merchant_app/presentation/page/register/widget/pinput_widget.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field.dart';

import '../../../../config/theme/color.dart';
import '../../../widget/appbar/appbar_common.dart';

class EmailEditProfile extends StatefulWidget {
  final UserM userData;
  const EmailEditProfile({super.key, required this.userData});

  @override
  State<EmailEditProfile> createState() => _EmailEditProfileState();
}

class _EmailEditProfileState extends State<EmailEditProfile> {
  late PageController pageController;

  int indexPage = 0;
  var titleAppBar = "Email";

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
      if (state.isContinueStep == true) {
        if (indexPage < 3) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        } else {
          context.read<EditProfileCubit>().resetState();
          context.popScreen(result: state.emailResponseSuccess);
        }
      }
      if (state.titleFailedDialog != null) {
        context.showErrorDialog(state.titleFailedDialog!, context);
      }
    }, builder: (context, state) {
      return Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBarAuth(
                title: titleAppBar,
                onPressed: () {
                  context.popScreen();
                }),
            body: Column(
              children: <Widget>[
                indexPage != 0
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    color: indexPage >= index + 1
                                        ? AppColors.color988
                                        : AppColors.color8E8,
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            );
                          }),
                        ),
                      )
                    : const SizedBox.shrink(),
                Expanded(
                    child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      indexPage = value;
                      switch (indexPage) {
                        case 1:
                          titleAppBar = "Cập nhật email";
                          break;
                        case 2:
                          titleAppBar = "Nhập mã xác thực OTP";
                          break;
                        case 3:
                          titleAppBar = "Xác thực OTP";
                          break;
                        default:
                          titleAppBar = "Cập nhật email";
                          break;
                      }
                    });
                  },
                  children: <Widget>[
                    _CurrentEmailPage(
                      email: widget.userData.email ?? "Chưa cập nhật",
                      editEmailPress: () {
                        if (widget.userData.phone != null) {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                    ),
                    _PhoneBodyPage(
                      phone: widget.userData.phone ?? "Chưa cập nhật",
                      isNextStep: () {
                        context.read<EditProfileCubit>().submitPhoneToGetOTP(
                            widget.userData.phone!,
                            isReSent: false,
                            phone: widget.userData.phone!);
                      },
                    ),
                    _OTPBodyPage(
                      state: state,
                      phone: widget.userData.phone!,
                    ),
                    _UpdateEmailBodyPage(continuePressed: (email) {
                      context.read<EditProfileCubit>().sendEmailUpdate(email);
                    })
                  ],
                ))
              ],
            ),
          ),
          Visibility(
            visible: state.isLoading == true,
            child: const LoadingWidget(),
          )
        ],
      );
    });
  }
}

class _CurrentEmailPage extends StatelessWidget {
  final Function() editEmailPress;
  final String email;
  const _CurrentEmailPage(
      {super.key, required this.email, required this.editEmailPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: AppTextFormField(
            isRequired: false,
            hintText: "Email",
            readOnly: true,
            initialValue: email,
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0.3,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
          child: GestureDetector(
            onTap: () {
              editEmailPress();
            },
            child: Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.color988,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "Cập nhật email",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _PhoneBodyPage extends StatefulWidget {
  final Function() isNextStep;
  final String phone;
  const _PhoneBodyPage({required this.isNextStep, required this.phone});

  @override
  State<_PhoneBodyPage> createState() => _PhoneBodyPageState();
}

class _PhoneBodyPageState extends State<_PhoneBodyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          const VSpacing(spacing: 12),
          Text(
            "Chúng tôi sẽ gửi mã xác nhận OTP đến số điện thoại của bạn.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.color723, fontWeight: FontWeight.w500),
          ),
          const VSpacing(spacing: 20),
          AppTextFormField(
            isRequired: true,
            hintText: "Số điện thoại",
            readOnly: true,
            initialValue: widget.phone,
            onChanged: (value) {},
          ),
          const VSpacing(spacing: 20),
          AppButton(
            text: "Tiếp tục",
            textColor: AppColors.white,
            onPressed: () {
              widget.isNextStep();
            },
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            isSafeArea: false,
            backgroundColor: AppColors.color988,
            isEnable: true,
          ),
          const VSpacing(spacing: 20),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                  color: AppColors.colorFFC,
                  borderRadius: BorderRadius.circular(8)),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text:
                          "Nếu bạn chưa có đăng ký số điện thoại, vui lòng liên hệ qua. Tổng đài GOO+ ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: "1900222",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.color844))
                ]),
              ))
        ],
      ),
    );
  }
}

class _OTPBodyPage extends StatelessWidget {
  final String phone;
  final EditProfileState state;
  const _OTPBodyPage({
    super.key,
    required this.phone,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: <Widget>[
          Text(
            "Mã xác thực OTP đã được gửi đến $phone của bạn",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.color723, fontWeight: FontWeight.w500),
          ),
          const VSpacing(spacing: 20),
          PinputWidget(
            timeOutPressed: () {
              context.read<EditProfileCubit>().submitPhoneToGetOTP(
                    phone,
                    isReSent: true,
                    phone: phone,
                  );
            },
            onDone: (value) {
              context.read<EditProfileCubit>().validateOtp(value);
            },
            timeOutListener: () {
              context.read<EditProfileCubit>().timeOutOtp();
            },
          ),
          AppButton(
            text: "Tiếp tục",
            textColor: state.isEnableContinue == true
                ? AppColors.white
                : AppColors.colorA4A,
            onPressed: () {
              if (state.isEnableContinue) {
                context.read<EditProfileCubit>().sentOtp(isPhone: true);
              }
            },
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            isSafeArea: false,
            backgroundColor: state.isEnableContinue == true
                ? AppColors.color988
                : AppColors.color8E8,
            isEnable: state.isEnableContinue == true,
          )
        ],
      ),
    );
  }
}

class _UpdateEmailBodyPage extends StatefulWidget {
  final Function(String) continuePressed;
  const _UpdateEmailBodyPage({super.key, required this.continuePressed});

  @override
  State<_UpdateEmailBodyPage> createState() => _UpdateEmailBodyPageState();
}

class _UpdateEmailBodyPageState extends State<_UpdateEmailBodyPage> {
  var isEnableContinue = false;
  late TextEditingController emailController;

  void emailValid(String email) {
    final isEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    setState(() {
      isEnableContinue = isEmail;
    });
  }

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          const VSpacing(spacing: 20),
          RegisterStoreFormField(
              controller: emailController,
              isRequired: true,
              onChanged: (value) {
                emailValid(value);
              },
              suffix: !emailController.text.isNullOrEmpty
                  ? IconButton(
                      onPressed: () {
                        emailController.clear();
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: AppColors.color2B3,
                        size: 18,
                      ))
                  : const SizedBox.shrink(),
              hintText: emailController.text.isNullOrEmpty
                  ? "Nhập email mới "
                  : "Email"),
          const VSpacing(spacing: 20),
          AppButton(
            text: "Tiếp tục",
            textColor: isEnableContinue ? AppColors.white : AppColors.colorA4A,
            onPressed: () {
              if (isEnableContinue) {
                widget.continuePressed(emailController.text);
              }
            },
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            isSafeArea: false,
            backgroundColor: isEnableContinue == true
                ? AppColors.color988
                : AppColors.color8E8,
            isEnable: isEnableContinue == true,
          )
        ],
      ),
    );
  }
}
