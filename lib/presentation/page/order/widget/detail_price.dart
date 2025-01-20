import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/page/order/order_page.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/price_value.dart';

class DetailPrice extends StatelessWidget {
  const DetailPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        PriceValue(
          title: 'Tạm tính (4 phần)',
          price: '100.000đ',
          priceStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        PriceValue(
          title: 'Phí giao hàng',
          price: '20.000đ',
        ),
        SizedBox(
          height: 10,
        ),
        PriceValue(
          title: 'Giảm giá',
          price: '0đ',
        ),
        SizedBox(
          height: 10,
        ),
        PriceValue(
          title: 'Phí dịch vụ',
          price: '120.000đ',
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: AppColors.borderColor2,
          thickness: 1,
        ),
        SizedBox(
          height: 5,
        ),
        PriceValue(
          title: 'Tổng thanh toán',
          price: '120.000đ',
          priceStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
