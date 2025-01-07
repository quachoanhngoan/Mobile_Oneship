import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

class ChangeStoreButton extends StatelessWidget {
  const ChangeStoreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dialogService.showAlertDialog(
            title: "Thay đổi quán",
            description: "Bạn có muốn thay đổi quán khác không ?",
            buttonTitle: "Xác nhận",
            buttonCancelTitle: "Hủy",
            onCancel: () => Get.back(),
            onPressed: () {
              Get.offAllNamed(AppRoutes.store);
            });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Text(
              "Đổi quán",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            ImageAssetWidget(
              image: AppAssets.imagesIconsIcnReload,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
