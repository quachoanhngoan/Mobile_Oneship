import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/domain/menu_domain.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

import '../../../injector.dart';
import '../../data/model/menu/gr_topping_response.dart';
import '../../data/model/menu/list_menu_food_response.dart';
import '../login/widget/loading_widget.dart';
import 'widgets/dashed_divider.dart';

class MenuDinerPage extends StatefulWidget {
  const MenuDinerPage({super.key});

  @override
  State<MenuDinerPage> createState() => _MenuDinerPageState();
}

class _MenuDinerPageState extends State<MenuDinerPage> {
  late MenuDinerCubit bloc;

  @override
  void initState() {
    bloc = injector.get<MenuDinerCubit>();
    bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuDinerCubit, MenuDinerState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.errorEditTopping != null) {
            context.showErrorDialog(state.errorEditTopping!, context);
          }
          if (state.textErrorToast != null) {
            context.showToastDialog(state.textErrorToast!);
          }
        },
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon:
                          const Icon(Icons.arrow_back, color: AppColors.black)),
                  title: Text("Thực đơn",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  actions: const <Widget>[
                    ImageAssetWidget(
                      image: AppAssets.imagesIconsIcSearch,
                      width: 24,
                      height: 24,
                    ),
                    HSpacing(spacing: 8),
                    ImageAssetWidget(
                      image: AppAssets.imagesIconsIcFile,
                      width: 24,
                      height: 24,
                    ),
                    HSpacing(spacing: 12),
                  ],
                ),
                body: Column(
                  children: <Widget>[
                    Row(
                      children:
                          List.generate(MenuMainType.values.length, (index) {
                        final item = MenuMainType.values[index];
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              bloc.changeMainPage(index, item);
                            },
                            child: Container(
                              color: AppColors.transparent,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 34,
                                    child: Text(
                                      item.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: state.menuMainType == item
                                                  ? AppColors.color988
                                                  : AppColors.textGray,
                                              fontWeight:
                                                  state.menuMainType == item
                                                      ? FontWeight.w600
                                                      : FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    height: state.menuMainType == item ? 3 : 1,
                                    color: state.menuMainType == item
                                        ? AppColors.color988
                                        : AppColors.textGray,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Expanded(
                        child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: bloc.mainController,
                      children: <Widget>[
                        _MenuWidget(
                          bloc: bloc,
                          state: state,
                        ),
                        _GroupToppingWidget(
                          bloc: bloc,
                          state: state,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              Visibility(
                visible: state.isLoading,
                child: const LoadingWidget(),
              )
            ],
          );
        });
  }
}

class _MenuWidget extends StatelessWidget {
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const _MenuWidget({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: MenuType.values.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = MenuType.values[index];
                      final titleCount = state.listMenu
                              ?.where((e) => e.type == item)
                              .toList()
                              .firstOrNull
                              ?.data
                              ?.length ??
                          0;
                      return Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              bloc.changePageMenu(index, item);
                            },
                            child: IntrinsicWidth(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  item.title.replaceAll(
                                      RegExp(r'#VALUE'), '$titleCount'),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: item == state.menuType
                                              ? AppColors.color988
                                              : AppColors.textGray,
                                          fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          index != MenuType.values.length - 1
                              ? const VerticalDivider(
                                  color: AppColors.textGray,
                                  thickness: 1,
                                  width: 1,
                                  indent: 8,
                                  endIndent: 8,
                                )
                              : Container()
                        ],
                      );
                    }),
              ),
              Expanded(
                child: PageView.builder(
                    itemCount: MenuType.values.length,
                    controller: bloc.menuController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = MenuType.values[index];
                      final data = state.listMenu
                          ?.where((e) => e.type == item)
                          .toList()
                          .firstOrNull
                          ?.data;
                      if (data?.isNotEmpty == true) {
                        switch (item) {
                          case MenuType.active:
                            return _MenuActiveBody(
                                listItem: data!, bloc: bloc, state: state);
                          case MenuType.notRegistered:
                            return _MenuNotRegisteredBody(
                                listItem: data!, state: state, bloc: bloc);
                          case MenuType.pendingApproval:
                            return _MenuPendingApprove(
                                listItem: data!, state: state, bloc: bloc);
                          case MenuType.unsuccessful:
                            return _MenuItemUnSuccess(
                                listItem: data!, state: state, bloc: bloc);
                        }
                      }
                      return const _MenuEmptyBody();
                    }),
              )
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 0.3,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.pushWithNamed(context,
                          routerName: AppRoutes.menuCustomPage,
                          complete: (result) {
                        if (result) {
                          bloc.getAllMenu();
                        }
                      });
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(width: 1, color: AppColors.color988)),
                      child: Text(
                        "Thêm danh mục",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.color988),
                      ),
                    ),
                  ),
                ),
                const HSpacing(spacing: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.pushWithNamed(context,
                          routerName: AppRoutes.menuDishsCustomPage,
                          complete: (value) {
                        if (value) {
                          bloc.getAllMenu();
                        }
                      });
                    },
                    child: Container(
                      // width: double.infinity,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.color988,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Thêm món mới",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class _MenuEmptyBody extends StatelessWidget {
  const _MenuEmptyBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: context.width,
            child: const AspectRatio(
                aspectRatio: 390 / 390,
                child: ImageAssetWidget(image: AppAssets.imagesImgGrmenuEmpty)),
          ),
          const VSpacing(spacing: 16),
          Text("Quán của bạn chưa có món nào!",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.colorD33),
              textAlign: TextAlign.center),
          const VSpacing(spacing: 8),
          Text(
            "Bạn cần có danh mục để quán có thể phân loại theo nhóm món trên thực đơn !",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.textGray),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class _MenuActiveBody extends StatelessWidget {
  final List<ItemLinkFood> listItem;
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const _MenuActiveBody(
      {required this.listItem, required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
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
                        onPressed: (_) {},
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
                              listItem[index].name,
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
                  return _CardDetailMenu(
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
                                    case DetailMenuActionType.more:
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

class _CardDetailMenu extends StatelessWidget {
  final Widget actionWidget;
  final bool isActive;
  final MenuFoodResponseItem item;

  const _CardDetailMenu(
      {required this.actionWidget, required this.item, this.isActive = true});

  @override
  Widget build(BuildContext context) {
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
              Container(
                width: 58,
                height: 46,
                decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: NetworkImageWithLoader(item.imageId,
                    isBaseUrl: true, fit: BoxFit.fill),
              ),
              const HSpacing(spacing: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
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
                      //             decoration: TextDecoration.lineThrough)),
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
          IntrinsicHeight(
            child: Row(
              children: List.generate(StatisticMenuType.values.length, (index) {
                final itemStatistic = StatisticMenuType.values[index];
                var valueAction = "";
                switch (itemStatistic) {
                  case StatisticMenuType.sold:
                    valueAction = "${item.sold}";
                  case StatisticMenuType.views:
                    valueAction = "${item.viewed}";
                  case StatisticMenuType.likes:
                    valueAction = "${item.liked}";
                }

                return Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: index == 0
                              ? MainAxisAlignment.start
                              : index == StatisticMenuType.values.length - 1
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: ImageAssetWidget(
                                  image: itemStatistic.icon,
                                  width: 14,
                                  height: 14,
                                  color: AppColors.color373),
                            ),
                            const HSpacing(spacing: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  itemStatistic.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.color373),
                                ),
                                const VSpacing(spacing: 4),
                                Text(
                                  valueAction,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.color373),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      StatisticMenuType.values.length - 1 != index
                          ? Container(
                              width: 1,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    AppColors.color9D9.withOpacity(0),
                                    AppColors.color4E4,
                                    AppColors.color9D9.withOpacity(0)
                                  ])),
                            )
                          : Container()
                    ],
                  ),
                );
              }),
            ),
          ),
          const VSpacing(spacing: 8),
          const DashedDivider(
            color: AppColors.color8E8,
          ),
          const VSpacing(spacing: 8),
          actionWidget
        ],
      ),
    );
  }
}

