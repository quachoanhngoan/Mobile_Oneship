import 'dart:io';

import 'package:dio/dio.dart' as dio2;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneship_merchant_app/app.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/utils.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';
import 'package:oneship_merchant_app/service/pref_manager.dart';

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

  Future<String> uploadFileHTTP(
      String preSignedUrl, XFile pathFile, String contentType) async {
    final dio = injector<dio2.Dio>();
    dio.options.headers['Content-Type'] = "multipart/form-data";
    final apiToken = prefManager.token;
    dio2.FormData formData = dio2.FormData.fromMap({
      'file': await dio2.MultipartFile.fromFile(
        pathFile.path,
        filename: pathFile.path.split('/').last,
        // contentType: MediaType('image', 'jpeg'),
      ),
      "type": "image/jpeg"
    });

    final response = await dio.post(
      preSignedUrl,
      data: formData,
      options: dio2.Options(
        headers: {
          "Authorization": "Bearer $apiToken",
          HttpHeaders.contentLengthHeader: await pathFile.length(),
          // HttpHeaders.contentTypeHeader:
          //     contentType, // or the type of your file
        },
      ),
    );
    print(response.data);
    print(response.statusCode);
    if ([200, 201, 202].contains(response.statusCode)) {
      return response.data['url'];
    }
    return '';
  }

  void uploadFile() async {
    if (_mediaFileList != null && _mediaFileList!.isNotEmpty) {
      try {
        isLoading = true;
        setState(() {});
        print('uploadFile');
        final url = '${EnvManager.shared.api}/api/v1/uploads';
        final httpResponse = await uploadFileHTTP(
          url,
          _mediaFileList!.first,
          'image/jpeg',
        );
        widget.onUploadedImage(httpResponse);
      } catch (e) {
        print(e);
      } finally {
        isLoading = false;
        setState(() {});
      }
    }
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
          uploadFile();
        } catch (e) {
          print(e);
        }
        setState(() {});
      },
      child: isLoading
          ? SizedBox(
              width: 48,
              height: 100.sp,
              child: const CupertinoActivityIndicator(
                color: AppColors.primary,
              ),
            )
          : _mediaFileList != null && _mediaFileList!.isNotEmpty
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
