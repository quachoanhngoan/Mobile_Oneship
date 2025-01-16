import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/working_time/work_time_page_day_of_week.dart';
import 'package:oneship_merchant_app/presentation/page/working_time/work_time_page_special.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

class WorkTimePage extends StatefulWidget {
  const WorkTimePage({
    super.key,
  });

  @override
  State<WorkTimePage> createState() => _WorkTimePageState();
}

class _WorkTimePageState extends State<WorkTimePage> {
  late final StoreCubit bloc;
  @override
  void initState() {
    bloc = context.read<StoreCubit>();
    super.initState();
  }

  var isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAuth(
        title: "Lịch làm việc hàng ngày",
        isShowHelpButton: false,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                _MenuItem(
                  title: 'Lịch làm việc hàng ngày',
                  onTap: () {
                    Get.to(() => const WorkTimeDayOfWeek());
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                _MenuItem(
                  onTap: () {
                    Get.to(() => const WorkTimeSpecial());
                  },
                  title: 'Lịch đóng cửa dịp đặc biệt',
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.borderColor2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chế độ tạm nghỉ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                    color: AppColors.color054,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Kích hoạt chế độ tạm nghỉ để ngăn khách hàng đặt đơn hàng mới.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                    color: const Color(0xff667085),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<StoreCubit, StoreState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: 80,
                            child: Container(
                              width: 60,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DefaultTextStyle.merge(
                                    child: IconTheme.merge(
                                        data: const IconThemeData(
                                            color: Colors.white),
                                        child: AnimatedToggleSwitch<bool>.dual(
                                          current: state.isPause,
                                          animationDuration:
                                              const Duration(milliseconds: 300),
                                          inactiveOpacityDuration:
                                              const Duration(milliseconds: 100),
                                          iconAnimationDuration:
                                              const Duration(milliseconds: 100),
                                          styleAnimationType:
                                              AnimationType.onSelected,
                                          first: false,
                                          second: true,
                                          clipBehavior: Clip.none,
                                          spacing: 1.0,
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
                                                  : const Color(0xffF2F4F7)),
                                          borderWidth: 3.0,
                                          indicatorSize:
                                              const Size.fromWidth(24.0),
                                          height: 30.0,
                                          loadingIconBuilder:
                                              (context, global) =>
                                                  CupertinoActivityIndicator(
                                                      color: Color.lerp(
                                                          Colors.red[800],
                                                          Colors.green,
                                                          global.position)),
                                          onChanged: (value) {
                                            if (value == true) {
                                              dialogService.showAlertDialog(
                                                title: "Thông báo",
                                                description:
                                                    "Khách hàng sẽ không thể đặt hàng trong khi quán tạm nghỉ. Bạn chắc chắn muốn bật tạm nghỉ bán ?",
                                                buttonTitle: "Bật",
                                                onPressed: () {
                                                  Get.back();
                                                  bloc.setPauseStore(
                                                    value,
                                                  );
                                                },
                                                onCancel: () {
                                                  Get.back();
                                                },
                                                buttonCancelTitle: "Hủy",
                                              );
                                            } else {
                                              bloc.setPauseStore(
                                                value,
                                              );
                                            }
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const _MenuItem({
    super.key,
    this.title = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.borderColor2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xffEDFFFC),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const ImageAssetWidget(
                image: AppAssets.imagesIconsClockEight,
                width: 16,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 10),
            Text(title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      color: AppColors.textColor,
                    )),
            const Spacer(),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {},
              icon: const ImageAssetWidget(
                image: AppAssets.imagesIconsArrowRight01,
                width: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
