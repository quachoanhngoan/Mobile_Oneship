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
import 'package:oneship_merchant_app/presentation/page/register/register_page.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

import '../../../injector.dart';
import '../../data/model/menu/gr_topping_response.dart';
import '../../data/model/menu/list_menu_food_response.dart';
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
    return BlocBuilder<MenuDinerCubit, MenuDinerState>(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back, color: AppColors.black)),
              title: Text("Thực đơn",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      //search continue code
                    },
                    icon: const Icon(Icons.search_outlined,
                        color: AppColors.black))
              ],
            ),
            body: Column(
              children: <Widget>[
                Row(
                  children: List.generate(MenuMainType.values.length, (index) {
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
                                          fontWeight: state.menuMainType == item
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
                                listItem: data!, state: state);
                          case MenuType.pendingApproval:
                            return _MenuPendingApprove(
                                listItem: data!, state: state);
                          case MenuType.unsuccessful:
                            return _MenuItemUnSuccess(
                                listItem: data!, state: state);
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
                      // Get.toNamed(AppRoutes.menuCustomTopping);
                    },
                    child: Container(
                      // width: double.infinity,
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
                            fontWeight: FontWeight.w600,
                            color: AppColors.color988),
                      ),
                    ),
                  ),
                ),
                const HSpacing(spacing: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Get.toNamed(AppRoutes.menuCustomTopping);
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
                            fontWeight: FontWeight.w600,
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
  const _MenuEmptyBody({super.key});

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
                        onPressed: (_) {},
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
                  return _CardDetailMenu(item: item);
                })
              ]
            ],
          );
        });
  }
}

class _CardDetailMenu extends StatelessWidget {
  final Widget? actionWidget;
  final MenuFoodResponseItem item;
  const _CardDetailMenu({this.actionWidget, required this.item});

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
                final itemAction = StatisticMenuType.values[index];
                var valueAction = "";
                switch (itemAction) {
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
                                  image: itemAction.icon,
                                  width: 14,
                                  height: 14,
                                  color: AppColors.color373),
                            ),
                            const HSpacing(spacing: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  itemAction.title,
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
                              // height: 36,
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
          actionWidget ??
              SizedBox(
                height: 40,
                child: Row(
                  children: List.generate(DetailMenuActionType.values.length,
                      (index) {
                    final item = DetailMenuActionType.values[index];
                    return Expanded(
                      flex: item == DetailMenuActionType.more ? 2 : 5,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right:
                                DetailMenuActionType.values.length - 1 != index
                                    ? 8
                                    : 0),
                        child: Container(
                            alignment: Alignment.center,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.transparent,
                                border: Border.all(
                                    color: item.colorBorder, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: item.title != null
                                ? Text(
                                    item.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: item.colorText),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Icon(
                                      Icons.more_horiz_rounded,
                                      size: 16,
                                    ),
                                  )),
                      ),
                    );
                  }),
                ),
              )
        ],
      ),
    );
  }
}

class _MenuNotRegisteredBody extends StatelessWidget {
  final List<ItemLinkFood> listItem;
  final MenuDinerState state;
  const _MenuNotRegisteredBody({required this.listItem, required this.state});

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
                      onPressed: (_) {},
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
                      onPressed: (_) {},
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
                  onTap: () {},
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
                  return _CardDetailMenu(item: itemDetail);
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
  const _MenuPendingApprove({required this.listItem, required this.state});

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
                onTap: () {},
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
  const _MenuItemUnSuccess({required this.listItem, required this.state});

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
                      onPressed: (_) {},
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
                  onTap: () {},
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
  const _GroupToppingWidget(
      {super.key, required this.bloc, required this.state});

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
  const _ToppingEmptyBody({super.key});

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
                                    listSubTitle: const [
                                      "Bạn có chắc chắn muốn ẩn nhóm topping ",
                                      "\"Lượng đường\"",
                                      " trên ứng dụng khách hàng không"
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
                                    listSubTitle: const [
                                      "Bạn có chắc chắn muốn hiển thị nhóm topping ",
                                      "\"Lượng đường\"",
                                      " trên ứng dụng khách hàng không"
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
                              "Hiện thị",
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
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
