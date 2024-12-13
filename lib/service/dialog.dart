import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DialogService {
  DialogService();

  Future<void> showAlertDialog({
    BuildContext? context,
    required String title,
    required String description,
    required String buttonTitle,
  }) async {
    showCupertinoDialog(
        context: context ?? Get.context!,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(description),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(buttonTitle),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

final dialogService = DialogService();
