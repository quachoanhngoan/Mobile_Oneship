import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/dashed_divider.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom.dart';

import '../../../../config/routes/app_router.dart';
import '../../../data/model/menu/gr_topping_response.dart';

class ToppingActiveBody extends StatelessWidget {
  final List<GrAddToppingResponse> listItem;
  final MenuDinerCubit bloc;

  const ToppingActiveBody({super.key, required this.bloc, required this.listItem});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listItem.length,
        padding: const EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.color8E8),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      listItem[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 24,
                    )
                  ],
                ),
                const VSpacing(spacing: 8),
                const DashedDivider(color: AppColors.color8E8),
                const VSpacing(spacing: 12),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogChangeStatus(
                                    done: (isOk) {
                                      if (isOk) {
                                        bloc.hideOrShowTopping(listItem[index],
                                            isHide: true);
                                      }
                                      Get.back();
                                    },
                                    title: "Thay đổi trạng thái",
                                    listSubTitle: [
                                      "Bạn có chắc chắn muốn ẩn nhóm topping ",
                                      "\"${listItem[index].name}\"",
                                      " trên ứng dụng khách hàng không?"
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.transparent,
                                border: Border.all(color: AppColors.color8E8)),
                            child: Text(
                              "Ẩn",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      const HSpacing(spacing: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.menuCustomTopping,
                                    arguments: listItem[index])
                                ?.then((value) {
                              if (value) {
                                bloc.getAllTopping();
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.transparent,
                                border: Border.all(color: AppColors.colorD33)),
                            child: Text(
                              "Sửa",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.colorD33),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}