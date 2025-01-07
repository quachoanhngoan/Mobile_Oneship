import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/dashed_divider.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_select.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/domain/topping_item_domain.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom_state.dart';

import '../../../config/theme/color.dart';
import '../../data/model/menu/linkfood_response.dart';
import '../login/widget/loading_widget.dart';
import '../register_store/widget/app_text_form_field.dart';

class ToppingCustomPage extends StatefulWidget {
  const ToppingCustomPage({super.key});

  @override
  State<ToppingCustomPage> createState() => _ToppingCustomPageState();
}

class _ToppingCustomPageState extends State<ToppingCustomPage> {
  late ToppingCustomCubit bloc;

  @override
  void initState() {
    bloc = injector.get<ToppingCustomCubit>();
    bloc.init(topping: Get.arguments);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    return BlocConsumer<ToppingCustomCubit, ToppingCustomState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.isCompleteSuccess == true) {
            Get.back(result: true);
            context.showToastDialog(arg != null
                ? "Sửa topping thành công"
                : "Tạo topping thành công");
          }
          if (state.showErrorComplete != null) {
            context.showErrorDialog(state.showErrorComplete!, context,
                subtitle: "Vui lòng nhập tên khác.");
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    bloc.previousStepPage();
                  },
                  icon: const Icon(Icons.arrow_back, color: AppColors.black)),
              title: Text(state.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ),
            body: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PageView(
                        controller: bloc.pageController,
                        onPageChanged: (value) {
                          FocusScope.of(context).unfocus();
                          bloc.pageChange(value);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          _AddGroupTopping(bloc: bloc, state: state),
                          _AddTopping(bloc: bloc, state: state),
                        ],
                      ),
                    )),
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
                Visibility(
                  visible: state.isLoading,
                  child: const LoadingWidget(),
                )
              ],
            ),
          );
        });
  }
}

