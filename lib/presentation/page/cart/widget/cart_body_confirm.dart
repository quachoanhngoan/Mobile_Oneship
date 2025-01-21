import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_page.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_state.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';

class CartBodyConfirm extends StatelessWidget {
  final CartState state;
  final CartCubit bloc;

  const CartBodyConfirm({super.key, required this.state, required this.bloc});

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
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
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: bloc.confirmPageController,
              itemCount: CartConfirmType.values.length,
              itemBuilder: (context, indexPage) {
                return ListView.separated(
                    itemCount: 10,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    separatorBuilder: (context, index) {
                      return const VSpacing(spacing: 12);
                    },
                    itemBuilder: (context, indexItem) {
                      return CartBodyItem(
                        bottomWidget: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Hệ thống đang tìm tài xế đến lấy đơn",
                                overflow: TextOverflow.visible,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                    ),
                              ),
                            ),
                            const VSpacing(spacing: 4),
                            const Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: AppColors.black,
                            )
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
