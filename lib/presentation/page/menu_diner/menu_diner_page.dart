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
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/grtopping_active_body.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/grtopping_empty_body.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/grtopping_not_register.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/menu_active_body.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/menu_empty_body.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/menu_not_register.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/menu_pending_approve.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/menu_unsuccess.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/text_field_base.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/text_field_search.dart';

import '../../../injector.dart';
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
          if (state.editNameGroupSuccess) {
            context.popScreen();
            context.showToastDialog("Sửa tên nhóm thành công");
            bloc.getAllMenu();
          }
          if (state.errorRemoveGroup) {
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
          }
          if (state.detailFoodData != null) {
            context.pushWithNamed(context,
                routerName: AppRoutes.menuDishsCustomPage,
                arguments: state.detailFoodData, complete: (value) {
              if (value) {
                bloc.getAllMenu();
              }
            });
          }
        },
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Scaffold(
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      VSpacing(spacing: state.isShowSearch ? 12 : 0),
                      Row(
                        children: <Widget>[
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.arrow_back,
                                  color: AppColors.black)),
                          if (state.isShowSearch) ...[
                            Expanded(
                                child: TextFieldSearch(
                                    onChange: (value) {
                                      bloc.searchFoodByMenu(value);
                                    },
                                    clearTextClicked: () {},
                                    hintText: "Tìm kiếm tên sản phẩm")),
                            const HSpacing(spacing: 12)
                          ] else ...[
                            Expanded(
                              child: Text("Thực đơn",
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
                            const HSpacing(spacing: 8),
                            const ImageAssetWidget(
                              image: AppAssets.imagesIconsIcFile,
                              width: 24,
                              height: 24,
                            ),
                            const HSpacing(spacing: 12),
                          ]
                        ],
                      ),
                      VSpacing(spacing: state.isShowSearch ? 12 : 0),
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
                                                color:
                                                    state.menuMainType == item
                                                        ? AppColors.color988
                                                        : AppColors.textGray,
                                                fontWeight:
                                                    state.menuMainType == item
                                                        ? FontWeight.w600
                                                        : FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          state.menuMainType == item ? 3 : 1,
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
                          ?.firstWhereOrNull((e) => e.type == item)
                          ?.totalProducts
                          .toString()
                          .padLeft(2, "0");
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
                            return MenuActiveBody(
                                listItem: data!, bloc: bloc, state: state);
                          case MenuType.notRegistered:
                            return MenuNotRegisteredBody(
                                listItem: data!, state: state, bloc: bloc);
                          case MenuType.pendingApproval:
                            return MenuPendingApprove(
                                listItem: data!, state: state, bloc: bloc);
                          case MenuType.unsuccessful:
                            return MenuItemUnSuccess(
                                listItem: data!, state: state, bloc: bloc);
                        }
                      }
                      return const MenuEmptyBody();
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

class CardDetailMenu extends StatelessWidget {
  final Widget actionWidget;
  final bool isActive;
  final MenuFoodResponseItem item;

  const CardDetailMenu(
      {super.key,
      required this.actionWidget,
      required this.item,
      this.isActive = true});

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

class EmptySearchMenu extends StatelessWidget {
  const EmptySearchMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const ImageAssetWidget(
        image: AppAssets.imagesImgEmptySearch,
        fit: BoxFit.fitWidth,
      ),
    );
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
                        return ToppingActiveBody(
                          bloc: bloc,
                          listItem: data!,
                        );
                      case ToppingType.notRegistered:
                        return ToppingNotRegisteredBody(
                          bloc: bloc,
                          listItem: data!,
                        );
                    }
                  }
                  return const ToppingEmptyBody();
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
