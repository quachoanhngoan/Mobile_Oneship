import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';

bool isShowingSnackBar = false;

extension ScreenSize on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}

extension Router on BuildContext {
  pushWithNamed(BuildContext context,
      {required String routerName,
      Object? arguments,
      Function(Object?)? complete,
      bool? unfocusKeyboard = false}) {
    if (unfocusKeyboard == true) {
      FocusScope.of(context).unfocus();
    }
    Get.toNamed(routerName, arguments: arguments)?.then((value) {
      if (complete != null) {
        complete(value);
      }
    });
  }

  popScreen() {
    Get.back();
  }
}

extension ShowModalSheet on BuildContext {
  void showToastDialog(String value) {
    Fluttertoast.showToast(msg: value, gravity: ToastGravity.BOTTOM);
  }

  Future<dynamic> showDialogWidget(BuildContext context,
      {required Widget child,
      bool? barrierDismissible = false,
      Color? barrierColor = Colors.black54}) async {
    return showDialog(
        barrierDismissible: barrierDismissible ?? false,
        barrierColor: barrierColor,
        context: context,
        builder: (context) {
          return PopScope(canPop: false, child: child);
        });
  }

  Future<dynamic> showLoading(
    BuildContext context,
  ) async {
    showDialogWidget(context,
        child: Dialog(
          elevation: 0,
          backgroundColor: AppColors.transparent,
          child: Center(
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(AppDimensions.paddingSmall),
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        ));
  }
}
