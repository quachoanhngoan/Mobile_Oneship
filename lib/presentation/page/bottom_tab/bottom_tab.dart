import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_page.dart';
import 'package:oneship_merchant_app/presentation/page/home/home_page.dart';
import 'package:oneship_merchant_app/presentation/page/notification/notification_page.dart';
import 'package:oneship_merchant_app/presentation/page/person/person_page.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

import '../../../config/theme/color.dart';

enum BottomTab { home, cart, notification, person }

extension AppTabExtension on BottomTab {
  String get name {
    switch (this) {
      case BottomTab.home:
        return "Trang chủ";
      case BottomTab.cart:
        return "Đơn hàng";
      case BottomTab.notification:
        return "Thông báo";
      case BottomTab.person:
        return "Tài khoản";
    }
  }

  Widget icon(bool sellected) {
    double size = 24;
    Color colorIcon = sellected ? AppColors.colorFA6 : AppColors.color390;
    switch (this) {
      case BottomTab.home:
        return ImageAssetWidget(
            image: AppAssets.imagesIconsIcTabHome,
            width: size,
            height: size,
            color: colorIcon);
      case BottomTab.cart:
        return ImageAssetWidget(
            image: AppAssets.imagesIconsIcTabCart,
            width: size,
            height: size,
            color: colorIcon);
      case BottomTab.notification:
        return ImageAssetWidget(
            image: AppAssets.imagesIconsIcTabNotification,
            width: size,
            height: size,
            color: colorIcon);

      case BottomTab.person:
        return ImageAssetWidget(
            image: AppAssets.imagesIconsIcTabAccount,
            width: size,
            height: size,
            color: colorIcon);
    }
  }

  Widget screen(BuildContext context) {
    switch (this) {
      case BottomTab.home:
        return const HomePage();
      case BottomTab.cart:
        return const CartPage();
      case BottomTab.notification:
        return const NotificationPage();
      case BottomTab.person:
        return const PersonPage();
    }
  }
}
