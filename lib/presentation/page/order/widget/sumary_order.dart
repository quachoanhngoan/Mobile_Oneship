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
              Text(
                'Chi tiết đơn',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.order?.orderItems?.length,
                itemBuilder: (context, index) {
                  final orderItem = state.order?.orderItems?[index];
                  return OrderItem(
                    orderItem: orderItem,
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
