import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';
import 'package:oneship_merchant_app/presentation/data/time_utils.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_state.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';
import 'package:oneship_merchant_app/presentation/page/cart/widget/cart_body_book.dart';
import 'package:oneship_merchant_app/presentation/page/cart/widget/cart_body_cancel.dart';
import 'package:oneship_merchant_app/presentation/page/cart/widget/cart_body_complete.dart';
import 'package:oneship_merchant_app/presentation/page/cart/widget/cart_body_confirm.dart';
import 'package:oneship_merchant_app/presentation/page/cart/widget/cart_body_new.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/dashed_divider.dart';
import 'package:oneship_merchant_app/presentation/page/order/order_page.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/text_field_search.dart';

import '../../../config/theme/color.dart';
import '../../../core/constant/app_assets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartCubit bloc;

  @override
  initState() {
    bloc = injector.get<CartCubit>();
    bloc.init();
    super.initState();
  }

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }

  double calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
        bloc: bloc,
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: <Widget>[
                VSpacing(spacing: state.isShowSearch ? 12 : 0),
                Row(
                  children: <Widget>[
                    IconButton(
                        highlightColor: AppColors.transparent,
                        onPressed: () {
                          if (state.isShowSearch) {
                            bloc.hideOrShowSearch();
                          }
                        },
                        icon: Icon(Icons.arrow_back,
                            color: state.isShowSearch
                                ? AppColors.black
                                : AppColors.transparent)),
                    if (state.isShowSearch) ...[
                      Expanded(
                          child: TextFieldSearch(
                              controller: bloc.searchController,
                              showClearButton: state.isShowClearSearch,
                              onChange: (value) {
                                bloc.checkShowClearSearch();
                              },
                              clearTextClicked: () {
                                bloc.searchController.clear();
                                bloc.checkShowClearSearch();
                              },
                              hintText: "Nhập mã đơn hàng, tên khách hàng")),
                      const HSpacing(spacing: 12)
                    ] else ...[
                      Expanded(
                        child: Text("Đơn hàng",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                      ),
                      GestureDetector(
                        onTap: () {
                          bloc.hideOrShowSearch();
                        },
                        child: const ImageAssetWidget(
                          image: AppAssets.imagesIconsIcSearch,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const HSpacing(spacing: 12),
                    ]
                  ],
                ),
                VSpacing(spacing: state.isShowSearch ? 12 : 0),
                Container(
                  height: 38,
                  color: AppColors.transparent,
                  child: ListView.builder(
                      itemCount: CartType.values.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final typeCart = CartType.values[index];

                        final titleStyle =
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: state.cartTypeSellected == typeCart
                                      ? AppColors.color988
                                      : AppColors.textGray,
                                  fontWeight:
                                      state.cartTypeSellected == typeCart
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                );

                        final textWidth =
                            calculateTextWidth(typeCart.title, titleStyle!) +
                                24;

                        return GestureDetector(
                          onTap: () {
                            bloc.changeCartType(index, typeCart);
                          },
                          child: Container(
                            color: AppColors.transparent,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 34,
                                  color: AppColors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  alignment: Alignment.center,
                                  child: Text(
                                    typeCart.title,
                                    textAlign: TextAlign.center,
                                    style: titleStyle,
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 1,
                                      width: textWidth,
                                      color: AppColors.textGray,
                                    ),
                                    Container(
                                      height: 2,
                                      width: textWidth,
                                      color: state.cartTypeSellected == typeCart
                                          ? AppColors.color988
                                          : AppColors.transparent,
                                    )
                                    // : const SizedBox.shrink()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Expanded(
                    child: PageView.builder(
                        controller: bloc.pageController,
                        itemCount: CartType.values.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final itemBody = CartType.values[index];
                          switch (itemBody) {
                            case CartType.book:
                              return CartBodyBook(state: state, bloc: bloc);
                            case CartType.newCart:
                              return CartBodyNew(state: state, bloc: bloc);
                            case CartType.confirm:
                              return CartBodyConfirm(state: state, bloc: bloc);
                            case CartType.complete:
                              return CartBodyComplete(bloc: bloc, state: state);
                            case CartType.cancel:
                              return CartBodyCancel(bloc: bloc, state: state);
                            // default:
                            //   return Container();
                          }
                        }))
              ],
            ),
          );
        });
  }
}

