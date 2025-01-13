import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

class WorkTimeModel {
  final String? timeStart;
  final String? timeEnd;
  final String? dayOfWeek;
  final bool? isOff;

  WorkTimeModel({
    this.timeStart,
    this.timeEnd,
    this.dayOfWeek,
    this.isOff,
  });
}

class WorkTimePage extends StatefulWidget {
  final RegisterStoreCubit bloc;
  const WorkTimePage({super.key, required this.bloc});

  @override
  State<WorkTimePage> createState() => _WorkTimePageState();
}

class _WorkTimePageState extends State<WorkTimePage> {
  final List<WorkTimeModel> data = [
    WorkTimeModel(
      dayOfWeek: "Thứ 2",
      timeStart: "08:00",
      timeEnd: "17:00",
      isOff: false,
    ),
    WorkTimeModel(
      dayOfWeek: "Thứ 3",
      timeStart: "08:00",
      timeEnd: "17:00",
      isOff: false,
    ),
    WorkTimeModel(
      dayOfWeek: "Thứ 4",
      timeStart: "08:00",
      timeEnd: "17:00",
      isOff: false,
    ),
    WorkTimeModel(
      dayOfWeek: "Thứ 5",
      timeStart: "08:00",
      timeEnd: "17:00",
      isOff: false,
    ),
    WorkTimeModel(
      dayOfWeek: "Thứ 6",
      timeStart: "08:00",
      timeEnd: "17:00",
      isOff: false,
    ),
    WorkTimeModel(
      dayOfWeek: "Thứ 7",
      timeStart: "08:00",
      timeEnd: "17:00",
      isOff: false,
    ),
    WorkTimeModel(
      dayOfWeek: "Chủ nhật",
      timeStart: "08:00",
      timeEnd: "17:00",
      isOff: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.borderColor2,
            ),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: index + 1 == data.length
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
                        data[index].dayOfWeek!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          data[index].isOff! ? "Đóng cửa" : "Hoạt động",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
