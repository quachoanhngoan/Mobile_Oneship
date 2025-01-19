import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_page.dart';

class CartBodyNew extends StatelessWidget {
  const CartBodyNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorAFA,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: CartBodyItem(
                bottomWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Nhận đơn để bắt đầu tìm tài xế",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                          color: AppColors.color988,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Nhận đơn",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
    );
  }
}
