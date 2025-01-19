import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_page.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';

import '../domain/menu_domain.dart';

class MenuPendingApprove extends StatelessWidget {
  final List<ItemLinkFood> listItem;
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const MenuPendingApprove(
      {super.key,
      required this.listItem,
      required this.state,
      required this.bloc});

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
      final listResultSearch = state.listResultSearchMenu
          .firstWhereOrNull((e) => e.type == MenuType.pendingApproval);
      if (listResultSearch?.listResult != null &&
          listResultSearch!.listResult.isNotEmpty) {
        return ListView.builder(
            itemCount: listResultSearch.listResult.length,
            itemBuilder: (context, index) {
              final item = listResultSearch.listResult[index];
              return CardDetailMenu(
                item: item,
                actionWidget: Text(
                  "*Sản phẩm đang chờ hệ thống duyệt",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: AppColors.colorDE6,
                      fontStyle: FontStyle.italic),
                ),
              );
            });
      }
      return const EmptySearchMenu();
    }
    return RefreshIndicator(
      color: AppColors.color988,
      onRefresh: () async {
        bloc.getAllMenu();
      },
      child: ListView.builder(
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            final isShowDetail = state.listIdMenuShowFood.contains(
                ShowDetailMenuDomain(
                    idShow: listItem[index].id,
                    type: MenuType.pendingApproval));

            return Column(
              children: <Widget>[
                const Divider(
                  thickness: 1.5,
                  height: 1,
                ),
                GestureDetector(
                  onTap: () {
                    bloc.hideOrShowListFoodByMenu(
                        food: ShowDetailMenuDomain(
                            idShow: listItem[index].id,
                            type: MenuType.pendingApproval));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: AppColors.white,
                    height: 52,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "${listItem[index].name} (${listItem[index].totalProducts.toString().padLeft(2, "0")})",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Icon(
                            isShowDetail
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_right,
                            color: AppColors.black)
                      ],
                    ),
                  ),
                ),
                if (isShowDetail && listItem[index].products != null) ...[
                  ...List.generate(listItem[index].products!.length,
                      (inxDetail) {
                    final itemDetail = listItem[index].products![inxDetail];

                    return CardDetailMenu(
                      item: itemDetail,
                      actionWidget: Text(
                        "*Sản phẩm đang chờ hệ thống duyệt",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: AppColors.colorDE6,
                            fontStyle: FontStyle.italic),
                      ),
                    );
                  })
                ]
              ],
            );
          }),
    );
  }
}
