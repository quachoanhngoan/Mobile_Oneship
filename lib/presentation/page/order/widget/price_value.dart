import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';

class PriceValue extends StatelessWidget {
  final String title;
  final String price;
  final TextStyle? priceStyle;
  final TextStyle? titleStyle;
  const PriceValue({
    super.key,
    required this.title,
    required this.price,
    this.priceStyle,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ??
              Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    color: AppColors.color373,
                    fontWeight: FontWeight.w400,
                  ),
        ),
        Text(
          price,
          style: priceStyle ??
              Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
        ),
      ],
    );
  }
}
