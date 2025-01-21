import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_page.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

class CartBodyComplete extends StatelessWidget {
  const CartBodyComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorAFA,
      child: Column(
        children: <Widget>[
          const VSpacing(spacing: 12),
          Card(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            color: AppColors.white,
            borderOnForeground: false,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "24/12/25 - 28/12/25",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.color828,
                        ),
                  ),
                  const ImageAssetWidget(
                    image: AppAssets.imagesIconsIcCalendar,
                    width: 16,
                    height: 16,
                  )
                ],
              ),
            ),
          ),
          const VSpacing(spacing: 6),
          Expanded(
            child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                separatorBuilder: (context, index) =>
                    const VSpacing(spacing: 12),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "24/12/2024",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.color723,
                            fontSize: 14),
                      ),
                      const VSpacing(spacing: 12),
                      ...List.generate(3, (indexCard) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CartBodyItem(
                            isComplete: true,
                            bottomWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Tài xế xác nhận lấy đơn lúc 13:30",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.color017,
                                      ),
                                ),
                                Container(
                                  height: 26,
                                  width: 114,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.color988,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "Chi tiết doanh thu",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.white,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                      // const VSpacing(spacing: 12),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
