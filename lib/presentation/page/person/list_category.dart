import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/widget/page_indicator_widgets/expend_dot/expanding_dots_effect.dart';
import 'package:oneship_merchant_app/presentation/widget/page_indicator_widgets/smooth_page_indicator.dart';

class ListCategoryPersonWidget extends StatefulWidget {
  const ListCategoryPersonWidget({
    super.key,
  });

  @override
  State<ListCategoryPersonWidget> createState() =>
      _ListCategoryPersonWidgetState();
}

class _ListCategoryPersonWidgetState extends State<ListCategoryPersonWidget> {
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
    final listWidget = <Widget>[
      _Category(
        onTap: () {
          Get.toNamed(AppRoutes.editProfile);
        },
        title: "Thông tin tài khoản",
        icon: AppAssets.imagesIconsSquareUser,
      ),
      _Category(
        onTap: () {
          Get.toNamed(AppRoutes.addressStore);
        },
        title: "Địa chỉ nhận / trả hàng",
        icon: AppAssets.imagesIconsGearAltIcon,
      ),
      _Category(
        onTap: () {},
        title: "Đánh giá của bạn",
        icon: AppAssets.imagesIconsStarCopy,
      ),
      _Category(
        onTap: () {},
        title: "Cài đặt máy in",
        icon: AppAssets.imagesIconsGearAlt,
      ),
      // _Category(
      //   onTap: () {},
      //   title: "Cài đặt vận chuyển",
      //   icon: AppAssets.imagesIconsGearAlt,
      // ),
      // _Category(
      //   onTap: () {},
      //   title: "Cài đặt thông báo",
      //   icon: AppAssets.imagesIconsGearAlt,
      // ),
      // _Category(
      //   onTap: () {},
      //   title: "Cài đặt khác",
      //   icon: AppAssets.imagesIconsGearAlt,
      // ),
      // _Category(
      //   onTap: () {},
      //   title: "Cài đặt khác",
      //   icon: AppAssets.imagesIconsGearAlt,
      // ),
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: AppDimensions.padding),
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 90,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: controller,
              itemCount: 2,
              itemBuilder: (context, index) {
                //lấy 4 phần tử từ listWidget trang 1
                //trang 2 thì lấy 2 cái còn lại
                final get4 = listWidget.getRange(index * 4, (index + 1) * 4);

                return ListView.separated(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppDimensions.padding),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  addAutomaticKeepAlives: true,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: get4.length,
                  itemBuilder: (context, index) {
                    return get4.elementAt(index);
                  },
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: AppColors.borderColor2,
            child: SmoothPageIndicator(
              effect: const ExpandingDotsEffect(
                dotHeight: 5,
                dotWidth: 6,
                dotColor: AppColors.borderColor2,
                activeDotColor: Color(0xffEB8564),
                expansionFactor: 3,
                spacing: 8,
              ),
              controller: controller,
              count: 2,
            ),
          ),
        ],
      ),
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
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
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGray2),
            ),
          ],
        ),
      ),
    );
  }
}
