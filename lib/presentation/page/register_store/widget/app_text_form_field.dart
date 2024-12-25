import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';

class AppTextFormField extends StatelessWidget {
  final bool isRequired;
  final bool? filled;
  final TextEditingController? controller;
  final String? hintText;
  final bool? enabled;
  final String? initialValue;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  const AppTextFormField({
    super.key,
    required this.isRequired,
    this.controller,
    this.hintText,
    this.filled,
    this.enabled,
    this.onTap,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      cursorHeight: 20,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 14.sp,
            color: AppColors.textColor,
          ),
      onTap: onTap,
      enabled: enabled,
      autocorrect: false,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: false,
        filled: filled,
        fillColor: const Color(0xffF9FAFB),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        floatingLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14.sp,
              color: filled == true ? Colors.grey : AppColors.placeHolderColor,
            ),
        label: RichText(
          text: TextSpan(
            text: hintText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14.sp,
                  color:
                      filled == true ? Colors.grey : AppColors.placeHolderColor,
                ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
        // hintText: 'Nhập họ và tên người đại diện',
      ),
    );
  }
}
