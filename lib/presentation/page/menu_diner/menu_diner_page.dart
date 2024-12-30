import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/home/home_page.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/domain/menu_domain.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

import 'widgets/dashed_divider.dart';

class MenuDinerPage extends StatefulWidget {
  const MenuDinerPage({super.key});

  @override
  State<MenuDinerPage> createState() => _MenuDinerPageState();
}

class _MenuDinerPageState extends State<MenuDinerPage> {
  late PageController controller;

  int indexPage = 0;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              icon: const Icon(Icons.search_outlined, color: AppColors.black))
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: List.generate(MenuMainType.values.length, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  child: Container(
                    color: AppColors.transparent,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 34,
                          child: Text(
                            MenuMainType.values[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: indexPage == index
                                        ? AppColors.color988
                                        : AppColors.textGray,
                                    fontWeight: indexPage == index
                                        ? FontWeight.w700
                                        : FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: indexPage == index ? 3 : 1,
                          color: indexPage == index
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
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                indexPage = value;
              });
            },
            children: const <Widget>[
              _MenuWidget(),
              _GroupToppingWidget(),
            ],
          ))
        ],
      ),
    );
  }
}

class _MenuWidget extends StatelessWidget {
  const _MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
          width: double.infinity,
          child: ListView.builder(
              itemCount: MenuType.values.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: <Widget>[
                    IntrinsicWidth(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          MenuType.values[index].title
                              .replaceAll(RegExp(r'#VALUE'), '00'),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.textGray),
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
        )
      ],
    );
  }
}

class _GroupToppingWidget extends StatefulWidget {
  const _GroupToppingWidget({super.key});

  @override
  State<_GroupToppingWidget> createState() => _GroupToppingWidgetState();
}

class _GroupToppingWidgetState extends State<_GroupToppingWidget> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuDinerCubit, MenuDinerState>(
        builder: (context, state) {
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
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        child: Text(
                          ToppingType.values[index].title
                              .replaceAll(RegExp(r'#VALUE'), '00'),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: index == state.indexPageTopping
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
                controller: _pageController,
                onPageChanged: (value) {
                  context.read<MenuDinerCubit>().changePageTopping(value);
                },
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
    });
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
