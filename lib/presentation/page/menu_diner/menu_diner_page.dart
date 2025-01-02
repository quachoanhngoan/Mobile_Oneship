import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/domain/menu_domain.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

import '../../../injector.dart';
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
                      ?.copyWith(fontWeight: FontWeight.w700)),
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
                                              ? FontWeight.w700
                                              : FontWeight.w600),
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
                                  item.title
                                      .replaceAll(RegExp(r'#VALUE'), '00'),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: item == state.menuType
                                              ? AppColors.color988
                                              : AppColors.textGray),
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
                      final type = MenuType.values[index];
                      switch (type) {
                        case MenuType.active:
                          return const _MenuActiveBody();
                        case MenuType.notRegistered:
                          return const _MenuNotRegisteredBody();
                        case MenuType.pendingApproval:
                          return const _MenuPendingApprove();
                        case MenuType.unsuccessful:
                          return const _MenuItemUnSuccess();
                      }
                      // return const _MenuEmptyBody();
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
                  fontWeight: FontWeight.w700, color: AppColors.colorD33),
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
  const _MenuActiveBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 9,
        itemBuilder: (context, index) {
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
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      color: AppColors.white,
                      height: 52,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Thạch dừa (01)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_right,
                              color: AppColors.black)
                        ],
                      ),
                    ),
                  )),
              // ...List.generate(4, (inxDetail) {
              //   return const _CardDetailMenu();
              // })
            ],
          );
        });
  }
}

class _CardDetailMenu extends StatelessWidget {
  final Widget? actionWidget;
  const _CardDetailMenu({super.key, this.actionWidget});

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
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.colorD33)),
                      Text("50.000 vnđ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: AppColors.color373,
                                  decoration: TextDecoration.lineThrough)),
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
                final item = StatisticMenuType.values[index];
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
                                  image: item.icon,
                                  width: 14,
                                  height: 14,
                                  color: AppColors.color373),
                            ),
                            const HSpacing(spacing: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.title,
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
                                  "1917",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w700,
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
                                color: AppColors.color988,
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
                                            fontWeight: FontWeight.w700,
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
  const _MenuNotRegisteredBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
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
                            "Thạch dừa (01)",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right,
                            color: AppColors.black)
                      ],
                    ),
                  ),
                ),
              ),
              // ...List.generate(1, (inxDetail) {
              //   return const _CardDetailMenu();
              // })
            ],
          );
        });
  }
}

class _MenuPendingApprove extends StatelessWidget {
  const _MenuPendingApprove({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
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
                          "Thạch dừa (01)",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right,
                          color: AppColors.black)
                    ],
                  ),
                ),
              ),
              // ...List.generate(1, (inxDetail) {
              //   return _CardDetailMenu(
              //     actionWidget: Text(
              //       "*Sản phẩm đang chờ hệ thống duyệt",
              //       style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //           fontSize: 12,
              //           color: AppColors.colorDE6,
              //           fontStyle: FontStyle.italic),
              //     ),
              //   );
              // })
            ],
          );
        });
  }
}

