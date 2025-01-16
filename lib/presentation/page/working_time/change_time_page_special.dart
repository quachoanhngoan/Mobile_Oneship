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
import 'package:oneship_merchant_app/presentation/page/register_store/widget/work_time_page.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/working_time/app_text_form_field_select.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field.dart';

class ChangeTimeSpecial extends StatefulWidget {
  const ChangeTimeSpecial({super.key});

  @override
  State<ChangeTimeSpecial> createState() => _ChangeTimeSpecialState();
}

class _ChangeTimeSpecialState extends State<ChangeTimeSpecial> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoreCubit>(context);
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        return Scaffold(
            appBar: const AppBarAuth(
              title: 'Thời gian làm việc',
              isShowHelpButton: false,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Nhập vào ngày và giờ đóng cửa của quán trong các dịp đặc biệt (nghỉ lễ, tết, team building ...)",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ngày đóng cửa dịp đặc biệt',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                )),
                        Container(
                          color: Colors.transparent,
                          child: DefaultTextStyle.merge(
                            child: IconTheme.merge(
                                data: const IconThemeData(color: Colors.white),
                                child: AnimatedToggleSwitch<bool>.dual(
                                  current: state.isSpecialWorkingTime,
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
                                    context
                                        .read<StoreCubit>()
                                        .setSpecialWorkingTime(value);
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
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            shrinkWrap: true,
                            itemCount: state.specialWorkingTimes.length,
                            itemBuilder: (context, index) {
                              final item = state.specialWorkingTimes[index];
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
                                        Text('Ngày đóng cửa ${index + 1}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primary,
                                                )),
                                        GestureDetector(
                                          onTap: () {
                                            //remove
                                            context
                                                .read<StoreCubit>()
                                                .removeSpecialWorkingTime(
                                                    index);
                                          },
                                          child: const Align(
                                              alignment: Alignment.centerRight,
                                              child: ImageAssetWidget(
                                                image: AppAssets
                                                    .imagesIconsTrashAlt,
                                                height: 22,
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.sp),
                                    const DashedDivider(
                                      // Add this line
                                      color: AppColors
                                          .borderColor2, // Add this line
                                    ), // Add this line
                                    SizedBox(height: 5.sp),
                                    AppTextFormFieldWorkTime(
                                        controller: item.dateController,
                                        isRequired: true,
                                        onTap: () async {
                                          final pickerTimer = await picker
                                              .DatePicker.showDatePicker(
                                            context,
                                            showTitleActions: true,
                                            onChanged: (date) {},
                                            onConfirm: (date) {},
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.vi,
                                          );
                                          if (pickerTimer != null) {
                                            final getTimeHHMM =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(pickerTimer);
                                            item.dateController.text =
                                                getTimeHHMM;
                                            bloc.setSpecialWorkingTimeValue(
                                                item.copyWith(
                                                  date: pickerTimer.toString(),
                                                ),
                                                index);
                                          }
                                        },
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Builder(
                                              builder: (context) {
                                                if (item.dateController.text
                                                    .isNotEmpty) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      item.dateController
                                                          .clear();
                                                      bloc.setSpecialWorkingTimeValue(
                                                          item.copyWith(
                                                            date: '',
                                                          ),
                                                          index);
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
                                              image: AppAssets
                                                  .imagesIconsClockEight,
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                        hintText: 'Ngày đóng cửa'),
                                    const SizedBox(height: 10),
                                    AppTextFormFieldWorkTime(
                                        controller: item.openTimeController,
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
                                            final getTimeHHMM =
                                                DateFormat('HH:mm')
                                                    .format(pickerTimer);

                                            bloc.setSpecialWorkingTimeValue(
                                                item.copyWith(
                                                  startTimeStr: getTimeHHMM,
                                                  startTime:
                                                      pickerTimer.hour * 60 +
                                                          pickerTimer.minute,
                                                ),
                                                index);
                                          }
                                        },
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Builder(
                                              builder: (context) {
                                                if (item.openTimeController.text
                                                    .isNotEmpty) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      item.openTimeController
                                                          .clear();
                                                      bloc.setSpecialWorkingTimeValue(
                                                          item.copyWith(
                                                            startTimeStr: '',
                                                            startTime: -1,
                                                          ),
                                                          index);
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
                                              image: AppAssets
                                                  .imagesIconsClockEight,
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                        hintText: 'Thời gian từ'),
                                    const SizedBox(height: 10),
                                    AppTextFormFieldWorkTime(
                                        controller: item.closeTimeController,
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
                                            final getTimeHHMM =
                                                DateFormat('HH:mm')
                                                    .format(pickerTimer);
                                            bloc.setSpecialWorkingTimeValue(
                                                item.copyWith(
                                                  endTimeStr: getTimeHHMM,
                                                  endTime:
                                                      pickerTimer.hour * 60 +
                                                          pickerTimer.minute,
                                                ),
                                                index);
                                          }
                                        },
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Builder(
                                              builder: (context) {
                                                if (item.closeTimeController
                                                    .text.isNotEmpty) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      item.closeTimeController
                                                          .clear();
                                                      bloc.setSpecialWorkingTimeValue(
                                                          item.copyWith(
                                                            endTimeStr: '',
                                                            endTime: -1,
                                                          ),
                                                          index);
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
                                              image: AppAssets
                                                  .imagesIconsClockEight,
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
                            context
                                .read<StoreCubit>()
                                .addEmptySpecialWorkingTime();
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
                      // context.read<StoreCubit>().setDayOfWeek(
                      //       widget.param.copyWith(
                      //         wkt: data,
                      //         isOff: positive,
                      //       ),
                      //     );
                      context.read<StoreCubit>().updateSpecialWorkingTime();
                    },
                    text: "Lưu thông tin",
                  ),
                );
              },
            ));
      },
    );
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