class _MenuNotRegisteredBody extends StatelessWidget {
  final List<ItemLinkFood> listItem;
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const _MenuNotRegisteredBody(
      {required this.listItem, required this.state, required this.bloc});

  @override
  Widget build(BuildContext context) {
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
                        log("edit group menu not register");
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
                                done: (isOk) {},
                                title: "Xoá danh mục",
                                listSubTitle: const [
                                  "Danh mục chứa sản phẩm đang hoạt động. Bạn vui lòng kiểm tra lại!"
                                ],
                                action: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                      onPressed: () {
                                        context.popScreen();
                                      },
                                      child: Text(
                                        "OK",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.color988),
                                      )),
                                ),
                              );
                            });
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return DialogChangeStatus(
                        //         done: (isOk) {
                        //           if (isOk) {
                        //             // bloc.deleteGroupTopping(listItem[index].id);
                        //           }
                        //           Get.back();
                        //         },
                        //         title: "Xoá danh mục",
                        //         listSubTitle: [
                        //           "Bạn có muốn xoá sản phẩm ",
                        //           "\"${listItem[index].name}\"",
                        //           " không?"
                        //         ],
                        //       );
                        //     });
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
                            listItem[index].name,
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
                  return _CardDetailMenu(
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
                                      break;
                                    case ActionNotRegisterType.delete:

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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: itemAction ==
                                                      ActionNotRegisterType.edit
                                                  ? AppColors.colorD33
                                                  : AppColors.color8E8),
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

class _MenuPendingApprove extends StatelessWidget {
  final List<ItemLinkFood> listItem;
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const _MenuPendingApprove(
      {required this.listItem, required this.state, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (context, index) {
          final isShowDetail = state.listFoodByMenu != null &&
              state.listFoodByMenu?.listFoodByMenu?.isNotEmpty == true &&
              state.listFoodByMenu?.type == MenuType.pendingApproval &&
              state.listFoodByMenu?.idSellected == listItem[index].id &&
              !state.isHideListFoodByMenu;

          return Column(
            children: <Widget>[
              const Divider(
                thickness: 1.5,
                height: 1,
              ),
              GestureDetector(
                onTap: () {
                  bloc.getListFoodByMenu(
                      type: MenuType.pendingApproval,
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
                          listItem[index].name,
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
              if (isShowDetail) ...[
                ...List.generate(state.listFoodByMenu!.listFoodByMenu!.length,
                    (inxDetail) {
                  final itemDetail =
                      state.listFoodByMenu!.listFoodByMenu![inxDetail];
                  return _CardDetailMenu(
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
        });
  }
}

class _MenuItemUnSuccess extends StatelessWidget {
  final List<ItemLinkFood> listItem;
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const _MenuItemUnSuccess(
      {required this.listItem, required this.state, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (context, index) {
          final isShowDetail = state.listFoodByMenu != null &&
              state.listFoodByMenu?.listFoodByMenu?.isNotEmpty == true &&
              state.listFoodByMenu?.type == MenuType.unsuccessful &&
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
                      onPressed: (_) {},
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
                                    // bloc.deleteGroupTopping(listItem[index].id);
                                  }
                                  Get.back();
                                },
                                title: "Xoá sản phẩm",
                                listSubTitle: [
                                  "Bạn có muốn xoá sản phẩm ",
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
                        type: MenuType.unsuccessful,
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
                            listItem[index].name,
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
                ...List.generate(1, (inxDetail) {
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
                            Container(
                              width: 58,
                              height: 46,
                              decoration: BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            const HSpacing(spacing: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Cà phê pha máy siêu sạch",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const VSpacing(spacing: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("35.000 vnđ ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.colorD33)),
                                    Text("50.000 vnđ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: AppColors.color373,
                                                decoration: TextDecoration
                                                    .lineThrough)),
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
                                child: Container(
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.color988,
                                        border: Border.all(
                                            color: AppColors.colorD33,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Sửa",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              color: AppColors.colorD33),
                                    )),
                              ),
                              const HSpacing(spacing: 12),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.color988,
                                        border: Border.all(
                                            color: AppColors.color8E8,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Xoá",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                    )),
                              )
                            ],
                          ),
                        ),
                        const VSpacing(spacing: 8),
                        Text(
                          "*Hình ảnh sản phẩm không hợp lệ",
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

class _GroupToppingWidget extends StatelessWidget {
  final MenuDinerState state;
  final MenuDinerCubit bloc;

  const _GroupToppingWidget({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          width: double.infinity,
          color: AppColors.colorAFA,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: List.generate(ToppingType.values.length, (index) {
                  final item = ToppingType.values[index];
                  final titleCount = state.listTopping
                          ?.where((e) => e.type == item)
                          .toList()
                          .firstOrNull
                          ?.data
                          ?.length ??
                      0;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        bloc.changeGroupTopping(index, item);
                      },
                      child: Text(
                        item.title.replaceAll(RegExp(r'#VALUE'), '$titleCount'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: item == state.toppingType
                                ? AppColors.color988
                                : AppColors.textGray),
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
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PageView.builder(
                itemCount: ToppingType.values.length,
                physics: const NeverScrollableScrollPhysics(),
                controller: bloc.groupToppingController,
                itemBuilder: (context, index) {
                  final item = ToppingType.values[index];
                  final data = state.listTopping
                      ?.where((e) => e.type == item)
                      .toList()
                      .firstOrNull
                      ?.data;
                  if (data?.isNotEmpty == true) {
                    switch (item) {
                      case ToppingType.active:
                        return _ToppingActiveBody(
                          bloc: bloc,
                          listItem: data!,
                        );
                      case ToppingType.notRegistered:
                        return _ToppingNotRegisteredBody(
                          bloc: bloc,
                          listItem: data!,
                        );
                    }
                  }
                  return const _ToppingEmptyBody();
                }),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0.3,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.menuCustomTopping)?.then((value) {
                if (value) {
                  bloc.getAllTopping();
                }
              });
            },
            child: Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.color988,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "Thêm nhóm topping",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ToppingEmptyBody extends StatelessWidget {
  const _ToppingEmptyBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: context.height / 2.5,
          child: const AspectRatio(
              aspectRatio: 207 / 316,
              child: ImageAssetWidget(image: AppAssets.imagesImgGrtopingEmpty)),
        ),
        Text("Quán của bạn chưa có nhóm topping nào!",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600, color: AppColors.colorD33),
            textAlign: TextAlign.center),
        const VSpacing(spacing: 8),
        Text(
          "Bạn cần tạo nhóm topping để khách hàng có thêm nhiều lựa chọn.",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500, color: AppColors.textGray),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class _ToppingActiveBody extends StatelessWidget {
  final List<GrAddToppingResponse> listItem;
  final MenuDinerCubit bloc;

  const _ToppingActiveBody({required this.bloc, required this.listItem});

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

class _ToppingNotRegisteredBody extends StatelessWidget {
  final List<GrAddToppingResponse> listItem;
  final MenuDinerCubit bloc;

  const _ToppingNotRegisteredBody({required this.bloc, required this.listItem});

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
                          ?.copyWith(fontWeight: FontWeight.w700),
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
                                            isHide: false);
                                      }
                                      Get.back();
                                    },
                                    title: "Thay đổi trạng thái",
                                    listSubTitle: [
                                      "Bạn có chắc chắn muốn hiển thị nhóm topping ",
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
                              "Hiển thị",
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
                                        bloc.deleteGroupTopping(
                                            listItem[index].id);
                                      }
                                      Get.back();
                                    },
                                    title: "Thay đổi trạng thái",
                                    listSubTitle: [
                                      "Bạn có muốn xoá nhóm topping ",
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
                              "Xoá",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