class _MenuItemUnSuccess extends StatelessWidget {
  const _MenuItemUnSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
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
                            "Thạch dừa (01)",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right,
                            color: AppColors.black)
                      ],
                    ),
                  ),
                ),
              ),
              // ...List.generate(1, (inxDetail) {
              //   return Container(
              //     decoration: BoxDecoration(
              //       color: AppColors.white,
              //       borderRadius: BorderRadius.circular(8),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.1),
              //           spreadRadius: 1,
              //           blurRadius: 2,
              //           offset: const Offset(0, 0),
              //         ),
              //       ],
              //     ),
              //     padding: const EdgeInsets.all(12),
              //     margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Row(
              //           children: <Widget>[
              //             Container(
              //               width: 58,
              //               height: 46,
              //               decoration: BoxDecoration(
              //                   color: AppColors.red,
              //                   borderRadius: BorderRadius.circular(8)),
              //             ),
              //             const HSpacing(spacing: 8),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: <Widget>[
              //                 Text(
              //                   "Cà phê pha máy siêu sạch",
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodySmall
              //                       ?.copyWith(fontWeight: FontWeight.w600),
              //                 ),
              //                 const VSpacing(spacing: 4),
              //                 Row(
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: <Widget>[
              //                     Text("35.000 vnđ ",
              //                         style: Theme.of(context)
              //                             .textTheme
              //                             .bodyMedium
              //                             ?.copyWith(
              //                                 fontWeight: FontWeight.w700,
              //                                 color: AppColors.colorD33)),
              //                     Text("50.000 vnđ",
              //                         style: Theme.of(context)
              //                             .textTheme
              //                             .bodySmall
              //                             ?.copyWith(
              //                                 fontWeight: FontWeight.w400,
              //                                 fontSize: 10,
              //                                 color: AppColors.color373,
              //                                 decoration:
              //                                     TextDecoration.lineThrough)),
              //                   ],
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //         const VSpacing(spacing: 8),
              //         const DashedDivider(
              //           color: AppColors.color8E8,
              //         ),
              //         const VSpacing(spacing: 8),
              //         SizedBox(
              //           height: 40,
              //           child: Row(
              //             children: <Widget>[
              //               Expanded(
              //                 child: Container(
              //                     alignment: Alignment.center,
              //                     height: double.infinity,
              //                     decoration: BoxDecoration(
              //                         color: AppColors.color988,
              //                         border: Border.all(
              //                             color: AppColors.colorD33, width: 1),
              //                         borderRadius: BorderRadius.circular(8)),
              //                     child: Text(
              //                       "Sửa",
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .bodySmall
              //                           ?.copyWith(
              //                               fontWeight: FontWeight.w700,
              //                               fontSize: 12,
              //                               color: AppColors.colorD33),
              //                     )),
              //               ),
              //               const HSpacing(spacing: 12),
              //               Expanded(
              //                 child: Container(
              //                     alignment: Alignment.center,
              //                     height: double.infinity,
              //                     decoration: BoxDecoration(
              //                         color: AppColors.color988,
              //                         border: Border.all(
              //                             color: AppColors.color8E8, width: 1),
              //                         borderRadius: BorderRadius.circular(8)),
              //                     child: Text(
              //                       "Xoá",
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .bodySmall
              //                           ?.copyWith(
              //                               fontWeight: FontWeight.w700,
              //                               fontSize: 12),
              //                     )),
              //               )
              //             ],
              //           ),
              //         ),
              //         const VSpacing(spacing: 8),
              //         Text(
              //           "*Hình ảnh sản phẩm không hợp lệ",
              //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //               fontSize: 12,
              //               color: AppColors.colorB30,
              //               fontStyle: FontStyle.italic),
              //         )
              //       ],
              //     ),
              //   );
              // })
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
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        bloc.changeGroupTopping(index, item);
                      },
                      child: Text(
                        item.title.replaceAll(RegExp(r'#VALUE'), '00'),
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
          child: PageView.builder(
              itemCount: ToppingType.values.length,
              controller: bloc.groupToppingController,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const _ToppingActiveBody();
                  case 1:
                    return const _ToppingNotRegisteredBody();
                }
                return const _ToppingEmptyBody();
              }),
          //     child: Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: const _ToppingNotRegisteredBody(),
          // ),
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
              Get.toNamed(AppRoutes.menuCustomTopping);
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
                fontWeight: FontWeight.w700, color: AppColors.colorD33),
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
  const _ToppingActiveBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
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
                      "Chọn size",
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
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.transparent,
                              border: Border.all(color: AppColors.color8E8)),
                          child: Text(
                            "Hiện",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
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
  const _ToppingNotRegisteredBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
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
                      "Chọn size",
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
                      const HSpacing(spacing: 12),
                      Expanded(
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
