import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/dashed_divider.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_select.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/work_time_page.dart';
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
          title: 'Thời gian làm việc',
          isShowHelpButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                              print(value);
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
              Expanded(
                child: ListView(
                  children: [
                    ListView.separated(
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
                                AppTextFormFieldSelect(
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
                                    suffixIcon: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ImageAssetWidget(
                                          image:
                                              AppAssets.imagesIconsClockEight,
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    hintText: 'Nhập giờ bắt đầu*'),
                                const SizedBox(height: 10),
                                AppTextFormFieldSelect(
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
                                        ImageAssetWidget(
                                          image:
                                              AppAssets.imagesIconsClockEight,
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    isRequired: true,
                                    hintText: 'Nhập giờ kết thúc*'),
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
                            openTime: 0,
                            closeTime: 0,
                          ));
                        });
                      },
                      text: "Thêm khung giờ",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
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
            padding: EdgeInsets.symmetric(
              vertical: 10.sp,
              horizontal: 12.sp,
            ),
            onPressed: () {
              //save

              Get.back(
                result: widget.param.copyWith(
                  wkt: data,
                  isOff: positive,
                ),
              );
            },
            text: "Lưu thông tin",
          ),
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
