import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // assert(widget.categories.isNotEmpty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners?.files?.isEmpty ?? true) {
      return const SizedBox();
    }
    // const aspectRatio = 2 / 1;
    // final height = MediaQuery.of(context).size.width / aspectRatio;
    return SizedBox(
      // height: height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 2 / 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: widget.banners?.files?.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: NetworkImageWithLoader(
                        i.fileId ?? "",
                        isBaseUrl: true,
                        fit: BoxFit.cover,
                      ));
                },
              );
            }).toList(),
          ),
          // SizedBox(
          //   height: height,
          //   width: width,
          //   child: PageView.builder(
          //     controller: controller,
          //     itemCount: widget.banners?.files?.length ?? 0,
          //     itemBuilder: (context, index) {
          //       return NetworkImageWithLoader(
          //         widget.banners?.files?[index].fileId ?? "",
          //         isBaseUrl: true,
          //         fit: BoxFit.cover,
          //       );
          //     },
          //   ),
          // ),
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
          // if (widget.banners?.files != null &&
          //     widget.banners!.files!.length > 1)
          //   Positioned(
          //     bottom: 0,
          //     left: 0,
          //     right: 0,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: widget.banners!.files!.asMap().entries.map((entry) {
          //         return GestureDetector(
          //           onTap: () => _controller.animateToPage(entry.key),
          //           child: Container(
          //             width: _current == entry.key ? 30.0 : 9.0,
          //             height: 9.0,
          //             margin: const EdgeInsets.symmetric(
          //                 vertical: 8.0, horizontal: 2.0),
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(12),
          //                 color: _current == entry.key
          //                     ? const Color(0xffEB8564)
          //                     : Color(0xffFBCABB)),
          //           ),
          //         );
          //       }).toList(),
          //     ),
          //   ),
          if ((widget.banners?.files?.length ?? 0) > 1)
            Positioned(
              bottom: 0,
              height: 20,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedSmoothIndicator(
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: Color(0xffFBCABB),
                    activeDotColor: Color(0xffEB8564),
                    expansionFactor: 3,
                    spacing: 2,
                  ),
                  count: widget.banners?.files?.length ?? 0,
                  activeIndex: _current,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
