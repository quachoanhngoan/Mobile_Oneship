import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneship_merchant_app/app.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

class FormUploadImage extends StatefulWidget {
  final ValueChanged<String> onUploadedImage;
  final String title;
  const FormUploadImage(
      {super.key, required this.onUploadedImage, required this.title});

  @override
  State<FormUploadImage> createState() => _FormUploadImageState();
}

class _FormUploadImageState extends State<FormUploadImage> {
  var isLoading = false;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _mediaFileList;
  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          final XFile? pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);
          setState(() {
            _setImageFileListFromFile(pickedFile);
          });
        } catch (e) {}
        setState(() {});
      },
      child: _mediaFileList != null && _mediaFileList!.isNotEmpty
          ? Container(
              height: 100.sp,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(_mediaFileList!.first.path)),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              height: 100.sp,
              padding: const EdgeInsets.all(12),
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.borderColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    if (isLoading) {
                      return const SizedBox(
                        width: 48,
                        height: 48,
                        child: CupertinoActivityIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                    return const ImageAssetWidget(
                      image: AppAssets.imagesIconsCamera,
                      width: 48,
                      height: 48,
                    );
                  }),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
