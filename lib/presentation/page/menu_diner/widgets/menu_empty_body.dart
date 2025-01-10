import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';

class MenuEmptyBody extends StatelessWidget {
  const MenuEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: context.width,
            child: const AspectRatio(
                aspectRatio: 390 / 390,
                child: ImageAssetWidget(image: AppAssets.imagesImgGrmenuEmpty)),
          ),
          const VSpacing(spacing: 16),
          Text("Quán của bạn chưa có món nào!",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.colorD33),
              textAlign: TextAlign.center),
          const VSpacing(spacing: 8),
          Text(
            "Bạn cần có danh mục để quán có thể phân loại theo nhóm món trên thực đơn !",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.textGray),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}