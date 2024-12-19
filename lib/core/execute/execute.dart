import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

import '../resources/result.dart';

Future<Result<T>> execute<T>(
  Future<T> Function() function, {
  String tag = '',
  bool isShowFailDialog = false,
  // required Function(T) onSuccess,
}) async {
  try {
    final result = await function();

    return Success(result);
  } catch (e, stackTrace) {
    log('$tag execute: ${e.toString()}', error: e, stackTrace: stackTrace);
    if (e is DioException) {
      // print('DioException: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        if (Get.currentRoute == AppRoutes.loginPage) {
          dialogService.showAlertDialog(
            title: "Lỗi",
            description: "Tài khoản hoặc mật khẩu không chính xác!",
            buttonTitle: "OK",
            onPressed: () => Get.back(),
          );
          return Failure(e.message ?? "Đã có lỗi xảy ra");
        }
        // if (isShowFailDialog) {
        dialogService.showAlertDialog(
          title: "Lỗi",
          description: "Phiên đăng nhập hết hạn",
          buttonTitle: "OK",
          onPressed: () => Get.offAllNamed(AppRoutes.onBoardingPage),
        );
        return Failure(e.message ?? "Đã có lỗi xảy ra");
        // }
      }
      if (isShowFailDialog) {
        dialogService.showAlertDialog(
          title: "Lỗi",
          description: e.response?.data['message'] ?? "Đã có lỗi xảy ra",
          buttonTitle: "OK",
          onPressed: () => Get.back(),
        );
        return Failure(e.message ?? "Đã có lỗi xảy ra");
      }

      return Failure(e.message ?? "Đã có lỗi xảy ra");
    }
    return Failure(e.toString());
  }
}
//execute v2