class _AddGroupTopping extends StatelessWidget {
  final ToppingCustomCubit bloc;
  final ToppingCustomState state;
  const _AddGroupTopping({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const VSpacing(spacing: 12),
          RegisterStoreFormField(
              hintText: "Nhập tên nhóm topping của bạn",
              controller: bloc.nameGroupToppingController,
              onChanged: (value) {
                bloc.checkFilledInfomation();
              },
              isRequired: true,
              suffix: state.isShowClearName
                  ? IconButton(
                      onPressed: () {
                        bloc.nameGroupToppingController.clear();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 16,
                        color: AppColors.black.withOpacity(0.6),
                      ))
                  : const SizedBox.shrink()),
          const VSpacing(spacing: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(2, (index) {
                return GestureDetector(
                  onTap: () {
                    bloc.changeTypeOptionTopping(index);
                  },
                  child: Container(
                    color: AppColors.transparent,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: state.indexOptionTopping == index
                                  ? AppColors.colorFF9
                                  : AppColors.transparent,
                              border: Border.all(
                                  color: state.indexOptionTopping == index
                                      ? AppColors.color05C
                                      : AppColors.color5DD,
                                  width: 1)),
                          padding: const EdgeInsets.all(4),
                          child: state.indexOptionTopping == index
                              ? Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.color05C),
                                )
                              : Container(),
                        ),
                        const HSpacing(spacing: 6),
                        Text(
                          index == 0
                              ? "Bắt chuộc chọn 1"
                              : "Khách hàng tuỳ chọn",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                );
              })),
          const VSpacing(spacing: 24),
          Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              SizedBox(
                height: 36,
                child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 4),
                    itemCount: state.listIdLinkFoodSellected.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = state.listIdLinkFoodSellected[index];
                      final nameItem = state.listLinkFood
                          .firstWhereOrNull((e) => e.id == item.id)
                          ?.name;
                      if (nameItem != null) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color: AppColors.color880.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            children: <Widget>[
                              Text(
                                nameItem,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.color988,
                                    ),
                              ),
                              const HSpacing(spacing: 4),
                              const Icon(Icons.clear,
                                  color: AppColors.color988, size: 16)
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
              ),
              AppTextFormFieldSelect(
                controller: bloc.linkFoodController,
                enabled: false,
                isRequired: false,
                hintText: state.listIdLinkFoodSellected.isNotEmpty
                    ? ""
                    : "Chọn món liên kết",
                onChanged: (value) {
                  bloc.checkFilledInfomation();
                },
                onTap: () {
                  if (state.listLinkFood.isNotEmpty) {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return _LinkedFoodSheet(
                            listItem: state.listLinkFood,
                            bloc: bloc,
                          );
                        });
                  }
                },
                suffixIcon: state.listIdLinkFoodSellected.isNotEmpty
                    ? const SizedBox.shrink()
                    : const Icon(Icons.expand_more,
                        color: AppColors.color2B3, size: 24),
              ),
            ],
          ),
          const VSpacing(spacing: 24),
          GestureDetector(
            onTap: () {
              bloc.setArgEditTopping(false);
              bloc.nextPage();
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.colorD33),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.add_outlined,
                      size: 20, color: AppColors.colorD33),
                  Text(
                    "Thêm topping",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.colorD33),
                  )
                ],
              ),
            ),
          ),
          const VSpacing(spacing: 20),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.listTopping.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = state.listTopping[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.color8E8),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            item.name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(item.price ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.colorD33))
                        ],
                      ),
                      const VSpacing(spacing: 4),
                      IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: item.type == StatusToppingType.isUnused
                                  ? AppColors.color8E8
                                  : AppColors.background),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        item.type == StatusToppingType.isUnused
                                            ? AppColors.textGray
                                            : AppColors.color988),
                              ),
                              const HSpacing(spacing: 6),
                              Text(item.type.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: item.type ==
                                                  StatusToppingType.isUnused
                                              ? AppColors.textGray
                                              : AppColors.color988)),
                            ],
                          ),
                        ),
                      ),
                      const VSpacing(spacing: 8),
                      const DashedDivider(color: AppColors.color8E8),
                      const VSpacing(spacing: 12),
                      SizedBox(
                        height: 40,
                        child: item.type == StatusToppingType.isUnused
                            ? Row(
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
                                                    bloc.changeStatusTopping(
                                                        item);
                                                  }
                                                  Get.back();
                                                },
                                                title: "Thay đổi trạng thái",
                                                listSubTitle: [
                                                  "Bạn có chắc chắn muốn hiển thị topping ",
                                                  "\"${item.name}\"",
                                                  " trên ứng dụng khách hàng không ?"
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.transparent,
                                            border: Border.all(
                                                color: AppColors.color8E8)),
                                        child: Text(
                                          "Hiển thị",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const HSpacing(spacing: 12),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        bloc.setArgEditTopping(true);
                                        bloc.editTopping(item);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.transparent,
                                            border: Border.all(
                                                color: AppColors.colorD33)),
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
                                                    bloc.removeTopping(item);
                                                  }
                                                  Get.back();
                                                },
                                                title: "Xoá topping",
                                                listSubTitle: [
                                                  "Bạn có muốn xoá topping ",
                                                  "\"${item.name}\"",
                                                  " không?"
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.transparent,
                                            border: Border.all(
                                                color: AppColors.color8E8)),
                                        child: Text(
                                          "Xoá",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
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
                                                    bloc.changeStatusTopping(
                                                        item);
                                                  }
                                                  Get.back();
                                                },
                                                title: "Thay đổi trạng thái",
                                                listSubTitle: [
                                                  "Bạn có chắc chắn muốn ẩn nhóm topping ",
                                                  "\"${item.name}\"",
                                                  " trên ứng dụng khách hàng không ?"
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.transparent,
                                            border: Border.all(
                                                color: AppColors.color8E8)),
                                        child: Text(
                                          "Ẩn",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const HSpacing(spacing: 12),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        bloc.setArgEditTopping(true);
                                        bloc.editTopping(item);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.transparent,
                                            border: Border.all(
                                                color: AppColors.colorD33)),
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
              })
        ],
      ),
    );
  }
}

class DialogChangeStatus extends StatelessWidget {
  final String title;
  final List<String> listSubTitle;
  final Function(bool) done;
  final Widget? action;
  const DialogChangeStatus(
      {super.key,
      required this.listSubTitle,
      required this.title,
      required this.done,
      this.action});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.transparent,
      child: Container(
        // padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const VSpacing(spacing: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const VSpacing(spacing: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                    children: List.generate(listSubTitle.length, (index) {
                  return TextSpan(
                      text: listSubTitle[index],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: index % 2 == 0
                              ? FontWeight.w500
                              : FontWeight.w700));
                })),
                textAlign: TextAlign.center,
              ),
            ),
            const VSpacing(spacing: 16),
            const Divider(thickness: 1.5, height: 1),
            action ??
                SizedBox(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          done(false);
                        },
                        child: Text(
                          "Huỷ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      const VerticalDivider(thickness: 1.5, width: 1),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          done(true);
                        },
                        child: Text(
                          "OK",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.color988),
                          textAlign: TextAlign.center,
                        ),
                      )),
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}

class _LinkedFoodSheet extends StatefulWidget {
  final List<ItemLinkFood> listItem;
  final ToppingCustomCubit bloc;
  const _LinkedFoodSheet({required this.listItem, required this.bloc});

