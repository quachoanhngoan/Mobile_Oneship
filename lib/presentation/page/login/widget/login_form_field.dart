import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

class LoginFormField extends StatelessWidget {
  final String hintText;
  final String prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;

  const LoginFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.suffixIcon,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      autocorrect: false,
      decoration: InputDecoration(
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
