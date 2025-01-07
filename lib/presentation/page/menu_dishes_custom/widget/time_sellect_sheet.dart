import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/page/menu_dishes_custom/menu_dishes_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_dishes_custom/model/time_sellect_type.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_select.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as timePicker;

import '../../../../config/theme/color.dart';
import '../menu_dishes_state.dart';

class TimeSellectSheet extends StatefulWidget {
  final MenuDishesCubit bloc;
  const TimeSellectSheet({super.key, required this.bloc});

  @override
  State<TimeSellectSheet> createState() => _TimeSellectSheetState();
}

class _TimeSellectSheetState extends State<TimeSellectSheet> {
  late MenuDishesCubit _bloc;

  @override
  void initState() {
    _bloc = widget.bloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuDishesCubit, MenuDishesState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state.errorTimeSellect != null) {
            context.showToastDialog(state.errorTimeSellect!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              leading: IconButton(
                  onPressed: () {
                    context.popScreen();
                  },
                  icon: const Icon(Icons.arrow_back, color: AppColors.black)),
              title: Text("Chọn thời gian",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: DateTimeSellectType.values.length,
                      padding: const EdgeInsets.only(bottom: 12),
                      itemBuilder: (context, index) {
                        final item = DateTimeSellectType.values[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.color054,
                                    ),
                              ),
                              const VSpacing(spacing: 4),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: AppTextFormFieldSelect(
                                    isRequired: false,
                                    controller:
                                        _bloc.getControllerStartByType(item),
                                    hintText: "Giờ bắt đầu",
                                    onTap: () {
                                      timePicker.DatePicker.showTimePicker(
                                        context,
                                        showSecondsColumn: false,
                                        locale: timePicker.LocaleType.vi,
                                        onConfirm: (value) {
                                          log("time start: $value");
                                          _bloc.compareStringTime(item,
                                              time: value);
                                        },
                                        theme: const timePicker.DatePickerTheme(
                                            doneStyle: TextStyle(
                                                color: AppColors.color988,
                                                fontSize: 16),
                                            cancelStyle: TextStyle(
                                                color: AppColors.textGray,
                                                fontSize: 16)),
                                      );
                                    },
                                    suffixIcon: const Icon(
                                      Icons.access_time_outlined,
                                      color: AppColors.color988,
                                      size: 12,
                                    ),
                                  )),
                                  const HSpacing(spacing: 16),
                                  Expanded(
                                      child: AppTextFormFieldSelect(
                                    isRequired: false,
                                    controller:
                                        _bloc.getControllerEndByType(item),
                                    hintText: "Giờ kết thúc",
                                    onTap: () {
                                      timePicker.DatePicker.showTimePicker(
                                        context,
                                        showSecondsColumn: false,
                                        locale: timePicker.LocaleType.vi,
                                        onConfirm: (value) {
                                          log("time end: $value");
                                          _bloc.compareStringTime(item,
                                              isSellectEnd: true, time: value);
                                        },
                                        theme: const timePicker.DatePickerTheme(
                                            doneStyle: TextStyle(
                                                color: AppColors.color988,
                                                fontSize: 16),
                                            cancelStyle: TextStyle(
                                                color: AppColors.textGray,
                                                fontSize: 16)),
                                      );
                                    },
                                    suffixIcon: const Icon(
                                      Icons.access_time_outlined,
                                      color: AppColors.color988,
                                      size: 12,
                                    ),
                                  ))
                                ],
                              )
                            ],
                          ),
                        );
                      }),
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
                      if (state.isButtonSaveTimeEnable()) {
                        _bloc.saveTimeSellect();
                        context.popScreen();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: state.isButtonSaveTimeEnable()
                              ? AppColors.color988
                              : AppColors.color8E8,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Lưu thông tin",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: state.isButtonSaveTimeEnable()
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
