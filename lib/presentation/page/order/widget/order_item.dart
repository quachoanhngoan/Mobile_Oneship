import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

class OrderItem extends StatelessWidget {
  final String title;
  final String price;
  final String? description;
  final String? note;

  const OrderItem({
    super.key,
    required this.title,
    this.description,
    required this.price,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor2,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NetworkImageWithLoader(
            'https://hips.hearstapps.com/hmg-prod/images/roast-chicken-recipe-2-66b231ac9a8fb.jpg?crop=0.503xw:1.00xh;0.309xw,0&resize=1200:*',
            isBaseUrl: false,
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 40,
            child: Center(
              child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.borderColor2,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'x2',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          title,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                    Text(
                      price,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
                if (description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      description!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.color373,
                          ),
                    ),
                  ),
                if (note != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: [
                        const ImageAssetWidget(
                            image: AppAssets.imagesIconsNotesEdit01, width: 20),
                        const SizedBox(width: 5),
                        Text(
                          note!,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.color373,
                                  ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
