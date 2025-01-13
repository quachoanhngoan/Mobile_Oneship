import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/domain/menu_domain.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_page.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/menu_edit_sheet.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom.dart';

class MenuNotRegisteredBody extends StatelessWidget {
  final List<ItemLinkFood> listItem;
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const MenuNotRegisteredBody(
      {super.key,
      required this.listItem,
      required this.state,
      required this.bloc});

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
      final listResultSearch = state.listResultSearch
          .firstWhereOrNull((e) => e.type == MenuType.notRegistered);
      if (listResultSearch?.listResult != null &&
          listResultSearch!.listResult.isNotEmpty) {
        return ListView.builder(
            itemCount: listResultSearch.listResult.length,
            itemBuilder: (context, index) {
              final item = listResultSearch.listResult[index];
              return CardDetailMenu(
                item: item,
                isActive: false,
                actionWidget: SizedBox(
                  height: 40,
                  child: Row(
                    children: List.generate(ActionNotRegisterType.values.length,
                        (it) {
                      final itemAction = ActionNotRegisterType.values[it];
                      return Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right:
                                  ActionNotRegisterType.values.length - 1 != it
                                      ? 8
                                      : 0),
                          child: GestureDetector(
                            onTap: () {
                              switch (itemAction) {
                                case ActionNotRegisterType.advertisement:
                                  log("advertisement click");
                                  break;
                                case ActionNotRegisterType.show:
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return DialogChangeStatus(
                                          done: (isOk) {
                                            if (isOk) {
                                              bloc.hideOrShowMenuFood(item,
                                                  productCategoryId:
                                                      listItem[it].id,
                                                  isHide: false);
                                            }
                                            Get.back();
                                          },
                                          title: "Thay đổi trạng thái",
                                          listSubTitle: [
                                            "Bạn có chắc chắn muốn hiển thị món ",
                                            "\"${item.name}\"",
                                            " trên ứng dụng khách hàng không?"
                                          ],
                                        );
                                      });
                                  break;
                                case ActionNotRegisterType.edit:
                                  bloc.getDetailFoodById(item.id);
                                  break;
                                case ActionNotRegisterType.delete:
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogChangeStatus(
                                          done: (isOk) {
                                            if (isOk) {
                                              bloc.deleteMenuFood(id: item.id);
                                            }
                                            Get.back();
                                          },
                                          title: "Xoá sản phẩm",
                                          listSubTitle: [
                                            "Bạn có muốn xoá sản phẩm ",
                                            "\"${item.name}\"",
                                            " không?"
                                          ],
                                        );
                                      });
                                  break;
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.transparent,
                                    border: Border.all(
                                        color: itemAction ==
                                                ActionNotRegisterType.edit
                                            ? AppColors.colorD33
                                            : AppColors.color8E8,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  itemAction.title,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: itemAction ==
                                                  ActionNotRegisterType.edit
                                              ? AppColors.colorD33
                                              : AppColors.black),
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
              state.listFoodByMenu?.type == MenuType.notRegistered &&
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
                                    bloc.hideShowMenuGroup(listItem[index].id);
                                  }
                                  Get.back();
                                },
                                title: "Thay đổi trạng thái",
                                listSubTitle: [
                                  "Bạn có chắc chắn muốn hiển thị nhóm ",
                                  "\"${listItem[index].name}\"",
                                  " trên ứng dụng khách hàng không?"
                                ],
                              );
                            });
                      },
                      backgroundColor: AppColors.color373,
                      padding: EdgeInsets.zero,
                      child: Text(
                        "Hiển thị",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomSlidableAction(
                      onPressed: (_) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DialogChangeStatus(
                                done: (isOk) {
                                  if (isOk) {
                                    bloc.deleteGroupMenu(listItem[index].id);
                                  }
                                  Get.back();
                                },
                                title: "Xoá danh mục",
                                listSubTitle: [
                                  "Bạn có muốn xoá danh mục ",
                                  "\"${listItem[index].name}\"",
                                  " không?"
                                ],
                              );
                            });
                      },
                      backgroundColor: AppColors.error,
                      padding: EdgeInsets.zero,
                      child: Text(
                        "Xoá",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                        type: MenuType.notRegistered,
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
                ),
              ),
              if (isShowDetail) ...[
                ...List.generate(state.listFoodByMenu!.listFoodByMenu!.length,
                    (inxDetail) {
                  final itemDetail =
                      state.listFoodByMenu!.listFoodByMenu![inxDetail];
                  return CardDetailMenu(
                    item: itemDetail,
                    isActive: false,
                    actionWidget: SizedBox(
                      height: 40,
                      child: Row(
                        children: List.generate(
                            ActionNotRegisterType.values.length, (index) {
                          final itemAction =
                              ActionNotRegisterType.values[index];
                          return Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      ActionNotRegisterType.values.length - 1 !=
                                              index
                                          ? 8
                                          : 0),
                              child: GestureDetector(
                                onTap: () {
                                  switch (itemAction) {
                                    case ActionNotRegisterType.advertisement:
                                      log("advertisement click");
                                      break;
                                    case ActionNotRegisterType.show:
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogChangeStatus(
                                              done: (isOk) {
                                                if (isOk) {
                                                  bloc.hideOrShowMenuFood(
                                                      itemDetail,
                                                      productCategoryId:
                                                          listItem[index].id,
                                                      isHide: false);
                                                }
                                                Get.back();
                                              },
                                              title: "Thay đổi trạng thái",
                                              listSubTitle: [
                                                "Bạn có chắc chắn muốn hiển thị món ",
                                                "\"${itemDetail.name}\"",
                                                " trên ứng dụng khách hàng không?"
                                              ],
                                            );
                                          });
                                      break;
                                    case ActionNotRegisterType.edit:
                                      bloc.getDetailFoodById(itemDetail.id);
                                      break;
                                    case ActionNotRegisterType.delete:
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogChangeStatus(
                                              done: (isOk) {
                                                if (isOk) {
                                                  bloc.deleteMenuFood(
                                                      id: itemDetail.id);
                                                }
                                                Get.back();
                                              },
                                              title: "Xoá sản phẩm",
                                              listSubTitle: [
                                                "Bạn có muốn xoá sản phẩm ",
                                                "\"${itemDetail.name}\"",
                                                " không?"
                                              ],
                                            );
                                          });
                                      break;
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.transparent,
                                        border: Border.all(
                                            color: itemAction ==
                                                    ActionNotRegisterType.edit
                                                ? AppColors.colorD33
                                                : AppColors.color8E8,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      itemAction.title,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: itemAction ==
                                                      ActionNotRegisterType.edit
                                                  ? AppColors.colorD33
                                                  : AppColors.black),
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
