import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/page/order/bloc/order_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/price_value.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';

class OrderRevenue extends StatelessWidget {
  final OrderCubit? orderCubit;
  const OrderRevenue({super.key, this.orderCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: orderCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffF5F5F5),
          appBar: const AppBarAuth(
            title: 'Chi tiết doanh thu',
            isShowHelpButton: false,
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const DetailPrice(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        PriceValue(
                          title:
                              'Tổng giá món (${state.order?.orderItems?.length.toString() ?? '...'})',
                          price: state.order?.totalAmountFormat() ?? '0đ',
                          titleStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        PriceValue(
                          title: 'Phí vận chuyển',
                          price: state.order?.getShippingFeeFormat() ?? '0đ',
                          titleStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PriceValue(
                          title: 'Phí vận chuyển Người mua trả',
                          price: state.order?.getShippingFeeFormat() ?? '0đ',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PriceValue(
                          title: 'Phí vận chuyển thực tế',
                          price: state.order?.getShippingFeeFormat() ?? '0đ',
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      PriceValue(
                        title: 'Phí dịch vụ',
                        price: "...",
                        titleStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const PriceValue(
                        title: 'Phí thanh toán',
                        price: "...",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DetailPrice extends StatelessWidget {
  const DetailPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
        PriceValue(
          title: 'Số tiền thanh toán',
          price: '100.000đ',
          priceStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        PriceValue(
          title: 'Thanh toán bởi',
          price: '20.000đ',
        ),
        SizedBox(
          height: 10,
        ),
        PriceValue(
          title: 'Thanh toán vào lúc',
          price: '0đ',
        ),
        SizedBox(
          height: 10,
        ),
        PriceValue(
          title: 'Số tiền thanh toán',
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
          title: 'Khách thanh toán',
          price: '120.000đ',
          priceStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
