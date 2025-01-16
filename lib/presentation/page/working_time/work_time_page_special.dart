import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/working_time/change_time_page_special.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';

class WorkTimeSpecial extends StatelessWidget {
  const WorkTimeSpecial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const AppBarAuth(
            title: "Lịch đóng cửa dịp đặc biệt",
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
                      "Quản lý lịch đóng cửa dịp đặc biệt cho quán của bạn để tự động cập nhật trạng thái hoạt động.",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      print("click");
                      Get.to(
                        () => const ChangeTimeSpecial(),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ngày đóng cửa dịp đặc biệt",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
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
                                            child:
                                                AnimatedToggleSwitch<bool>.dual(
                                              current:
                                                  state.isSpecialWorkingTime,
                                              animationDuration: const Duration(
                                                  milliseconds: 300),
                                              inactiveOpacityDuration:
                                                  const Duration(
                                                      milliseconds: 100),
                                              iconAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 100),
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
                                              styleBuilder: (value) =>
                                                  ToggleStyle(
                                                      backgroundColor: value
                                                          ? Colors.green
                                                          : const Color(
                                                              0xffF2F4F7)),
                                              borderWidth: 3.0,
                                              indicatorSize:
                                                  const Size.fromWidth(23.0),
                                              height: 27.0,
                                              loadingIconBuilder: (context,
                                                      global) =>
                                                  CupertinoActivityIndicator(
                                                      color: Color.lerp(
                                                          Colors.red[800],
                                                          Colors.green,
                                                          global.position)),
                                              onChanged: (value) {
                                                // if (value == true) {
                                                //   dialogService.showAlertDialog(
                                                //     title: "Thông báo",
                                                //     description:
                                                //         "Bạn có muốn bật ngày đón cửa dịp đặc biệt không?",
                                                //     buttonTitle: "Bật",
                                                //     onPressed: () {
                                                //       Get.back();
                                                //       context
                                                //           .read<StoreCubit>()
                                                //           .setPauseStore(
                                                //             value,
                                                //           );
                                                //     },
                                                //     onCancel: () {
                                                //       Get.back();
                                                //     },
                                                //     buttonCancelTitle: "Hủy",
                                                //   );
                                                // } else {
                                                //   context
                                                //       .read<StoreCubit>()
                                                //       .setPauseStore(
                                                //         value,
                                                //       );
                                                // }
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
