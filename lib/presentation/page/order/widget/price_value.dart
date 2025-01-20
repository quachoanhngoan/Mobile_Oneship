import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';

class PriceValue extends StatelessWidget {
  final String title;
  final String price;
  final TextStyle? priceStyle;
  const PriceValue({
    super.key,
    required this.title,
    required this.price,
    this.priceStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
