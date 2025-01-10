import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/config.dart';

class EditAddressFormField extends StatelessWidget {
  final bool isRequired;
  final bool? filled;
  final TextEditingController? controller;
  final String? hintText;
  final bool? enabled;
  final String? initialValue;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  const EditAddressFormField(
      {super.key,
      required this.isRequired,
      this.controller,
      this.hintText,
      this.filled,
      this.enabled,
      this.onTap,
      this.initialValue,
      this.suffix,
      this.onChanged,
      this.keyboardType,
      this.inputFormatters,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        onChanged: onChanged,
        cursorHeight: 16,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
        onTap: onTap,
        enabled: enabled,
        autocorrect: false,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          suffixIcon: suffix,
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          isDense: false,
          errorText: errorText == "" ? null : errorText,
          filled: filled,
          fillColor: const Color(0xffF9FAFB),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.color373,
              ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          floatingLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.color373,
              ),
          label: RichText(
            text: TextSpan(
              text: hintText,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.color373,
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
