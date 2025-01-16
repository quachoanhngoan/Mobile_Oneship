import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/home/widget/banner_2.dart';
import 'package:oneship_merchant_app/presentation/page/home/widget/banner_parallel.dart';
import 'package:oneship_merchant_app/presentation/page/home/cubit/home_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/home/widget/list_banner.dart';
import 'package:oneship_merchant_app/presentation/page/home/widget/list_category.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit bloc;
  @override
  void initState() {
    bloc = injector<HomeCubit>();
    context.read<AuthCubit>().getProfile();
    getBanners();
    super.initState();
  }

  void getBanners() async {
    bloc.getBanners();
    context.read<StoreCubit>().getStoreById();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 50),
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 16, right: 16),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(AppAssets.imagesBannerHome1),
                  fit: BoxFit.contain,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const InfoHomePage(),
                  const SizedBox(
                    height: 10,
                  ),
                  const RevenueWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  const ListCategory(),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state.banners.isEmpty) {
                        return const SizedBox();
                      }

                      return ListBanner(
                        banners: state.getBannerHomePosition,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Banner2(),
                  const SizedBox(
                    height: 20,
                  ),
                  const BannerParallel(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RevenueWidget extends StatelessWidget {
  const RevenueWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hôm nay quán của bạn có gì? ",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage(AppAssets.imagesFrameRevenue),
                        fit: BoxFit.cover,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Doanh thu",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                          ),
                          const Spacer(),
                          const ImageAssetWidget(
                            image: AppAssets.imagesIncreaseIcon,
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "1.000.000",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage(AppAssets.imagesFrameOrder),
                        fit: BoxFit.cover,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Tổng đơn hàng",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                          ),
                          const Spacer(),
                          const ImageAssetWidget(
                            image: AppAssets.imagesIncreaseIcon,
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "1.000.000",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.borderColor2,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.borderColor2, width: 2)),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: AppColors.borderColor2,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Đặt trước",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff737373)),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "521",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff2D2D2D)),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.textGray,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Đã nhận",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff737373)),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "421",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff2D2D2D)),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.textGray,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: AppColors.borderColor2,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chờ nhận",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff737373)),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "12",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xff2D2D2D)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.textGray,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Đã giao",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff737373)),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "20",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xff2D2D2D)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.textGray,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InfoHomePage extends StatelessWidget {
  const InfoHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: currentStore?.storeAvatarId != null
                      ? NetworkImageWithLoader(
                          currentStore!.storeAvatarId!,
                          isAuth: true,
                          isBaseUrl: true,
                        )
                      : Container(),
                )),
            const SizedBox(
              width: 8,
            ),
            Text(
              currentStore?.name ?? "",
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            dialogService.showAlertDialog(
                title: "Thay đổi quán",
                description: "Bạn có muốn thay đổi quán khác không ?",
                buttonTitle: "Xác nhận",
                buttonCancelTitle: "Hủy",
                onCancel: () => Get.back(),
                onPressed: () {
                  Get.offAllNamed(AppRoutes.store);
                });
          },
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(400),
            ),
            child: const ImageAssetWidget(
              image: AppAssets.imagesIconsIcnReload,
              height: 20,
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
}
