import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

import 'change_time_page.dart';

class WorkTimeDayOfWeek extends StatelessWidget {
  const WorkTimeDayOfWeek({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
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
                  itemCount: state.wkts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await Get.to(() => ChangeTimePage(
                              param: state.wkts[index],
                            ));
                        // if (result != null) {
                        //   widget.bloc.setDayOfWeek(result);
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: index + 1 == state.wkts.length
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
                                state.wkts[index].dayOfWeek!,
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
                                Builder(builder: (context) {
                                  if (state.wkts[index].wkt.isEmpty) {
                                    return const Text(
                                      "Đóng cửa",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.color054,
                                      ),
                                    );
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: List.generate(
                                      state.wkts[index].wkt.length,
                                      (index2) {
                                        return Row(
                                          children: [
                                            Text(
                                              state.wkts[index].wkt[index2]
                                                      .openTimeStr ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.color054,
                                                  ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              "-",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.color054,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              state.wkts[index].wkt[index2]
                                                      .closeTimeStr ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.color054,
                                                  ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }),
                                const SizedBox(width: 10),
                                const ImageAssetWidget(
                                  image: AppAssets.imagesIconsArrowRight01,
                                  height: 20,
                                )
                              ],
                            )
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
