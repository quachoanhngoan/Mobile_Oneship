import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_page.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';

import '../cart_cubit.dart';
import '../cart_state.dart';

class CartBodyNew extends StatelessWidget {
  final CartState state;
  final CartCubit bloc;

  const CartBodyNew({
    super.key,
    required this.state,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
      final listItemSearch = state.listSearchCartNew;
      if (listItemSearch.isNotEmpty) {
        return _BodyNew(
          refreshFunction: () {
            bloc.getAllCart();
          },
          listItem: listItemSearch,
          listShowDetailFood: state.listSearchShowDetailFood,
          moreFoodClick: (id) {
            bloc.hireOrShowDetailFoodSearch(
                value: ShowDetailFoodCartDomain(
              type: CartType.newCart,
              idShow: id,
            ));
          },
        );
      }
      return Container();
    }

    final listItem = state.listCartNew;

    if (listItem.isEmpty) {
      return const CartEmptyBody();
    }
    return _BodyNew(
      refreshFunction: () {
        bloc.getAllCart();
      },
      listItem: listItem,
      listShowDetailFood: state.listShowDetailFood,
      moreFoodClick: (id) {
        bloc.hireOrShowDetailFood(
            value: ShowDetailFoodCartDomain(
          type: CartType.newCart,
          idShow: id,
        ));
      },
    );
  }
}

class _BodyNew extends StatelessWidget {
  final List<OrderCartResponse> listItem;
  final List<ShowDetailFoodCartDomain> listShowDetailFood;
  final Function(int?) moreFoodClick;
  final Function() refreshFunction;
  const _BodyNew({
    super.key,
    required this.listItem,
    this.listShowDetailFood = const [],
    required this.moreFoodClick,
    required this.refreshFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorAFA,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListView.builder(
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            final isShowMore = listShowDetailFood.contains(
                ShowDetailFoodCartDomain(
                    type: CartType.newCart, idShow: listItem[index].id));
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: CartBodyItem(
                onTap: refreshFunction,
                isShowMore: isShowMore,
                moreFoodClick: () {
                  moreFoodClick(listItem[index].id);
                },
                indexCart: index,
                orderCart: listItem[index],
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
