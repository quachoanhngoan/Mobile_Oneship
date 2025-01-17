import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/change_time_page.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

class WorkTimeModel {
  final String? dayOfWeek;
  final int? dayOfWeekNumber;
  final bool? isOff;
  final List<WKT> wkt;

  const WorkTimeModel({
    this.dayOfWeek,
    this.dayOfWeekNumber,
    this.isOff,
    this.wkt = const [],
  });

  WorkTimeModel copyWith({
    String? dayOfWeek,
    int? dayOfWeekNumber,
    bool? isOff,
    List<WKT>? wkt,
  }) {
    return WorkTimeModel(
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      dayOfWeekNumber: dayOfWeekNumber ?? this.dayOfWeekNumber,
      isOff: isOff ?? this.isOff,
      wkt: wkt ?? this.wkt,
    );
  }

  @override
  String toString() {
    return 'WorkTimeModel(dayOfWeek: $dayOfWeek, dayOfWeekNumber: $dayOfWeekNumber, isOff: $isOff, wkt: $wkt)';
  }
}

class WKT {
  final int dayOfWeek;
  final int? openTime;
  final int? closeTime;
  String? openTimeStr;
  String? closeTimeStr;
  late TextEditingController openTimeController;
  late TextEditingController closeTimeController;
  WKT({
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    this.openTimeStr,
    this.closeTimeStr,
  }) {
    //open time 360 => 6:00
    //close time 362 => 6:02
    if (openTime != null && openTime! >= 0) {
      openTimeStr = "${(openTime! / 60).floor()}:${openTime! % 60}";
      //add 0 if minute < 10
      openTimeStr = openTimeStr!.split(":")[1].length == 1
          ? "${openTimeStr!.split(":")[0]}:0${openTimeStr!.split(":")[1]}"
          : openTimeStr;
      openTimeController = TextEditingController(text: openTimeStr);
    } else {
      openTimeController = TextEditingController();
    }
    if (closeTime != null && closeTime! >= 0) {
      closeTimeStr = "${(closeTime! / 60).floor()}:${closeTime! % 60}";
      //add 0 if minute < 10
      closeTimeStr = closeTimeStr!.split(":")[1].length == 1
          ? "${closeTimeStr!.split(":")[0]}:0${closeTimeStr!.split(":")[1]}"
          : closeTimeStr;
      closeTimeController = TextEditingController(text: closeTimeStr);
    } else {
      closeTimeController = TextEditingController();
    }
  }

  WKT copyWith({
    int? dayOfWeek,
    int? openTime,
    int? closeTime,
    String? openTimeStr,
    String? closeTimeStr,
  }) {
    return WKT(
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      openTimeStr: openTimeStr ?? this.openTimeStr,
      closeTimeStr: closeTimeStr ?? this.closeTimeStr,
    );
  }
}

class WorkTimePage extends StatefulWidget {
  final RegisterStoreCubit bloc;
  const WorkTimePage({super.key, required this.bloc});

  @override
  State<WorkTimePage> createState() => _WorkTimePageState();
}

class _WorkTimePageState extends State<WorkTimePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.borderColor2,
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        final result = await Get.to(() => ChangeTimePage(
                              param: state.data[index],
                            ));
                        print(result);
                        if (result != null) {
                          widget.bloc.setDayOfWeek(result);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: index + 1 == state.data.length
                              ? null
                              : const Border(
                                  bottom: BorderSide(
                                    color: AppColors.borderColor2,
                                  ),
                                ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                state.data[index].dayOfWeek!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  state.data[index].isOff == false
                                      ? "Đóng cửa"
                                      : "Hoạt động",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const ImageAssetWidget(
                                  image: AppAssets.imagesIconsArrowRight01,
                                  width: 16,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
