import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_select.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom_state.dart';

import '../../../config/theme/color.dart';
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
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToppingCustomCubit, ToppingCustomState>(
        bloc: bloc,
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
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PageView(
                    controller: bloc.pageController,
                    onPageChanged: (value) {
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
                      if (state.isButtonNextEnable()) {}
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: state.isButtonNextEnable()
                                ? AppColors.white
                                : AppColors.colorA4A),
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

class _AddGroupTopping extends StatelessWidget {
  final ToppingCustomCubit bloc;
  final ToppingCustomState state;
  const _AddGroupTopping({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const VSpacing(spacing: 12),
        AppTextFormField(
            hintText: "Nhập tên nhóm topping của bạn",
            controller: bloc.nameGroupToppingController,
            onChanged: (value) {
              bloc.checkFilledInfomation();
            },
            isRequired: true,
            suffix: IconButton(
                onPressed: () {
                  bloc.nameGroupToppingController.clear();
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 16,
                  color: AppColors.black.withOpacity(0.6),
                ))),
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
                        index == 0 ? "Bắt chuộc chọn 1" : "Khách hàng tuỳ chọn",
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
        AppTextFormFieldSelect(
          controller: bloc.linkFoodController,
          enabled: false,
          isRequired: true,
          hintText: "Chọn món liên kết",
          onChanged: (value) {
            bloc.checkFilledInfomation();
          },
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (_) {
                  return const _LinkedFoodSheet();
                });
          },
          suffixIcon: const Icon(Icons.expand_more,
              color: AppColors.color2B3, size: 24),
        ),
        const VSpacing(spacing: 24),
        GestureDetector(
          onTap: () {
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
                const Icon(Icons.add_outlined, size: 20),
                Text(
                  "Thêm topping",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.colorD33),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _LinkedFoodSheet extends StatelessWidget {
  const _LinkedFoodSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.color6F6,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      child: Column(
        children: <Widget>[
          Text(
            "Món liên kết",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const VSpacing(spacing: 8)
        ],
      ),
    );
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
        AppTextFormField(
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
        AppTextFormField(
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
