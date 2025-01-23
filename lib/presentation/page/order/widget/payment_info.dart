import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/page/order/bloc/order_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/detail_price.dart';
import 'package:oneship_merchant_app/presentation/page/order/order_page.dart';

class PaymentInfo extends StatelessWidget {
  final OrderCubit orderCubit;
  const PaymentInfo({
    super.key,
    required this.orderCubit,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Flexible(
                child: ExpandablePanel(
                  header: Text(
                    'Chi tiết thanh toán',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  expanded: const SizedBox(),
                  collapsed: DetailPrice(
                    orderCubit: orderCubit,
                  ),
                  theme: const ExpandableThemeData(
                    iconPadding: EdgeInsets.all(0),
                    iconColor: Color(0xff131A29),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
