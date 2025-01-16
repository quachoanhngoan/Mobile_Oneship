import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/core/constant/constant.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/data/model/user/user_model.dart';
import 'package:oneship_merchant_app/presentation/page/account/cubit/edit_profile_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/account/cubit/edit_profile_state.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field.dart';

import '../../../../config/theme/color.dart';
import '../../../../core/helper/validate.dart';
import '../../../widget/appbar/appbar_common.dart';
import '../../../widget/button/app_button.dart';
import '../../register/widget/pinput_widget.dart';
import '../../register_store/widget/app_text_form_field.dart';

class PhoneEditProfile extends StatefulWidget {
  final UserM userData;

  const PhoneEditProfile({super.key, required this.userData});

  @override
  State<PhoneEditProfile> createState() => _PhoneEditProfileState();
}

class _PhoneEditProfileState extends State<PhoneEditProfile> {
  late PageController pageController;
  final TextEditingController pinController = TextEditingController();
  late final FocusNode _phoneNode;

  int indexPage = 0;
  var titleAppBar = "Số điện thoại";

  @override
  void initState() {
    pageController = PageController();
    _phoneNode = FocusNode();
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
          context.popScreen(result: state.phoneResponseSuccess);
        }
      }
      if (state.titleFailedDialog != null) {
        if (state.titleFailedDialog == AppErrorString.kOTPInvalid) {
          pinController.clear();
        }
        context.showErrorDialog(state.titleFailedDialog!, context);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBarAuth(
            title: titleAppBar,
            onPressed: () {
              // if (indexPage == 0) {
              context.popScreen();
              // } else {
              //   pageController.previousPage(
              //       duration: const Duration(milliseconds: 300),
              //       curve: Curves.easeInOut);
              // }
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
                      titleAppBar = "Cập nhật số điện thoại";
                      break;
                    case 2:
                      titleAppBar = "Nhập mã xác thực OTP";
                      break;
                    case 3:
                      titleAppBar = "Cập nhật số điện thoại";
                      break;
                    default:
                      titleAppBar = "Số điện thoại";
                      break;
                  }
                });
              },
              children: <Widget>[
                _CurrentPhonePage(
                  phone: widget.userData.phone ?? "",
                  editPhonePress: () {
                    if (widget.userData.email.isNotNullOrEmpty) {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    } else {
                      context.showErrorDialog(
                          "Bạn chưa cập nhật email", context);
                    }
                  },
                ),
                _EmailBodyPage(
                  email: widget.userData.email ?? "Chưa cập nhật",
                  isNextStep: () {
                    context.read<EditProfileCubit>().submitEmailToGetOTP();
                  },
                ),
                _OTPBodyPage(
                  state: state,
                  controller: pinController,
                  isNextButton: () {
                    context
                        .read<EditProfileCubit>()
                        .sentOtp(email: widget.userData.email, isPhone: false);
                  },
                  email: widget.userData.email ?? "",
                ),
                _UpdatePhoneBodyPage(
                  continuePressed: (value) {
                    context.read<EditProfileCubit>().sendPhoneUpdate(value);
                  },
                )
              ],
            ))
          ],
        ),
      );
    });
  }
}

class _CurrentPhonePage extends StatelessWidget {
  final String phone;
  final Function editPhonePress;

  const _CurrentPhonePage(
      {super.key, required this.phone, required this.editPhonePress});

  String formatPhone(String phone) {
    // if (phone.length < 10) {
    //   return phone;
    // }
    final phone2 = ValidateHelper.phoneFormat(phone);
    if (phone2 == "") {
      return "";
    }
    return '${phone2.substring(0, 3)} ${phone2.substring(3, 6)} ${phone2.substring(6, 9)} ${phone2.substring(9)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: AppTextFormField(
            isRequired: false,
            hintText: "Số điện thoại",
            readOnly: true,
            initialValue: formatPhone(phone),
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
              editPhonePress();
            },
            child: Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.color988,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "Cập nhật số điện thoại",
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

class _EmailBodyPage extends StatelessWidget {
  final String email;
  final Function() isNextStep;

  const _EmailBodyPage({required this.email, required this.isNextStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          const VSpacing(spacing: 12),
          Text(
            "Chúng tôi sẽ gửi mã xác nhận OTP đến email của bạn.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.color723, fontWeight: FontWeight.w500),
          ),
          const VSpacing(spacing: 20),
          AppTextFormField(
            isRequired: true,
            readOnly: true,
            hintText: "Email",
            initialValue: email,
            onChanged: (value) {},
          ),
          const VSpacing(spacing: 20),
          AppButton(
            text: "Tiếp tục",
            textColor: AppColors.white,
            onPressed: () {
              isNextStep();
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
                          "Nếu bạn chưa có đăng ký tài khoản Email, vui lòng liên hệ qua tổng đài GOO+ ",
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
  final Function isNextButton;
  final TextEditingController controller;
  final EditProfileState state;
  final String email;

  const _OTPBodyPage(
      {super.key,
      required this.email,
      required this.isNextButton,
      required this.state,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: <Widget>[
          Text(
            "Mã xác thực OTP đã được gửi đến $email của bạn",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.color723, fontWeight: FontWeight.w500),
          ),
          const VSpacing(spacing: 20),
          PinputWidget(
            controller: controller,
            timeOutPressed: () {
              context
                  .read<EditProfileCubit>()
                  .submitEmailToGetOTP(isResent: true);
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
                isNextButton();
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

class _UpdatePhoneBodyPage extends StatefulWidget {
  final Function(String) continuePressed;

  const _UpdatePhoneBodyPage({super.key, required this.continuePressed});

  @override
  State<_UpdatePhoneBodyPage> createState() => _UpdatePhoneBodyPageState();
}

class _UpdatePhoneBodyPageState extends State<_UpdatePhoneBodyPage> {
  late TextEditingController phoneController;

  var isEnableContinue = false;

  void validatePhone(String phone) {
    var isPhone = false;
    if (phone.isEmpty) {
      isPhone = false;
    }
    if (phone.length < 10) {
      isPhone = false;
    }
    if (phone.length > 10) {
      isPhone = false;
    }
    final bool phoneValid =
        RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone);
    isPhone = phoneValid;

    setState(() {
      isEnableContinue = isPhone;
    });
  }

  @override
  void initState() {
    phoneController = TextEditingController();
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
              controller: phoneController,
              isRequired: true,
              onChanged: (value) {
                validatePhone(value);
              },
              keyboardType: TextInputType.number,
              suffix: !phoneController.text.isNullOrEmpty
                  ? IconButton(
                      onPressed: () {
                        phoneController.clear();
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: AppColors.color2B3,
                        size: 18,
                      ))
                  : const SizedBox.shrink(),
              hintText: phoneController.text.isNullOrEmpty
                  ? "Nhập số điện thoại mới "
                  : "Số điện thoại"),
          const VSpacing(spacing: 20),
          AppButton(
            text: "Tiếp tục",
            textColor: isEnableContinue ? AppColors.white : AppColors.colorA4A,
            onPressed: () {
              if (isEnableContinue) {
                widget.continuePressed(phoneController.text);
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
