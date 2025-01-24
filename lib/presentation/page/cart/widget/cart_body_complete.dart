import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_page.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_state.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

import '../../../data/time_utils.dart';

class CartBodyComplete extends StatelessWidget {
  final CartCubit bloc;
  final CartState state;

  const CartBodyComplete({
    super.key,
    required this.bloc,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
      final listItemSearch = state.listSearchCartComplete.entries.toList();
      if (listItemSearch.isNotEmpty) {
        return _CompleteBody(
            refreshFunction: () {
              bloc.getAllCart();
            },
            listItem: listItemSearch,
            listShowDetailFood: state.listSearchShowDetailFood,
            moreFoodClick: (id) {
              bloc.hireOrShowDetailFood(
                  value: ShowDetailFoodCartDomain(
                type: CartType.complete,
                idShow: id,
              ));
            });
      }
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          "Hiển thị 0 kết quả tìm kiếm",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.textGray,
              ),
        ),
      );
    }

    final listItem = state.listCartComplete.entries.toList();

    return Container(
      color: AppColors.colorAFA,
      child: RefreshIndicator(
        color: AppColors.color988,
        onRefresh: () async {
          bloc.getAllCart();
        },
        child: Column(
          children: <Widget>[
            const VSpacing(spacing: 12),
            Card(
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: AppColors.white,
              borderOnForeground: false,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: GestureDetector(
                  onTap: () async {
                    final timeSellect =
                        await TimeUtils().rangeTimePicker(context);
                    if (timeSellect != null) {
                      bloc.sellectTimeRange(timeSellect);
                    }
                  },
                  child: Container(
                    color: AppColors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          state.timeRangeTitleComplete ?? "",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.color828,
                                  ),
                        ),
                        const ImageAssetWidget(
                          image: AppAssets.imagesIconsIcCalendar,
                          width: 16,
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const VSpacing(spacing: 6),
            _CompleteBody(
                refreshFunction: () {
                  bloc.getAllCart();
                },
                listItem: listItem,
                listShowDetailFood: state.listShowDetailFood,
                moreFoodClick: (id) {
                  bloc.hireOrShowDetailFood(
                      value: ShowDetailFoodCartDomain(
                    type: CartType.complete,
                    idShow: id,
                  ));
                })
          ],
        ),
      ),
    );
  }
}

class _CompleteBody extends StatelessWidget {
  final List<MapEntry<String?, List<OrderCartResponse>>> listItem;
  final List<ShowDetailFoodCartDomain> listShowDetailFood;
  final Function(int?) moreFoodClick;
  final Function() refreshFunction;
  const _CompleteBody({
    required this.listItem,
    this.listShowDetailFood = const [],
    required this.moreFoodClick,
    required this.refreshFunction,
  });

  @override
  Widget build(BuildContext context) {
    if (listItem.isEmpty) {
      return const Expanded(child: CartEmptyBody());
    }

    return Expanded(
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          separatorBuilder: (context, index) => const VSpacing(spacing: 12),
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  listItem[index].key ?? "",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.color723,
                      fontSize: 14),
                ),
                const VSpacing(spacing: 12),
                ...List.generate(listItem[index].value.length, (indexCard) {
                  final isShowMore =
                      listShowDetailFood.contains(ShowDetailFoodCartDomain(
                    type: CartType.complete,
                    idShow: listItem[index].value[indexCard].id,
                  ));

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CartBodyItem(
                      onTap: refreshFunction,
                      isShowMore: isShowMore,
                      moreFoodClick: () {
                        moreFoodClick(listItem[index].value[indexCard].id);
                      },
                      indexCart: indexCard,
                      orderCart: listItem[index].value[indexCard],
                      bottomWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Tài xế xác nhận lấy đơn lúc 13:30",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.color017,
                                    ),
                          ),
                          Container(
                            height: 26,
                            width: 114,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.color988,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Chi tiết doanh thu",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
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
                // const VSpacing(spacing: 12),
              ],
            );
          }),
    );
  }
}
