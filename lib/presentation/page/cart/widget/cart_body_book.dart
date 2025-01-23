import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_page.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';

import '../cart_cubit.dart';
import '../cart_state.dart';

class CartBodyBook extends StatelessWidget {
  final CartState state;
  final CartCubit bloc;

  const CartBodyBook({
    super.key,
    required this.state,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
      final listItemSearch = state.listSearchCartBook.entries.toList();
      if (listItemSearch.isNotEmpty) {
        return _BodyBook(
          listItem: listItemSearch,
          listShowDetailFood: state.listSearchShowDetailFood,
          moreFoodClick: (id) {
            bloc.hireOrShowDetailFoodSearch(
                value: ShowDetailFoodCartDomain(
              type: CartType.book,
              idShow: id,
            ));
          },
        );
      }
      return Container();
    }
    final listItem = state.listCartBook.entries.toList();

    if (listItem.isEmpty) {
      return const CartEmptyBody();
    }
    return _BodyBook(
      listItem: listItem,
      listShowDetailFood: state.listShowDetailFood,
      moreFoodClick: (id) {
        bloc.hireOrShowDetailFood(
            value: ShowDetailFoodCartDomain(
          type: CartType.book,
          idShow: id,
        ));
      },
    );
  }
}

class _BodyBook extends StatelessWidget {
  final List<MapEntry<String?, List<OrderCartResponse>>> listItem;
  final List<ShowDetailFoodCartDomain> listShowDetailFood;
  final Function(int?) moreFoodClick;
  const _BodyBook({
    required this.listItem,
    this.listShowDetailFood = const [],
    required this.moreFoodClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorAFA,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  VSpacing(spacing: index == 0 ? 12 : 0),
                  Text(
                    listItem[index].key ?? "",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.color194,
                        fontSize: 14),
                  ),
                  const VSpacing(spacing: 12),
                  ...List.generate(listItem[index].value.length, (indexCard) {
                    final item = listItem[index].value[indexCard];
                    final isShowMore = listShowDetailFood.contains(
                        ShowDetailFoodCartDomain(
                            type: CartType.book, idShow: item.id));

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CartBodyItem(
                        isShowMore: isShowMore,
                        moreFoodClick: () {
                          moreFoodClick(item.id);
                        },
                        indexCart: indexCard,
                        orderCart: item,
                        bottomWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Nhận đơn khi đến giờ hẹn với khách",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
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
                                  color: AppColors.color6F6,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Nhận đơn",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textGray,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
    );
  }
}
