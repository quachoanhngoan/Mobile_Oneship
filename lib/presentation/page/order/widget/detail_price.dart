import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/page/order/bloc/order_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/order/order_page.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/price_value.dart';

class DetailPrice extends StatelessWidget {
  final OrderCubit? orderCubit;
  const DetailPrice({
    super.key,
    this.orderCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: orderCubit,
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            PriceValue(
              title: 'Tạm tính (4 phần)',
              price: state.order?.totalAmountFormat() ?? '0đ',
              priceStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PriceValue(
              title: 'Phí giao hàng',
              price: state.order?.getShippingFeeFormat() ?? '0đ',
            ),
            const SizedBox(
              height: 10,
            ),
            const PriceValue(
              title: 'Giảm giá',
              price: '...',
            ),
            const SizedBox(
              height: 10,
            ),
            const PriceValue(
              title: 'Phí dịch vụ',
              price: '...',
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: AppColors.borderColor2,
              thickness: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            PriceValue(
              title: 'Khách thanh toán',
              price: state.order?.totalAmountFormat() ?? '0đ',
              priceStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}
