import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/home/widget/list_category.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        ImageAssetWidget(
          image: AppAssets.imagesBannerHome1,
          fit: BoxFit.contain,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    InfoHomePage(),
                    SizedBox(
                      height: 10,
                    ),
                    RevenueWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    ListCategory(),
                    SizedBox(
                      height: 15,
                    ),
                    ImageAssetWidget(
                      image: AppAssets.imagesBannerr2,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
    // return Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     // crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       ElevatedButton(
    //           onPressed: () {
    //             context.pushWithNamed(context, routerName: AppRoutes.store);
    //           },
    //           child: const Text("Quản lý cửa hàng")),
    //       ElevatedButton(
    //           onPressed: () {
    //             context.pushWithNamed(context,
    //                 routerName: AppRoutes.registerpage, arguments: true);
    //           },
    //           child: const Text("Đăng ký")),
    //       ElevatedButton(
    //           onPressed: () {
    //             context.read<AuthCubit>().logout();
    //           },
    //           child: const Text("Đăng xuất")),
    //       ElevatedButton(
    //           onPressed: () {
    //             context.pushWithNamed(context, routerName: AppRoutes.menuPage);
    //           },
    //           child: const Text("Thực đơn")),
    //     ],
    //   ),
    // );
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
                  child: NetworkImageWithLoader(
                    currentStore!.storeAvatarId!,
                    isAuth: true,
                    isBaseUrl: true,
                  ),
                )),
            const SizedBox(
              width: 8,
            ),
            Text(
              currentStore!.name!,
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
          onPressed: () {},
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
