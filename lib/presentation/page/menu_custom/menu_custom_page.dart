import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/page/menu_custom/menu_custom_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_custom/menu_custom_state.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_select.dart';

import '../login/widget/loading_widget.dart';

class MenuCustomPage extends StatefulWidget {
  const MenuCustomPage({super.key});

  @override
  State<MenuCustomPage> createState() => _MenuCustomPageState();
}

class _MenuCustomPageState extends State<MenuCustomPage> {
  late MenuCustomCubit bloc;

  @override
  void initState() {
    bloc = injector.get<MenuCustomCubit>();
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCustomCubit, MenuCustomState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.isCompleteSuccess) {
            context.popScreen(result: true);
            context.showToastDialog("Thêm danh mục thành công");
          }
          if (state.isCompleteError != null) {
            context.showErrorDialog(state.isCompleteError!, context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        context.popScreen();
                      },
                      icon:
                          const Icon(Icons.arrow_back, color: AppColors.black)),
                  title: Text("Thêm mới danh mục",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ),
                body: Column(
                  children: <Widget>[
                    const VSpacing(spacing: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration:
                          const BoxDecoration(color: AppColors.background),
                      child: Text(
                        "Vui lòng chọn danh mục GOO+ để phân loại các món trên trang chủ của ứng dụng khách hàng và chọn danh mục quán để hiển thị trên trang chủ của quán.",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const VSpacing(spacing: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppTextFormFieldSelect(
                          isRequired: true,
                          hintText: "Danh mục GOO+",
                          controller: bloc.gooCategoryController,
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return _ListCategoryGoo(bloc: bloc);
                                });
                          },
                          suffixIcon: state.isShowGooCategoryClear
                              ? IconButton(
                                  onPressed: () {
                                    bloc.gooCategoryController.clear();
                                    bloc.checkFilledInfo();
                                  },
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    size: 16,
                                    color: AppColors.black.withOpacity(0.6),
                                  ))
                              : const Icon(Icons.expand_more,
                                  color: AppColors.color2B3, size: 24)),
                    ),
                    const VSpacing(spacing: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          bloc.sellectCommonGooMenu();
                        },
                        child: Container(
                          color: AppColors.transparent,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    color: state.isSellectCheckBox
                                        ? AppColors.color988
                                        : AppColors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: state.isSellectCheckBox
                                            ? AppColors.transparent
                                            : AppColors.textGray,
                                        width: 1)),
                                child: const Icon(
                                  Icons.check_outlined,
                                  color: AppColors.white,
                                  size: 12,
                                ),
                              ),
                              const HSpacing(spacing: 8),
                              Text(
                                "Dùng chung danh mục GOO+ cho quán",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColors.color054,
                                        fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const VSpacing(spacing: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppTextFormField(
                          isRequired: true,
                          hintText: "Danh mục quán",
                          controller: bloc.storeCategorController,
                          onChanged: (value) {
                            bloc.checkFilledInfo();
                          },
                          suffix: state.isShowStoreCategorClear
                              ? IconButton(
                                  onPressed: () {
                                    bloc.storeCategorController.clear();
                                    bloc.checkFilledInfo();
                                  },
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    size: 16,
                                    color: AppColors.black.withOpacity(0.6),
                                  ))
                              : const SizedBox.shrink()),
                    ),
                    const Spacer(),
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
                          if (state.isButtonNextEnable()) {
                            bloc.saveInfoClick();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: state.isButtonNextEnable()
                                  ? AppColors.color988
                                  : AppColors.color8E8,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Lưu thông tin",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: state.isButtonNextEnable()
                                        ? AppColors.white
                                        : AppColors.colorA4A),
                          ),
                        ),
                      ),
                    )
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

class _ListCategoryGoo extends StatefulWidget {
  final MenuCustomCubit bloc;
  const _ListCategoryGoo({super.key, required this.bloc});

  @override
  State<_ListCategoryGoo> createState() => __ListCategoryGooState();
}

class __ListCategoryGooState extends State<_ListCategoryGoo> {
  late MenuCustomCubit _bloc;

  @override
  void initState() {
    _bloc = widget.bloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCustomCubit, MenuCustomState>(
        bloc: _bloc,
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Column(
              children: <Widget>[
                const VSpacing(spacing: 12),
                Text("Danh mục GOO+",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const VSpacing(spacing: 12),
                Expanded(
                  child: state.listCategoryGlobal != null &&
                          state.listCategoryGlobal!.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.listCategoryGlobal!.length,
                          itemBuilder: (context, index) {
                            final item = state.listCategoryGlobal![index];
                            final isSellected =
                                state.categorySellectGlobal == item;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  const VSpacing(spacing: 12),
                                  GestureDetector(
                                    onTap: () {
                                      _bloc.sellectCategoryGoo(item);
                                    },
                                    child: Container(
                                      color: AppColors.transparent,
                                      child: Row(
                                        children: <Widget>[
                                          const HSpacing(spacing: 16),
                                          Container(
                                            width: 16,
                                            height: 16,
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.transparent,
                                                border: Border.all(
                                                  color: AppColors.textGray,
                                                )),
                                            child: isSellected
                                                ? Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppColors.textGray,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                          const HSpacing(spacing: 8),
                                          Text(
                                            item.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const VSpacing(spacing: 4),
                                  Divider(
                                    color: AppColors.textGray.withOpacity(0.3),
                                    thickness: 1,
                                  )
                                ],
                              ),
                            );
                          })
                      : Container(),
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
                      _bloc.confirmSellectCategoryGoo();
                      context.popScreen();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.color988,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Xác nhận",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
