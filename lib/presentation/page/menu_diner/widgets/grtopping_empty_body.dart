import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';

class ToppingEmptyBody extends StatelessWidget {
  const ToppingEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: context.height / 2.5,
          child: const AspectRatio(
              aspectRatio: 207 / 316,
              child: ImageAssetWidget(image: AppAssets.imagesImgGrtopingEmpty)),
        ),
        Text("Quán của bạn chưa có nhóm topping nào!",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600, color: AppColors.colorD33),
            textAlign: TextAlign.center),
        const VSpacing(spacing: 8),
        Text(
          "Bạn cần tạo nhóm topping để khách hàng có thêm nhiều lựa chọn.",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500, color: AppColors.textGray),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}