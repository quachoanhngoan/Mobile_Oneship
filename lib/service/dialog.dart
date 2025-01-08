import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

class DialogService {
  DialogService() {
    fToast = FToast();

    fToast.init(Get.overlayContext!);
  }
  late FToast fToast;
  Future<void> showAlertDialog({
    BuildContext? context,
    required String title,
    required String description,
    required String buttonTitle,
    required Function() onPressed,
    String? buttonCancelTitle,
    Function()? onCancel,
    Color? buttonColor,
  }) async {
    if (Get.isDialogOpen!) {
      return;
    }
    await showCupertinoDialog(
        context: context ?? Get.context!,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text(title,
                style: TextStyle(color: AppColors.textGray3, fontSize: 20.sp)),
            content: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textGray2,
                  )),
            ),
            actions: <Widget>[
              if (buttonCancelTitle != null && onCancel != null)
                CupertinoDialogAction(
                  isDefaultAction: false,
                  onPressed: onCancel,
                  child: Text(buttonCancelTitle,
                      style: const TextStyle(color: AppColors.textGray2)),
                ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: onPressed,
                child: Text(buttonTitle, style: TextStyle(color: buttonColor)),
              ),
            ],
          );
        });
  }

  showNotificationSuccess(String title) {
    fToast.showToast(
      toastDuration: const Duration(seconds: 2),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.primary,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ImageAssetWidget(
                  image: AppAssets.imagesIconsTeenyiconsTickCircleSolid,
                  width: 20,
                  height: 20),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      gravity: ToastGravity.CENTER,
    );
  }

  showNotificationError(String title) {
    fToast.showToast(
      toastDuration: const Duration(seconds: 2),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.error,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
      gravity: ToastGravity.CENTER,
    );
  }
}

final dialogService = DialogService();
