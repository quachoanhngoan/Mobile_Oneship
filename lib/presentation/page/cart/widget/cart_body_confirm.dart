import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_page.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_state.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';
import 'package:super_tooltip/super_tooltip.dart';

class CartBodyConfirm extends StatelessWidget {
  final CartState state;
  final CartCubit bloc;
  final SuperTooltipController? tooltipController;

  const CartBodyConfirm({
    super.key,
    required this.state,
    required this.bloc,
    this.tooltipController,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
      final listItemSearch = state.listSearchCartConfirm;
      if (listItemSearch.isNotEmpty) {
        return _BodyConfirm(
            refreshFunction: () {
              bloc.getAllCart();
            },
            listCartConfirm: listItemSearch,
            listShowDetailFood: state.listSearchShowDetailFood,
            controller: bloc.confirmPageController,
            tooltipController: tooltipController,
            moreFoodClick: (id, indexPage) {
              bloc.hireOrShowDetailFoodSearch(
                  value: ShowDetailFoodCartDomain(
                type: CartType.confirm,
                confirmType: indexPage == 0
                    ? CartConfirmType.findDriver
                    : CartConfirmType.driving,
                idShow: id,
              ));
            });
      }
      return Container();
    }

    return Container(
      color: AppColors.colorAFA,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            width: double.infinity,
            color: AppColors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: List.generate(CartConfirmType.values.length,
                      (indexTitle) {
                    final typeConfirm = CartConfirmType.values[indexTitle];
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          bloc.changeConfirmPage(indexTitle, typeConfirm);
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                typeConfirm.title
                                    .replaceAll(RegExp(r'#VALUE'), '00'),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: typeConfirm ==
                                                state.cartConfirmTypeSellected
                                            ? AppColors.color988
                                            : AppColors.textGray),
                              ),
                            ),
                            typeConfirm == state.cartConfirmTypeSellected
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 1,
                                      color: AppColors.color988,
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const VerticalDivider(
                  color: AppColors.textGray,
                  thickness: 1,
                  width: 1,
                  indent: 8,
                  endIndent: 8,
                ),
              ],
            ),
          ),
          _BodyConfirm(
              refreshFunction: () {
                bloc.getAllCart();
              },
              tooltipController: tooltipController,
              listCartConfirm: state.listCartConfirm,
              listShowDetailFood: state.listShowDetailFood,
              controller: bloc.confirmPageController,
              moreFoodClick: (id, indexPage) {
                bloc.hireOrShowDetailFood(
                    value: ShowDetailFoodCartDomain(
                  type: CartType.confirm,
                  confirmType: indexPage == 0
                      ? CartConfirmType.findDriver
                      : CartConfirmType.driving,
                  idShow: id,
                ));
              })
        ],
      ),
    );
  }
}

class _BodyConfirm extends StatelessWidget {
  final List<ListCartConfirmDomain> listCartConfirm;
  final Function(int?, int) moreFoodClick;
  final PageController? controller;
  final List<ShowDetailFoodCartDomain> listShowDetailFood;
  final Function() refreshFunction;
  final SuperTooltipController? tooltipController;
  const _BodyConfirm({
    required this.listCartConfirm,
    this.listShowDetailFood = const [],
    required this.moreFoodClick,
    this.controller,
    required this.refreshFunction,
    this.tooltipController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        itemCount: CartConfirmType.values.length,
        itemBuilder: (context, indexPage) {
          final listItem = listCartConfirm.firstWhere(
            (e) => e.type == CartConfirmType.values[indexPage],
          );
          if (listItem.listData.isEmpty) {
            return const CartEmptyBody();
          }
          return ListView.separated(
              itemCount: listItem.listData.length,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              separatorBuilder: (context, index) {
                return const VSpacing(spacing: 12);
              },
              itemBuilder: (context, indexItem) {
                final cartItem = listItem.listData[indexItem];
                final isShowMore =
                    listShowDetailFood.contains(ShowDetailFoodCartDomain(
                  type: CartType.confirm,
                  confirmType: indexPage == 0
                      ? CartConfirmType.findDriver
                      : CartConfirmType.driving,
                  idShow: cartItem.id,
                ));
                return CartBodyItem(
                  onTap: refreshFunction,
                  isShowMore: isShowMore,
                  moreFoodClick: () {
                    moreFoodClick(
                      cartItem.id,
                      indexPage,
                    );
                  },
                  indexCart: indexItem,
                  orderCart: cartItem,
                  bottomWidget: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Hệ thống đang tìm tài xế đến lấy đơn",
                          overflow: TextOverflow.visible,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.color017,
                                  ),
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
                          "Quán tự giao",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                        ),
                      ),
                      const HSpacing(spacing: 4),
                      GestureDetector(
                        onTap: () async {
                          await tooltipController?.showTooltip();
                        },
                        child: SuperTooltip(
                          shadowColor: AppColors.transparent,
                          backgroundColor: AppColors.black.withOpacity(0.8),
                          controller: tooltipController,
                          popupDirection: TooltipDirection.up,
                          content: const Text(
                            "Nút này chỉ hiện thị khi quán có bật chế độ \"Quán tự giao\" trong cài đặt xử lý đơn hàng",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          //   message:
                          //     "Nút này chỉ hiện thị khi quán có bật chế độ \"Quán tự giao\" trong cài đặt xử lý đơn hàng",
                          // textStyle:
                          //     const TextStyle(color: Colors.black, fontSize: 14),
                          child: const Icon(
                            Icons.info_outline_rounded,
                            size: 16,
                            color: AppColors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
