import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/presentation/page/home/home_page.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_page.dart';
import 'package:oneship_merchant_app/presentation/widget/page_indicator_widgets/expend_dot/expanding_dots_effect.dart';
import 'package:oneship_merchant_app/presentation/widget/page_indicator_widgets/smooth_page_indicator.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({
    super.key,
  });

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Category(
                onTap: () {
                  Get.toNamed(AppRoutes.menuPage);
                },
                title: "Thực đơn",
                icon: AppAssets.imagesIconsNotes01,
              ),
              _Category(
                onTap: () {},
                title: "Đánh giá",
                icon: AppAssets.imagesIconsMedal,
              ),
              _Category(
                onTap: () {},
                title: "Doanh thu",
                icon: AppAssets.imagesIconsBarChart,
              ),
              _Category(
                onTap: () {},
                title: "TT Hỗ trợ",
                icon: AppAssets.imagesIconsHeadphones,
              ),
            ],
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
              count: 3,
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
