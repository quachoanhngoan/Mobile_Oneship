import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';

class DialogService {
  DialogService();

  Future<void> showAlertDialog({
    BuildContext? context,
    required String title,
    required String description,
    required String buttonTitle,
    required Function() onPressed,
    String? buttonCancelTitle,
    Function()? onCancel,
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
                child: Text(buttonTitle),
              ),
            ],
          );
        });
  }
}

final dialogService = DialogService();
