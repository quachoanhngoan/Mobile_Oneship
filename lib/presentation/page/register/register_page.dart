import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/presentation/page/widget/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/text_field_base.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

import '../../../config/theme/color.dart';
import '../../../core/constant/app_assets.dart';
import '../../../core/constant/dimensions.dart';
import 'widget/pinput_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _phoneController;
  late final PageController _pageController;
  late final FocusNode _focusNode;

  bool _isHighlight = false;
  int indexPage = 0;
  late String title;

  @override
  void initState() {
    title = "Nhập SĐT/Email";
    _pageController = PageController();
    _phoneController = TextEditingController();
    _focusNode = FocusNode();
    _phoneController.addListener(() {
      setState(() {
        _isHighlight = _phoneController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarAuth(
        title: title,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
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
              height: 130.h,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    indexPage = value;
                    _isHighlight = false;
                    switch (indexPage) {
                      case 1:
                        title = "Xác thực OTP";
                        break;
                      case 2:
                        title = "Tạo mật khẩu mới";
                        break;
                      default:
                        title = "Nhập SĐT/Email";
                        break;
                    }
                  });
                },
                children: [
                  PhoneRegister(
                      focusNode: _focusNode,
                      isForcus: _isHighlight,
                      phoneController: _phoneController),
                  OtpRegister(
                    phone: _phoneController.text,
                    onDone: (value) {
                      setState(() {
                        _isHighlight = true;
                      });
                    },
                  )
                ],
              ),
            ),
            AppButton(
              text: "Tiếp tục",
              textColor: _isHighlight ? AppColors.white : AppColors.colorA4A,
              onPressed: () {
                if (_isHighlight) {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              isSafeArea: false,
              isEnable: _isHighlight,
              backgroundColor: AppColors.color988,
            ),
            const VSpacing(spacing: 20),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Chưa có tài khoản? ",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.colorC5C),
              ),
              TextSpan(
                  text: "Đăng ký",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.color988,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.color988))
            ]))
          ],
        ),
      ),
    );
  }
}

class PhoneRegister extends StatelessWidget {
  final TextEditingController phoneController;
  final bool isForcus;
  final FocusNode focusNode;
  const PhoneRegister(
      {super.key,
      required this.phoneController,
      required this.focusNode,
      required this.isForcus});

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
                    phoneController.clear();
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
  final String phone;
  const OtpRegister({super.key, required this.phone, required this.onDone});

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
          onDone: onDone,
        )
      ],
    );
  }
}

class CreatePasswordRegister extends StatelessWidget {
  final TextEditingController 
  const CreatePasswordRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Mật khẩu phải có độ dài từ 8-16 ký tự, bao gồm ít nhất một chữ in hoa, một chữ in thường và chỉ chứa các chữ cái, số hoặc các ký tự thông thường.",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.color723, fontWeight: FontWeight.w500),
        ),
        TextFieldBase(
          focusNode: focusNode,
          controller: phoneController,
          hintText: "Nhập SĐT hoặc email",
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
                    phoneController.clear();
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
