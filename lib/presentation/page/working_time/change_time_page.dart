import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/dashed_divider.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_select.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/work_time_page.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/working_time/app_text_form_field_select.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field.dart';

class ChangeTimePage extends StatefulWidget {
  final WorkTimeModel param;
  const ChangeTimePage({super.key, required this.param});

  @override
  State<ChangeTimePage> createState() => _ChangeTimePageState();
}

class _ChangeTimePageState extends State<ChangeTimePage> {
  bool positive = false;

  List<WKT> data = [];

  @override
  void initState() {
    super.initState();
    data = List.from(widget.param.wkt);
    positive = widget.param.isOff ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarAuth(
          title: 'Lịch làm việc hàng ngày',
          isShowHelpButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.param.dayOfWeek ?? '',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            )),
                    Container(
                      color: Colors.transparent,
                      child: DefaultTextStyle.merge(
                        child: IconTheme.merge(
                            data: const IconThemeData(color: Colors.white),
                            child: AnimatedToggleSwitch<bool>.dual(
                              current: positive,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              inactiveOpacityDuration:
                                  const Duration(milliseconds: 100),
                              iconAnimationDuration:
                                  const Duration(milliseconds: 100),
                              styleAnimationType: AnimationType.onSelected,
                              first: false,
                              second: true,
                              clipBehavior: Clip.none,
                              spacing: 5.0,
                              animationCurve: Curves.easeInOut,
                              fittingMode: FittingMode.none,
                              style: const ToggleStyle(
                                borderColor: Colors.transparent,
                                indicatorColor: Colors.white,
                                backgroundColor: Colors.black,
                              ),
                              styleBuilder: (value) => ToggleStyle(
                                  backgroundColor: value
                                      ? Colors.green
                                      : Colors.grey.shade500),
                              borderWidth: 3.0,
                              indicatorSize: const Size.fromWidth(21.0),
                              height: 25.0,
                              loadingIconBuilder: (context, global) =>
                                  CupertinoActivityIndicator(
                                      color: Color.lerp(Colors.red[800],
                                          Colors.green, global.position)),
                              onChanged: (value) {
                                setState(() {
                                  positive = value;
                                });
                              },
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.borderColor2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Khung giờ mở cửa ${index + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary,
                                            )),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          data.removeAt(index);
                                        });
                                      },
                                      child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: ImageAssetWidget(
                                            image:
                                                AppAssets.imagesIconsTrashAlt,
                                            height: 22,
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.sp),
                                const DashedDivider(
                                  // Add this line
                                  color:
                                      AppColors.borderColor2, // Add this line
                                ), // Add this line
                                SizedBox(height: 5.sp),
                                AppTextFormFieldWorkTime(
                                    controller: data[index].openTimeController,
                                    isRequired: true,
                                    onTap: () async {
                                      final pickerTimer = await picker
                                          .DatePicker.showTimePicker(
                                        context,
                                        showTitleActions: true,
                                        onChanged: (date) {},
                                        onConfirm: (date) {},
                                        showSecondsColumn: false,
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.vi,
                                      );
                                      if (pickerTimer != null) {
                                        final getTimeHHMM = DateFormat('HH:mm')
                                            .format(pickerTimer);
                                        setState(() {
                                          data[index] = data[index].copyWith(
                                            openTimeStr: getTimeHHMM,
                                            openTime: pickerTimer.hour * 60 +
                                                pickerTimer.minute,
                                          );
                                        });
                                      }
                                    },
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            if (data[index]
                                                .openTimeController
                                                .text
                                                .isNotEmpty) {
                                              return GestureDetector(
                                                onTap: () {
                                                  data[index]
                                                      .openTimeController
                                                      .clear();
                                                  setState(() {});
                                                  data[index] =
                                                      data[index].copyWith(
                                                    openTimeStr: '',
                                                    openTime: -1,
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    const ImageAssetWidget(
                                                      image: AppAssets
                                                          .imagesIconsCloseOutline,
                                                      height: 15,
                                                    ),
                                                    SizedBox(width: 5.sp),
                                                  ],
                                                ),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        ),
                                        const ImageAssetWidget(
                                          image:
                                              AppAssets.imagesIconsClockEight,
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    hintText: 'Thời gian từ'),
                                const SizedBox(height: 10),
                                AppTextFormFieldWorkTime(
                                    controller: data[index].closeTimeController,
                                    onTap: () async {
                                      final pickerTimer = await picker
                                          .DatePicker.showTimePicker(
                                        context,
                                        showTitleActions: true,
                                        onChanged: (date) {},
                                        onConfirm: (date) {},
                                        showSecondsColumn: false,
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.vi,
                                      );
                                      if (pickerTimer != null) {
                                        final getTimeHHMM = DateFormat('HH:mm')
                                            .format(pickerTimer);
                                        setState(() {
                                          data[index] = data[index].copyWith(
                                            closeTimeStr: getTimeHHMM,
                                            closeTime: pickerTimer.hour * 60 +
                                                pickerTimer.minute,
                                          );
                                        });
                                      }
                                    },
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            if (data[index]
                                                .closeTimeController
                                                .text
                                                .isNotEmpty) {
                                              return GestureDetector(
                                                onTap: () {
                                                  data[index]
                                                      .closeTimeController
                                                      .clear();
                                                  setState(() {});
                                                  data[index] =
                                                      data[index].copyWith(
                                                    closeTimeStr: '',
                                                    closeTime: -1,
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    const ImageAssetWidget(
                                                      image: AppAssets
                                                          .imagesIconsCloseOutline,
                                                      height: 15,
                                                    ),
                                                    SizedBox(width: 5.sp),
                                                  ],
                                                ),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        ),
                                        const ImageAssetWidget(
                                          image:
                                              AppAssets.imagesIconsClockEight,
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    isRequired: true,
                                    hintText: 'Thời gian đến'),
                              ],
                            ),
                          );
                        }),
                    AppButton(
                      isEnable: true,
                      backgroundColor: Colors.white,
                      textColor: AppColors.primary,
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                      ),
                      margin: EdgeInsets.only(top: 10.sp),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.sp,
                        horizontal: 12.sp,
                      ),
                      isCheckLastPress: false,
                      onPressed: () {
                        setState(() {
                          data.add(WKT(
                            dayOfWeek: widget.param.dayOfWeekNumber!,
                            openTime: null,
                            closeTime: null,
                          ));
                        });
                      },
                      text: "Thêm khung giờ",
                    ),
                  ],
                ),
                SizedBox(height: 20.sp),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: AppButton(
                isCheckLastPress: false,
                // isLoading: state.isLoading(),
                isEnable: true,
                isLoading: state.updateStore.isLoading,
                padding: EdgeInsets.symmetric(
                  vertical: 10.sp,
                  horizontal: 12.sp,
                ),
                onPressed: () {
                  //save
                  context.read<StoreCubit>().setDayOfWeek(
                        widget.param.copyWith(
                          wkt: data,
                          isOff: positive,
                        ),
                      );
                  context.read<StoreCubit>().registerStorePress();
                },
                text: "Lưu thông tin",
              ),
            );
          },
        ));
  }
}

class TimeFrameWidget extends StatelessWidget {
  final int number;
  final WKT data;
  const TimeFrameWidget({super.key, required this.number, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.borderColor2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Khung giờ mở cửa $number',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      )),
              GestureDetector(
                onTap: () {
                  //remove
                },
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: ImageAssetWidget(
                      image: AppAssets.imagesIconsTrashAlt,
                      height: 22,
                    )),
              ),
            ],
          ),
          SizedBox(height: 10.sp),
          const DashedDivider(
            // Add this line
            color: AppColors.borderColor2, // Add this line
          ), // Add this line
          SizedBox(height: 5.sp),
          const AppTextFormField(
              isRequired: true, hintText: 'Nhập giờ bắt đầu*'),
          const SizedBox(height: 10),
          const AppTextFormField(
              isRequired: true, hintText: 'Nhập giờ kết thúc*'),
        ],
      ),
    );
  }
}
