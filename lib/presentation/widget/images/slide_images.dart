import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:oneship_merchant_app/presentation/page/on_boarding/on_boarding_page.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

class SlideImage extends StatefulWidget {
  const SlideImage({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<SlideImage> createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImage> {
  late PageController _controller;

  int _currentPage = 0;

  @override
  void initState() {
    _controller =
        PageController(viewportFraction: 0.9, initialPage: _currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (pageNum) {
              setState(() {
                _currentPage = pageNum;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: AppDimensions.padding),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.borderRadius * 2),
                ),
                child: ImageAssetWidget(
                  image: widget.images[index],
                ),
              ),
            ),
          ),
          if (widget.images.length > 1)
            Positioned(
                height: 20,
                bottom: 24,
                right: 0,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.images.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                            right: index == (widget.images.length - 1)
                                ? 0
                                : AppDimensions.padding / 4),
                        child: Container(
                          height: 5,
                          width: index == _currentPage ? 20.sp : 5.sp,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                            color: _currentPage == index
                                ? const Color(0xffF8A084)
                                : const Color(0xffF8A084).withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}
