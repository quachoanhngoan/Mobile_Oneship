import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DialogService {
  DialogService();

  Future<void> showAlertDialog({
    BuildContext? context,
    required String title,
    required String description,
    required String buttonTitle,
    required Function() onPressed,
  }) async {
    if (Get.isDialogOpen!) {
      return;
    }
    await showCupertinoDialog(
        context: context ?? Get.context!,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(description),
            actions: <Widget>[
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
