import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/page/order/bloc/order_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/order_item.dart';

class SumaryOrder extends StatelessWidget {
  final OrderCubit orderCubit;
  const SumaryOrder({
    super.key,
    required this.orderCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: orderCubit,
      builder: (context, state) {
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
              Row(
                children: [
                  Text(
                    'Chi tiết đơn (${state.order?.orderItems?.length ?? 0})',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Spacer(),
                  if (state.order?.getOrderStatus()?.isCancelled == true)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xffFEF4F1),
                        border: Border.all(
                          color: const Color(0xffBE5230),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Đã hủy',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffBE5230),
                            ),
                      ),
                    ),
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.order?.orderItems?.length,
                itemBuilder: (context, index) {
                  final orderItem = state.order?.orderItems?[index];
                  return OrderItem(
                    orderItem: orderItem,
                    description: orderItem?.getFullTextDescription() ?? "",
                    title: orderItem?.productName ?? "",
                    price: orderItem?.formattedPrice() ?? '',
                    quantity: orderItem?.quantity ?? 0,
                    orderAvatar: orderItem?.productImage ?? "",
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
