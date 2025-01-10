import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/domain/menu_domain.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_page.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/menu_edit_sheet.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom.dart';

import '../../../data/model/menu/linkfood_response.dart';

class MenuActiveBody extends StatelessWidget {
  final List<ItemLinkFood> listItem;
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const MenuActiveBody(
      {super.key,
      required this.listItem,
      required this.bloc,
      required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
      final listResultSearch = state.listResultSearch
          .firstWhereOrNull((e) => e.type == MenuType.active);
      if (listResultSearch?.listResult != null &&
          listResultSearch!.listResult.isNotEmpty) {
        return ListView.builder(
            itemCount: listResultSearch.listResult.length,
            itemBuilder: (context, index) {
              final item = listResultSearch.listResult[index];
              return CardDetailMenu(
                item: item,
                actionWidget: SizedBox(
                  height: 40,
                  child: Row(
                    children: List.generate(DetailMenuActionType.values.length,
                        (index) {
                      final itemAction = DetailMenuActionType.values[index];
                      return Expanded(
                        flex: itemAction == DetailMenuActionType.more ? 2 : 5,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: DetailMenuActionType.values.length - 1 !=
                                      index
                                  ? 8
                                  : 0),
                          child: GestureDetector(
                            onTap: () {
                              switch (itemAction) {
                                case DetailMenuActionType.advertisement:
                                  log("advertisement click");
                                case DetailMenuActionType.hide:
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogChangeStatus(
                                          done: (isOk) {
                                            if (isOk) {
                                              bloc.hideOrShowMenuFood(item,
                                                  isHide: true,
                                                  productCategoryId:
                                                      listItem[index].id);
                                            }
                                            Get.back();
                                          },
                                          title: "Thay đổi trạng thái",
                                          listSubTitle: [
                                            "Bạn có chắc chắn muốn ẩn món ",
                                            "\"${item.name}\"",
                                            " trên ứng dụng khách hàng không?"
                                          ],
                                        );
                                      });
                                case DetailMenuActionType.edit:
                                  bloc.getDetailFoodById(item.id);
                                  break;
                                case DetailMenuActionType.more:
                                  break;
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.transparent,
                                    border: Border.all(
                                        color: itemAction.colorBorder,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: itemAction.title != null
                                    ? Text(
                                        itemAction.title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: itemAction.colorText),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Icon(
                                          Icons.more_horiz_rounded,
                                          size: 16,
                                        ),
                                      )),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            });
      }
      return const EmptySearchMenu();
    }
    return ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (context, index) {
          final isShowDetail = state.listFoodByMenu != null &&
              state.listFoodByMenu?.listFoodByMenu?.isNotEmpty == true &&
              state.listFoodByMenu?.type == MenuType.active &&
              state.listFoodByMenu?.idSellected == listItem[index].id &&
              !state.isHideListFoodByMenu;

          return Column(
            children: <Widget>[
              const Divider(
                thickness: 1.5,
                height: 1,
              ),
              Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      CustomSlidableAction(
                        onPressed: (_) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogChangeStatus(
                                  done: (isOk) {
                                    if (isOk) {
                                      bloc.hideShowMenuGroup(listItem[index].id,
                                          isHide: true);
                                    }
                                    Get.back();
                                  },
                                  title: "Thay đổi trạng thái",
                                  listSubTitle: [
                                    "Bạn có chắc chắn muốn ẩn nhóm ",
                                    "\"${listItem[index].name}\"",
                                    " trên ứng dụng khách hàng không?"
                                  ],
                                );
                              });
                        },
                        backgroundColor: AppColors.color373,
                        padding: EdgeInsets.zero,
                        child: Text(
                          "Ẩn",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 14,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                      CustomSlidableAction(
                        onPressed: (_) {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (_) {
                                return MenuEditSheet(
                                    bloc: bloc, item: listItem[index]);
                              });
                        },
                        backgroundColor: AppColors.color988,
                        padding: EdgeInsets.zero,
                        child: Text(
                          "Sửa",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 14,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      bloc.getListFoodByMenu(
                          type: MenuType.active,
                          productCategoryId: listItem[index].id);
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
                  )),
              if (isShowDetail) ...[
                ...List.generate(state.listFoodByMenu!.listFoodByMenu!.length,
                    (inxDetail) {
                  final item = state.listFoodByMenu!.listFoodByMenu![inxDetail];
                  return CardDetailMenu(
                    item: item,
                    actionWidget: SizedBox(
                      height: 40,
                      child: Row(
                        children: List.generate(
                            DetailMenuActionType.values.length, (index) {
                          final itemAction = DetailMenuActionType.values[index];
                          return Expanded(
                            flex:
                                itemAction == DetailMenuActionType.more ? 2 : 5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      DetailMenuActionType.values.length - 1 !=
                                              index
                                          ? 8
                                          : 0),
                              child: GestureDetector(
                                onTap: () {
                                  switch (itemAction) {
                                    case DetailMenuActionType.advertisement:
                                      log("advertisement click");
                                    case DetailMenuActionType.hide:
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogChangeStatus(
                                              done: (isOk) {
                                                if (isOk) {
                                                  bloc.hideOrShowMenuFood(item,
                                                      isHide: true,
                                                      productCategoryId:
                                                          listItem[index].id);
                                                }
                                                Get.back();
                                              },
                                              title: "Thay đổi trạng thái",
                                              listSubTitle: [
                                                "Bạn có chắc chắn muốn ẩn món ",
                                                "\"${item.name}\"",
                                                " trên ứng dụng khách hàng không?"
                                              ],
                                            );
                                          });
                                    case DetailMenuActionType.edit:
                                      bloc.getDetailFoodById(item.id);
                                      break;
                                    case DetailMenuActionType.more:
                                      break;
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.transparent,
                                        border: Border.all(
                                            color: itemAction.colorBorder,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: itemAction.title != null
                                        ? Text(
                                            itemAction.title!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color:
                                                        itemAction.colorText),
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Icon(
                                              Icons.more_horiz_rounded,
                                              size: 16,
                                            ),
                                          )),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                })
              ]
            ],
          );
        });
  }
}
