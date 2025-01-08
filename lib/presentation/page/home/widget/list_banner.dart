import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/data/model/banner/banner.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';
import 'package:oneship_merchant_app/presentation/widget/page_indicator_widgets/expend_dot/expanding_dots_effect.dart';
import 'package:oneship_merchant_app/presentation/widget/page_indicator_widgets/smooth_page_indicator.dart';

class ListBanner extends StatefulWidget {
  final BannerM? banners;
  const ListBanner({
    super.key,
    required this.banners,
  });

  @override
  State<ListBanner> createState() => _ListBannerState();
}

class _ListBannerState extends State<ListBanner> {
  late final PageController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // assert(widget.categories.isNotEmpty);
    controller = PageController(viewportFraction: 1, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners?.files?.isEmpty ?? true) {
      return const SizedBox();
    }
    const aspectRatio = 2 / 1;
    final height = MediaQuery.of(context).size.width / aspectRatio;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: PageView.builder(
              controller: controller,
              itemCount: widget.banners?.files?.length ?? 0,
              itemBuilder: (context, index) {
                return NetworkImageWithLoader(
                  widget.banners?.files?[index].fileId ?? "",
                  isBaseUrl: true,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: 20,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              )),
          if ((widget.banners?.files?.length ?? 0) > 1)
            Positioned(
              bottom: 0,
              height: 20,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: Color(0xffFBCABB),
                    activeDotColor: Color(0xffEB8564),
                    expansionFactor: 3,
                    spacing: 2,
                  ),
                  controller: controller,
                  count: widget.banners?.files?.length ?? 0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