  @override
  State<_LinkedFoodSheet> createState() => _LinkedFoodSheetState();
}

class _LinkedFoodSheetState extends State<_LinkedFoodSheet> {
  late ToppingCustomCubit _bloc;

  @override
  initState() {
    _bloc = widget.bloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToppingCustomCubit, ToppingCustomState>(
        bloc: _bloc,
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
                color: AppColors.color6F6,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            child: Column(
              children: <Widget>[
                const VSpacing(spacing: 12),
                Text(
                  "Món liên kết",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const VSpacing(spacing: 12),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.listItem.length,
                      itemBuilder: (context, index) {
                        final isSellectMainId = state.listIdLinkFoodSellected
                                .firstWhereOrNull(
                                    (e) => e.id == widget.listItem[index].id) !=
                            null;
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _bloc.listIdLinkFoodSellect(
                                      widget.listItem[index].id,
                                      isAll: true);
                                },
                                child: Container(
                                  color: AppColors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                            color: isSellectMainId
                                                ? AppColors.color988
                                                : AppColors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: isSellectMainId
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
                                        "${widget.listItem[index].name}(${widget.listItem[index].products!.length})",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        widget.listItem[index].products
                                                    ?.isNotEmpty ==
                                                true
                                            ? Icons.keyboard_arrow_down_outlined
                                            : Icons
                                                .keyboard_arrow_right_outlined,
                                        color: AppColors.color988,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              widget.listItem[index].products?.isNotEmpty ==
                                      true
                                  ? const VSpacing(spacing: 12)
                                  : Container(),
                              if (widget.listItem[index].products?.isNotEmpty ==
                                  true) ...[
                                ...List.generate(
                                    widget.listItem[index].products!.length,
                                    (inxChild) {
                                  final childItem = widget
                                      .listItem[index].products![inxChild];
                                  final isSellectChildId = state
                                          .listIdLinkFoodSellected
                                          .firstWhereOrNull(
                                              (e) => e.id == childItem.id) !=
                                      null;
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            _bloc.listIdLinkFoodSellect(
                                                childItem.id);
                                          },
                                          child: Container(
                                            color: AppColors.transparent,
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 16,
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                      color: isSellectChildId
                                                          ? AppColors.color988
                                                          : AppColors
                                                              .transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: isSellectChildId
                                                              ? AppColors
                                                                  .transparent
                                                              : AppColors
                                                                  .textGray,
                                                          width: 1)),
                                                  child: const Icon(
                                                    Icons.check_outlined,
                                                    color: AppColors.white,
                                                    size: 12,
                                                  ),
                                                ),
                                                const HSpacing(spacing: 8),
                                                Text(
                                                  childItem.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        widget.listItem[index].products!
                                                        .length -
                                                    1 !=
                                                inxChild
                                            ? const Divider(
                                                color: AppColors.textGray,
                                                height: 1,
                                                thickness: 1)
                                            : Container()
                                      ],
                                    ),
                                  );
                                })
                              ]
                            ],
                          ),
                        );
                      }),
                ),
                const VSpacing(spacing: 8),
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
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: AppColors.color988)),
                              child: Text(
                                "Huỷ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
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
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.color988,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Xác nhận",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          );
        });
  }
}

class _AddTopping extends StatelessWidget {
  final ToppingCustomCubit bloc;
  final ToppingCustomState state;
  const _AddTopping({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RegisterStoreFormField(
            hintText: "Tên topping",
            controller: bloc.nameToppingController,
            onChanged: (value) {
              bloc.validateNameTopping(value);
              bloc.checkFilledInfomation();
            },
            isRequired: true,
            errorText: state.errorNameTopping,
            suffix: state.isToppingClearButton
                ? IconButton(
                    onPressed: () {
                      bloc.nameToppingController.clear();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      size: 16,
                      color: AppColors.black.withOpacity(0.6),
                    ))
                : const SizedBox()),
        RegisterStoreFormField(
            hintText: "Giá bán",
            controller: bloc.priceController,
            onChanged: (value) {
              bloc.validatePriceTopping(value);
              bloc.checkFilledInfomation();
            },
            isRequired: true,
            inputFormatters: [
              CurrencyInputFormatter(trailingSymbol: ' vnđ', mantissaLength: 0)
            ],
            keyboardType: TextInputType.number,
            suffix: state.isPriceClearButton
                ? IconButton(
                    onPressed: () {
                      bloc.priceController.clear();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      size: 16,
                      color: AppColors.black.withOpacity(0.6),
                    ))
                : const SizedBox()),
      ],
    );
  }
}
