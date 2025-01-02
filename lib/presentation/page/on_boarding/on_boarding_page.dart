import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/banner/banner.dart';
import 'package:oneship_merchant_app/presentation/data/repository/banner_repository.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/slide_images.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../widget/common/logo_widget.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  bool isLoading = false;
  List<BannerM> banners = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBanners();
  }

  void getBanners() async {
    isLoading = true;
    setState(() {});
    try {
      final response = await execute(
        () => injector<BannerRepository>().getBanner("onboarding"),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        isLoading = false;
        banners = data;
        // emit(state.copyWith(banners: data.items ?? []));
      }, failure: (error) {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
      isLoading = false;
    }
  }

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
                      "Cùng bứt phá doanh thu và chinh phục mọi cơ hội kinh doanh ngay hôm nay!",
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
              child: Builder(
                builder: (context) {
                  final List<String> images = [];
                  if (banners.isNotEmpty &&
                      banners[0].files?.isNotEmpty == true) {
                    for (var i = 0; i < banners[0].files!.length; i++) {
                      images.add(banners[0].files![i].fileId ?? "");
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SlideImage(
                      images: List<String>.from(images),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
              child: Row(
                children: [
                  Flexible(
                    child: AppButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.sp,
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
                        vertical: 12.sp,
                      ),
                      margin: const EdgeInsets.all(0),
                      text: "Đăng ký",
                      isEnable: true,
                      onPressed: () {
                        Get.toNamed(AppRoutes.registerpage, arguments: true);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppDimensions.paddingLarge,
            ),
          ],
        ),
      ),
    );
  }
}
