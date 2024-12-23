import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';

import '../../../../config/theme/color.dart';

class RegisterTypeOfService extends StatelessWidget {
  final RegisterStoreState state;
  final RegisterStoreCubit bloc;
  // final Function(int) typeServiceChange;
  // final int typeSellected;
  // final Function(bool) isAlcoholChange;
  // final bool isAlcohol;
  const RegisterTypeOfService(
      {super.key, required this.bloc, required this.state
      // required this.typeServiceChange,
      // required this.isAlcoholChange,
      // required this.typeSellected,
      // required this.isAlcohol,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const VSpacing(spacing: 12),
            Text(
              "Chọn loại hình dịch vụ",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const VSpacing(spacing: 12),
            Container(
              padding: const EdgeInsets.all(12),
              color: AppColors.background,
              child: Text(
                "Loại hình dịch vụ trên GOO+ đúng với sản phẩm kinh doanh chủ đạo của cửa hàng",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ),
            _TypeServiceItem(
              indexAlcoholSellect: state.isAlcohol ? 0 : 1,
              isSellected: state.typeService == 1,
              onPressed: () {
                bloc.typeServiceSellect(1);
              },
              alcoholSellect: (alcohol) {
                bloc.alcoholSellect(alcohol);
              },
              description:
                  "Món chủ đạo của cửa hàng là món ăn/thức uống đã được chế biến sẵn như: bún, mì, gà rán, pizza, trà sữa, cà phê, v..v..",
              title: "Giao đồ ăn (cửa hàng ăn uống)",
            ),
            _TypeServiceItem(
              indexAlcoholSellect: state.isAlcohol ? 0 : 1,
              isSellected: state.typeService == 2,
              onPressed: () {
                bloc.typeServiceSellect(2);
              },
              alcoholSellect: (alcohol) {
                bloc.alcoholSellect(alcohol);
              },
              title: "Giao hàng siêu thị/ bách hoá",
              description:
                  """Sản phẩm kinh doanh chủ đạo cửa hàng là các mặt hàng như sau:\n
Thực phẩm:
Thực phẩm tươi sống, thực phẩm đóng gói như rau, trái cây, thịt, đồ đóng hộp, đồ đông lạnh,...\n
Siêu thị:
Đồ gia dụng, đồ dùng mẹ và bé,...\n
Thuốc(không kê đơn):
Thực phẩm chức năng, trang thiết bị y tế, dược mỹ phẩm,...
""",
            )
          ],
        ),
      ),
    );
  }
}

class _TypeServiceItem extends StatelessWidget {
  final String description;
  final String title;
  final bool isSellected;
  final Function onPressed;
  final Function(bool) alcoholSellect;
  final int indexAlcoholSellect;
  const _TypeServiceItem(
      {required this.isSellected,
      required this.description,
      required this.title,
      required this.onPressed,
      required this.alcoholSellect,
      required this.indexAlcoholSellect});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Column(
        children: <Widget>[
          const VSpacing(spacing: 12),
          Row(
            children: <Widget>[
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSellected
                        ? AppColors.colorFF9
                        : AppColors.transparent,
                    border: Border.all(
                        color: isSellected
                            ? AppColors.color05C
                            : AppColors.color5DD,
                        width: 1)),
                padding: const EdgeInsets.all(4),
                child: isSellected
                    ? Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.color05C),
                      )
                    : Container(),
              ),
              const HSpacing(spacing: 8),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          const VSpacing(spacing: 8),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              children: <Widget>[
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
                isSellected == true ? const VSpacing(spacing: 8) : Container(),
                isSellected == true
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.transparent,
                            border: Border.all(
                                color: AppColors.color8E8, width: 1.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Bạn có kinh doanh rượu/đồ uống có cồn không?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 12,
                                      color: AppColors.color054,
                                      fontWeight: FontWeight.w600),
                            ),
                            const VSpacing(spacing: 12),
                            Row(
                                children: List.generate(2, (index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: index == 0 ? widthScreen / 6 : 0),
                                child: GestureDetector(
                                  onTap: () {
                                    alcoholSellect(index == 0 ? true : false);
                                  },
                                  child: Container(
                                    color: AppColors.transparent,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  indexAlcoholSellect == index
                                                      ? AppColors.colorFF9
                                                      : AppColors.transparent,
                                              border: Border.all(
                                                  color: indexAlcoholSellect ==
                                                          index
                                                      ? AppColors.color05C
                                                      : AppColors.color5DD,
                                                  width: 1)),
                                          padding: const EdgeInsets.all(4),
                                          child: indexAlcoholSellect == index
                                              ? Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: AppColors
                                                              .color05C),
                                                )
                                              : Container(),
                                        ),
                                        const HSpacing(spacing: 6),
                                        Text(
                                          index == 0 ? "Có" : "Không",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }))
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          const VSpacing(spacing: 12)
        ],
      ),
    );
  }
}
