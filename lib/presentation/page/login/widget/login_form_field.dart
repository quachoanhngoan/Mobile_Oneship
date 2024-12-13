import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

class LoginFormField extends StatelessWidget {
  final String hintText;
  final String prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  const LoginFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.suffixIcon,
    required this.obscureText,
    this.focusNode,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      controller: controller,
      obscuringCharacter: "*",
      obscureText: obscureText,
      autocorrect: false,
      style: TextStyle(
        color: AppColors.textColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: const BorderSide(
          //     color: AppColors.error,
          //     width: 1,
          //   ),
          // ),
          // errorBorder:  OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: const BorderSide(
          //     color: AppColors.error,
          //     width: 1,
          //   ),
          // ),
          hintText: hintText,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 20,
            minHeight: 20,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ImageAssetWidget(
              image: prefixIcon,
              width: 20,
              height: 20,
              // color: AppColors.primary,
            ),
          )),
    );
  }
}
