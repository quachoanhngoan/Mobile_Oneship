import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/config.dart';

class AppTextFormField extends StatelessWidget {
  final bool isRequired;
  final TextEditingController? controller;
  final String? hintText;
  const AppTextFormField({
    super.key,
    required this.isRequired,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorHeight: 20,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 14,
          ),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: false,

        label: RichText(
          text: TextSpan(
            text: hintText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  color: AppColors.placeHolderColor,
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
