import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/config.dart';

class TextFieldBase extends StatelessWidget {
  final String? label;
  final String hintText;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final String? errorText;
  final bool? onBorder;
  final double? height;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  const TextFieldBase(
      {super.key,
      this.label,
      this.controller,
      required this.hintText,
      this.suffix,
      this.onChanged,
      this.obscureText = false,
      this.errorText,
      this.prefix,
      this.onBorder = true,
      this.height,
      this.focusNode,
      this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null) ...[
          Padding(
            padding: EdgeInsets.only(bottom: 5.sp),
            child:
                Text(label!, style: Theme.of(context).textTheme.headlineMedium),
          ),
        ],
        SizedBox(
          height: height,
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText!,
            textAlignVertical: TextAlignVertical.center,
            onEditingComplete: () {
              focusNode?.unfocus();
              onEditingComplete?.call();
            },
            cursorColor: AppColors.black,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  color: AppColors.color2B3,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
              suffixIcon: suffix,
              prefixIcon: prefix,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              focusedBorder: _border(onBorder: onBorder),
              enabledBorder: _border(onBorder: onBorder),
              border: _border(onBorder: onBorder),
              errorText: errorText,
            ),
            onChanged: onChanged,
          ),
        )
      ],
    );
  }

  InputBorder _border({bool? onBorder}) {
    return const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.color5DD, width: 1.5));
    // return OutlineInputBorder(
    //     borderSide: BorderSide(
    //         color: onBorder == true
    //             ? AppColors.colorF1F.withOpacity(0.5)
    //             : AppColors.white,
    //         width: 1),
    //     borderRadius: BorderRadius.circular(4));
  }
}
