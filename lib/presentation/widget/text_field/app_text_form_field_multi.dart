import 'package:flutter/material.dart';

import '../../../config/theme/color.dart';

class AppTextFormFieldMulti extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  const AppTextFormFieldMulti({super.key, this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 5,
      maxLines: 5,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 14,
            color: AppColors.textColor,
          ),
      decoration: InputDecoration(
          hintText: hintText ?? "Nhập mô trả",
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.color1C1,
              ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(8)))),
    );
  }
}
