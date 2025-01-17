import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/domain/menu_domain.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_page.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/dashed_divider.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/menu_edit_sheet.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

class MenuItemUnSuccess extends StatelessWidget {
  final List<ItemLinkFood> listItem;
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const MenuItemUnSuccess(
      {super.key,
      required this.listItem,
      required this.state,
      required this.bloc});

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
      final listResultSearch = state.listResultSearchMenu
          .firstWhereOrNull((e) => e.type == MenuType.unsuccessful);
      if (listResultSearch?.listResult != null &&
          listResultSearch!.listResult.isNotEmpty) {
        return ListView.builder(
            itemCount: listResultSearch.listResult.length,
            itemBuilder: (context, index) {
              final item = listResultSearch.listResult[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        item.imageId != null
                            ? Container(
                                width: 58,
                                height: 46,
                                decoration: BoxDecoration(
                                    color: AppColors.transparent,
                                    borderRadius: BorderRadius.circular(8)),
                                child: NetworkImageWithLoader(item.imageId!,
                                    isBaseUrl: true, fit: BoxFit.fill),
                              )
                            : const SizedBox.shrink(),
                        const HSpacing(spacing: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const VSpacing(spacing: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("${item.price} vnđ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.colorD33)),
                                // Text("50.000 vnđ",
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodySmall
                                //         ?.copyWith(
                                //             fontWeight: FontWeight.w400,
                                //             fontSize: 10,
                                //             color: AppColors.color373,
                                //             decoration: TextDecoration
                                //                 .lineThrough)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const VSpacing(spacing: 8),
                    const DashedDivider(
                      color: AppColors.color8E8,
                    ),
                    const VSpacing(spacing: 8),
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                bloc.getDetailFoodById(item.id);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.transparent,
                                      border: Border.all(
                                          color: AppColors.colorD33, width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "Sửa",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColors.colorD33),
                                  )),
                            ),
                          ),
                          const HSpacing(spacing: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogChangeStatus(
                                        done: (isOk) {
                                          if (isOk) {
                                            bloc.deleteMenuFood(
                                                id: item.id, isSearch: true);
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
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.transparent,
                                      border: Border.all(
                                          color: AppColors.color8E8, width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "Xoá",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    const VSpacing(spacing: 8),
                    Text(
                      "*Hình ảnh sản phẩm không hợp lệ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: AppColors.colorB30,
                          fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              );
            });
      }
      return const EmptySearchMenu();
    }
    return ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (context, index) {
          // final isShowDetail = state.listFoodByMenu != null &&
          //     state.listFoodByMenu?.listFoodByMenu?.isNotEmpty == true &&
          //     state.listFoodByMenu?.type == MenuType.unsuccessful &&
          //     state.listFoodByMenu?.idSellected == listItem[index].id &&
          //     !state.isHideListFoodByMenu;

          final isShowDetail = state.listIdMenuShowFood.contains(
              ShowDetailMenuDomain(
                  idShow: listItem[index].id, type: MenuType.unsuccessful));

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
                                  "Bạn có muốn xoá danh mục",
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
                    bloc.hideOrShowListFoodByMenu(
                        food: ShowDetailMenuDomain(
                            idShow: listItem[index].id,
                            type: MenuType.unsuccessful));
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
              if (isShowDetail && listItem[index].products != null) ...[
                ...List.generate(listItem[index].products!.length, (inxDetail) {
                  final itemDetail = listItem[index].products![inxDetail];

                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            itemDetail.imageId != null
                                ? Container(
                                    width: 58,
                                    height: 46,
                                    decoration: BoxDecoration(
                                        color: AppColors.transparent,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: NetworkImageWithLoader(
                                        itemDetail.imageId!,
                                        isBaseUrl: true,
                                        fit: BoxFit.fill),
                                  )
                                : const SizedBox.shrink(),
                            const HSpacing(spacing: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  itemDetail.name ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const VSpacing(spacing: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("${itemDetail.price} vnđ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.colorD33)),
                                    // Text("50.000 vnđ",
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .bodySmall
                                    //         ?.copyWith(
                                    //             fontWeight: FontWeight.w400,
                                    //             fontSize: 10,
                                    //             color: AppColors.color373,
                                    //             decoration: TextDecoration
                                    //                 .lineThrough)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const VSpacing(spacing: 8),
                        const DashedDivider(
                          color: AppColors.color8E8,
                        ),
                        const VSpacing(spacing: 8),
                        SizedBox(
                          height: 40,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    bloc.getDetailFoodById(itemDetail.id);
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          color: AppColors.transparent,
                                          border: Border.all(
                                              color: AppColors.colorD33,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        "Sửa",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: AppColors.colorD33),
                                      )),
                                ),
                              ),
                              const HSpacing(spacing: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
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
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          color: AppColors.transparent,
                                          border: Border.all(
                                              color: AppColors.color8E8,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        "Xoá",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        const VSpacing(spacing: 8),
                        Text(
                          itemDetail.reason ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 12,
                                  color: AppColors.colorB30,
                                  fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  );
                })
              ]
            ],
          );
        });
  }
}
