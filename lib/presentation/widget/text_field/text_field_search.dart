import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

import '../../../config/theme/color.dart';

class TextFieldSearch extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Color? colorPrefixIcon;
  final Function clearTextClicked;
  final Function(String) onChange;
  final bool showClearButton;
  final FocusNode? focusNode;
  const TextFieldSearch(
      {super.key,
      this.controller,
      this.hintText,
      this.colorPrefixIcon,
      required this.clearTextClicked,
      required this.onChange,
      required this.showClearButton,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) {
          onChange(value);
        },
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
        autofocus: false,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.color2B3,
                ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ImageAssetWidget(
                image: AppAssets.imagesIconsIcSearch,
                color: colorPrefixIcon ?? AppColors.color2B3,
              ),
            ),
            suffixIcon: showClearButton
                ? IconButton(
                    onPressed: () {
                      clearTextClicked();
                    },
                    icon: const Icon(Icons.clear_outlined,
                        size: 16, color: AppColors.color988))
                : const SizedBox.shrink(),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(8)))),
      ),
    );
  }
}
