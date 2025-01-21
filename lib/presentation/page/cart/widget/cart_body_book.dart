import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_page.dart';

class CartBodyBook extends StatelessWidget {
  const CartBodyBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorAFA,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  VSpacing(spacing: index == 0 ? 12 : 0),
                  Text(
                    "Hôm nay",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.color194,
                        fontSize: 14),
                  ),
                  const VSpacing(spacing: 12),
                  ...List.generate(3, (indexCard) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CartBodyItem(
                        bottomWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Nhận đơn khi đến giờ hẹn với khách",
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
                              width: 86,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.color6F6,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Nhận đơn",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textGray,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
    );
  }
}
