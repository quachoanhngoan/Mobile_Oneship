import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';

class IconItemOrder extends StatelessWidget {
  final String image;
  final String imageCheck;
  final String? imageCancel;
  final bool isCheck;
  final bool isCancelled;
  final String time;
  const IconItemOrder({
    super.key,
    this.image = AppAssets.imagesIconsUserOrder,
    this.imageCheck = AppAssets.imagesIconsCheckIcon,
    this.imageCancel,
    this.isCheck = false,
    this.isCancelled = false,
    this.time = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Builder(builder: (context) {
                if (isCancelled && isCheck == false) {
                  return ImageAssetWidget(
                    image: imageCancel ?? "",
                    width: 35,
                  );
                }
                return ImageAssetWidget(
                  image: isCheck ? imageCheck : image,
                  width: 35,
                );
              }),
            ),
            if (isCheck)
              Positioned(
                right: 0,
                bottom: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ImageAssetWidget(
                      image: AppAssets.imagesIconsCheckIcon,
                      width: isCheck ? 16 : 0),
                ),
              ),
          ],
        ),
        if (isCheck)
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  color: isCheck == false ? AppColors.color194 : null,
                ),
          ),
      ],
    );
  }
}
