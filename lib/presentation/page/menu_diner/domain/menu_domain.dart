import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/core/core.dart';

import '../../../../config/theme/color.dart';

enum MenuMainType { menu, topping }

enum MenuType { active, notRegistered, pendingApproval, unsuccessful }

enum ToppingType { active, notRegistered }

enum StatisticMenuType { sold, views, likes }

enum DetailMenuActionType { advertisement, hide, edit, more }

extension MenuMainExtension on MenuMainType {
  String get title {
    switch (this) {
      case MenuMainType.menu:
        return "Menu";
      case MenuMainType.topping:
        return "Nhóm topping";
    }
  }
}

extension MenuTypeExtension on MenuType {
  String get title {
    switch (this) {
      case MenuType.active:
        return "Đang hoạt động (#VALUE)";
      case MenuType.notRegistered:
        return "Chưa được đăng (#VALUE)";
      case MenuType.pendingApproval:
        return "Chờ duyệt (#VALUE)";
      case MenuType.unsuccessful:
        return "Không thành công (#VALUE)";
    }
  }
}

extension ToppingTypeEx on ToppingType {
  String get title {
    switch (this) {
      case ToppingType.active:
        return "Đang hoạt động (#VALUE)";
      case ToppingType.notRegistered:
        return "Chưa được đăng (#VALUE)";
    }
  }
}

extension StatisticMenuTypeEx on StatisticMenuType {
  String get icon {
    switch (this) {
      case StatisticMenuType.sold:
        return AppAssets.imagesIconsIcBasket;
      case StatisticMenuType.views:
        return AppAssets.imagesIconsEye;
      case StatisticMenuType.likes:
        return AppAssets.imagesIconsIcLike;
    }
  }

  String get title {
    switch (this) {
      case StatisticMenuType.sold:
        return "Đã bán";
      case StatisticMenuType.views:
        return "Lượt xem";
      case StatisticMenuType.likes:
        return "Lượt thích";
    }
  }
}

extension DetailMenuActionTypeEx on DetailMenuActionType {
  String? get title {
    switch (this) {
      case DetailMenuActionType.advertisement:
        return "Quảng cáo";
      case DetailMenuActionType.hide:
        return "Ẩn";
      case DetailMenuActionType.edit:
        return "Sửa";
      case DetailMenuActionType.more:
        return null;
    }
  }

  Color get colorBorder {
    switch (this) {
      case DetailMenuActionType.edit:
        return AppColors.colorD33;
      default:
        return AppColors.color8E8;
    }
  }

  Color? get colorText {
    switch (this) {
      case DetailMenuActionType.edit:
        return AppColors.colorD33;
      default:
        return AppColors.black;
    }
  }
}
