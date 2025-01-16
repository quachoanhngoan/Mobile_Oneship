import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/config.dart';

class AppTextFormFieldWorkTime extends StatelessWidget {
  final bool isRequired;
  final bool? filled;
  final TextEditingController? controller;
  final String? hintText;
  final bool? enabled;
  final String? initialValue;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  const AppTextFormFieldWorkTime({
    super.key,
    required this.isRequired,
    this.controller,
    this.hintText,
    this.filled,
    this.enabled,
    this.onTap,
    this.initialValue,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        onChanged: onChanged,
        cursorHeight: 20,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14.sp,
              color: AppColors.textColor,
            ),
        onTap: onTap,
        canRequestFocus: enabled == true,
        readOnly: enabled == false,
        // enabled: enabled,
        decoration: InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          isDense: false,
          filled: filled,
          suffixIcon: suffixIcon ??
              const Icon(
                Icons.expand_more,
                color: Color(0xffD0D5DD),
              ),

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
                color:
                    filled == true ? Colors.grey : AppColors.placeHolderColor,
              ),

          label: RichText(
            text: TextSpan(
              text: hintText,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14.sp,
                    color: filled == true ? Colors.grey : AppColors.color373,
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
      ),
    );
  }
}
