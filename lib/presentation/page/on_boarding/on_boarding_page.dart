import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/slide_images.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../widget/common/logo_widget.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 0.05.sh),
            const LogoWidget(),
            SizedBox(
              height: AppDimensions.paddingLarge,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Chào mừng bạn đến với GOO+ ĐỐI TÁC!",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primary,
                            letterSpacing: 0.3,
                          )),
                  SizedBox(
                    height: AppDimensions.paddingSmall,
                  ),
                  Text(
                      "Cùng bứt phá doanh thu và chinh phục mọi cơ hội kinh doanh ngay hôm nay",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.description,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          )),
                ],
              ),
            ),
            SizedBox(
              height: AppDimensions.paddingMedium,
            ),
            // ImageAssetWidget(
            //   image: AppAssets.imagesBgOnboarding,
            //   width: 1.sw,
            //   // height: 0.4.sh,
            // ),
            SizedBox(
              height: 0.5.sh,
              child: const SlideImage(
                images: [
                  AppAssets.imagesBgOnboarding,
                  AppAssets.imagesBgOnboarding,
                  AppAssets.imagesBgOnboarding,
                ],
              ),
            ),
            SizedBox(
              height: AppDimensions.paddingLarge,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
              child: Row(
                children: [
                  Flexible(
                    child: AppButton(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingSmall + 1.sp,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                      margin: const EdgeInsets.all(0),
                      backgroundColor: Colors.white,
                      textColor: AppColors.primary,
                      text: "Đăng nhập",
                      isEnable: true,
                      onPressed: () {
                        Get.toNamed(AppRoutes.loginPage);
                      },
                    ),
                  ),
                  SizedBox(
                    width: AppDimensions.padding,
                  ),
                  Flexible(
                    child: AppButton(
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingSmall + 1.sp,
                      ),
                      margin: const EdgeInsets.all(0),
                      text: "Đăng ký",
                      isEnable: true,
                      onPressed: () {
                        Get.toNamed(AppRoutes.registerpage);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
