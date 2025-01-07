import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio2;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

class FormUploadImage extends StatefulWidget {
  final ValueChanged<String> onUploadedImage;
  final String title;
  final double? height;
  final String? initialImage;
  const FormUploadImage(
      {super.key,
      required this.onUploadedImage,
      required this.title,
      this.height,
      this.initialImage});

  @override
  State<FormUploadImage> createState() => _FormUploadImageState();
}

class _FormUploadImageState extends State<FormUploadImage> {
  var isLoading = false;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _mediaFileList;
  String image = '';
  @override
  void initState() {
    super.initState();
    image = widget.initialImage ?? '';
  }

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  Future<String> uploadFileHTTP(
      String preSignedUrl, XFile pathFile, String contentType) async {
    final dio = injector<dio2.Dio>();
    final apiToken = prefManager.token;
    // dio2.FormData formData = dio2.FormData.fromMap({
    //   'file': await dio2.MultipartFile.fromFile(
    //     pathFile.path,
    //     filename: pathFile.path.split('/').last,
    //     contentType: dio2.DioMediaType('image', 'jpeg'),
    //   ),
    // });
    dio2.FormData formData = dio2.FormData.fromMap({
      'file': await dio2.MultipartFile.fromFile(
        pathFile.path,
        filename: '${pathFile.path.split('/').last}.jpg',
        contentType: dio2.DioMediaType('image', 'jpeg'),
      ),
    });
    dio.options.connectTimeout = const Duration(minutes: 1);
    dio.options.receiveTimeout = const Duration(minutes: 1);
    final response = await dio.post(
      preSignedUrl,
      data: formData,
      options: dio2.Options(
        headers: {
          'accept': '*/*',
          'Content-Type': 'multipart/form-data',
          "Authorization": "Bearer $apiToken",
          // HttpHeaders.contentLengthHeader: await pathFile.length(),
          // HttpHeaders.contentTypeHeader:
          //     contentType, // or the type of your file
        },
      ),
    );

    if ([200, 201, 202].contains(response.statusCode)) {
      return UploadResponse.fromJson(response.data).data?.id ?? '';
    }
    return '';
  }

  void uploadFile() async {
    if (_mediaFileList != null && _mediaFileList!.isNotEmpty) {
      try {
        isLoading = true;
        setState(() {});
        if (_mediaFileList!.isEmpty) {
          throw Exception('Chưa chọn ảnh');
        }
        final file = File(_mediaFileList!.first.path);

        int sizeInBytes = file.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 1) {
          throw Exception('Dung lượng ảnh không được lớn hơn 5MB');
        }
        final url = '${EnvManager.shared.api}/api/v1/uploads';
        final httpResponse = await uploadFileHTTP(
          url,
          _mediaFileList!.first,
          'image/jpeg',
        );
        image = httpResponse;
        print('httpResponse: $httpResponse');
        widget.onUploadedImage(httpResponse);
      } catch (e) {
        dialogService.showAlertDialog(
            title: "Lỗi",
            description: e.toString(),
            buttonTitle: "Đóng",
            onPressed: () {
              Get.back();
            });
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
          final XFile? pickedFile = await _picker.pickImage(
              source: ImageSource.gallery, imageQuality: 70);
          _setImageFileListFromFile(pickedFile);
          uploadFile();
        } catch (e) {
          print(e);
        }
        setState(() {});
      },
      child: isLoading
          ? SizedBox(
              width: Get.width,
              height: widget.height ?? 100.sp,
              child: const CupertinoActivityIndicator(
                color: AppColors.primary,
              ),
            )
          : image.isNotEmpty
              ? SizedBox(
                  height: widget.height ?? 100.sp,
                  width: Get.width,
                  child: NetworkImageWithLoader(
                    image,
                    isBaseUrl: true,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: widget.height ?? 100.sp,
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

class UploadResponse {
  ImageResponse? data;
  String? message;
  int? statusCode;

  UploadResponse({this.data, this.message, this.statusCode});

  UploadResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new ImageResponse.fromJson(json['data']) : null;
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}

class ImageResponse {
  String? name;
  int? size;
  String? mimetype;
  String? path;
  String? id;

  ImageResponse({
    this.name,
    this.size,
    this.mimetype,
    this.path,
    this.id,
  });

  ImageResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    size = json['size'];
    mimetype = json['mimetype'];
    path = json['path'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['size'] = size;
    data['mimetype'] = mimetype;
    data['path'] = path;
    data['id'] = id;
    return data;
  }
}
