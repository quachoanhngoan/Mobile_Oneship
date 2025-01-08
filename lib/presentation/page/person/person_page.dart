import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/bottom_tab/bottom_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/bottom_tab/bottom_tab.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/person/change_store_button.dart';
import 'package:oneship_merchant_app/presentation/page/person/info_user.dart';
import 'package:oneship_merchant_app/presentation/page/person/list_category.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = 39 / 18;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 190,
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          const ImageAssetWidget(
                            image: AppAssets.imagesBannerProfile,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          //background black opacity
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xFF000000).withOpacity(0.6),
                                    const Color(0x00000000),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )
                ],
              ),
              const Positioned(
                bottom: 60,
                right: 0,
                child: ChangeStoreButton(),
              ),
              //padding from aspect ratio
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InfoUser(),
              ),
              Positioned(
                top: 80,
                left: 20,
                child: InkWell(
                  onTap: () {
                    context.read<BottomCubit>().updateTab(BottomTab.home);
                  },
                  child: const ImageAssetWidget(
                      image: AppAssets.imagesIconsArrowLeft02Round, height: 30),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          //listmenu
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListCategoryPersonWidget(),
              const SizedBox(
                height: 16,
              ),
              const ListMenuAccountPage(),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bạn cảm thấy GOO+ thế nào ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.textColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Sẽ thật tuyệt vời nếu GOO+ nhận được góp ý để cải thiện dịch vụ",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.colorA8A,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                              children: List.generate(
                                  5,
                                  (index) => Container(
                                        padding: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        child: ImageAssetWidget(
                                          image: AppAssets.imagesIconsStar,
                                          color: const Color(0xffB3B3B3),
                                          height: 17.sp,
                                        ),
                                      ))),
                        ],
                      ),
                    ),
                    ImageAssetWidget(
                        image: AppAssets.imagesIconsHunggingface,
                        height: 74.sp),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              AppButton(
                  margin:
                      EdgeInsets.symmetric(horizontal: AppDimensions.padding),
                  isEnable: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  text: "Đăng xuất",
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                  }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListMenuAccountPage extends StatelessWidget {
  const ListMenuAccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderColor2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MenuItem(
            title: "Chính sách và điều khoản của GOO+",
            image: AppAssets.imagesIconsSquareUserCheckAlt,
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            color: AppColors.borderColor2,
            height: 1,
          ),
          SizedBox(
            height: 12,
          ),
          _MenuItem(
            title: "Tiêu chuẩn cộng đồng",
            image: AppAssets.imagesIconsCircleInformation,
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            color: AppColors.borderColor2,
            height: 1,
          ),
          SizedBox(
            height: 12,
          ),
          _MenuItem(
            title: "Trợ giúp",
            image: AppAssets.imagesIconsBook,
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String image;
  final String title;
  const _MenuItem({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xffEDFFFC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ImageAssetWidget(image: image, height: 15),
        ),
        const SizedBox(width: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        const Spacer(),
        const ImageAssetWidget(
          image: AppAssets.imagesIconsArrowRight01,
          height: 18,
        ),
      ],
    );
  }
}

class _Category extends StatelessWidget {
  final void Function()? onTap;
  final String icon;
  final String title;
  const _Category({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffE3FFFA),
            ),
            child: Image.asset(
              icon,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.medium,
              height: 24,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textGray2),
          ),
        ],
      ),
    );
  }
}
