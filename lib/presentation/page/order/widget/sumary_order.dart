import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/order_item.dart';
import 'package:oneship_merchant_app/presentation/page/order/order_page.dart';

class SumaryOrder extends StatelessWidget {
  const SumaryOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderColor2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chi tiết đơn',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 10),
          const OrderItem(
            title: 'Combo Bạc xỉu kem muối hồng - topping đầy đủ',
            description: 'Đá xay nhuyễn, topping đầy đủ',
            price: '220.000đ',
            note: ' Không đường',
          ),
          const SizedBox(height: 10),
          const OrderItem(
            title: 'Combo Bạc xỉu kem muối hồng - topping đầy đủ',
            description:
                'Phân loại 1, 50% đường, 75% đá, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            price: '220.000đ',
            note: ' Không đường',
          ),
        ],
      ),
    );
  }
}
