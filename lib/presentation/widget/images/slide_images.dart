import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

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
        PageController(viewportFraction: 1, initialPage: _currentPage);
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (pageNum) {
                setState(() {
                  _currentPage = pageNum;
                });
              },
              itemCount: widget.images.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppDimensions.borderRadius * 2),
                  ),
                  child: NetworkImageWithLoader(
                    widget.images[index],
                    isBaseUrl: true,
                  ),
                ),
              ),
            ),
          ),
          if (widget.images.length > 1)
            Container(
              margin: EdgeInsets.only(top: AppDimensions.padding),
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
            )
        ],
      ),
    );
  }
}