class CartEmptyBody extends StatelessWidget {
  const CartEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ImageAssetWidget(
          image: AppAssets.imagesImgCartEmpty,
          width: context.screenWidth / 3,
        ),
        const VSpacing(spacing: 12),
        Text(
          "Không có đơn hàng nào",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.color373,
              fontSize: 16),
        )
      ],
    );
  }
}

class CartBodyItem extends StatelessWidget {
  final Widget bottomWidget;
  final OrderCartResponse orderCart;
  final int indexCart;

  const CartBodyItem({
    super.key,
    required this.bottomWidget,
    required this.orderCart,
    required this.indexCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderPage(
              id: orderCart.id!,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 0.5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "$indexCart. ${orderCart.client?.name}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.color723,
                      ),
                ),
                const Spacer(),
                Text(
                  "${orderCart.id}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.colorD33,
                        fontSize: 14,
                      ),
                )
              ],
            ),
            const VSpacing(spacing: 8),
            const DashedDivider(color: AppColors.color8E8),
            const VSpacing(spacing: 8),
            orderCart.orderItems != null
                ? ListView.builder(
                    itemCount: orderCart.orderItems!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, indexOther) {
                      final item = orderCart.orderItems![indexOther];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => OrderPage(
                                id: item.id!,
                              ));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 58,
                              height: 46,
                              decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const NetworkImageWithLoader("",
                                  isBaseUrl: true, fit: BoxFit.fill),
                            ),
                            const HSpacing(spacing: 12),
                            Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                  border: Border.all(
                                      color: AppColors.textGray, width: 1),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                "x$indexOther",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 10,
                                      color: AppColors.color988,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            const HSpacing(spacing: 12),
                            Text(
                              item.productName ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorF3B,
                                  ),
                            ),
                            const Spacer(),
                            Text(
                              "${item.price}đ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.color723,
                                    fontSize: 12,
                                  ),
                            )
                          ],
                        ),
                      );
                    })
                : Container(),
            const VSpacing(spacing: 8),
            GestureDetector(
              onTap: () {},
              child: Container(
                color: AppColors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.colorD33,
                    ),
                    const HSpacing(spacing: 4),
                    Text(
                      "Xem thêm",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.colorD33,
                            fontSize: 14,
                          ),
                    )
                  ],
                ),
              ),
            ),
            const VSpacing(spacing: 8),
            const DashedDivider(color: AppColors.color8E8),
            const VSpacing(spacing: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(TimeCartType.values.length, (indexTime) {
                var valueTime = "--";
                switch (TimeCartType.values[indexTime]) {
                  case TimeCartType.book:
                    valueTime = TimeUtils()
                        .convertIsoDateToHourMinutes(orderCart.createdAt);
                  case TimeCartType.takeOrder:
                    valueTime = "--";
                  case TimeCartType.delivery:
                    valueTime = "--";
                }
                return Padding(
                  padding: EdgeInsets.only(
                      right: indexTime != TimeCartType.values.length - 1
                          ? context.screenWidth / 6
                          : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        TimeCartType.values[indexTime].title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textGray,
                            ),
                      ),
                      const VSpacing(spacing: 4),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.access_time_outlined,
                            color: AppColors.color988,
                            size: 12,
                          ),
                          const HSpacing(spacing: 4),
                          Text(
                            valueTime,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
            const VSpacing(spacing: 8),
            const DashedDivider(color: AppColors.color8E8),
            const VSpacing(spacing: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  color: AppColors.color6F6,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${orderCart.orderItems?.length ?? "0"} phần",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: AppColors.colorD33,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  // !isComplete
                  //     ? const Spacer()
                  //     : const Expanded(
                  //         child: ImageAssetWidget(
                  //             image: AppAssets.imagesIconsIcCartPaid,
                  //             width: 39,
                  //             height: 34),
                  //       ),
                  Row(
                    children: <Widget>[
                      Text("Tổng doanh thu đơn hàng: ",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    color: AppColors.color373,
                                    fontWeight: FontWeight.w500,
                                  )),
                      Text("${orderCart.totalAmount}đ",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 16,
                                    color: AppColors.color988,
                                    fontWeight: FontWeight.w600,
                                  ))
                    ],
                  )
                ],
              ),
            ),
            const VSpacing(spacing: 8),
            bottomWidget,
          ],
        ),
      ),
    );
  }
}
