import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/list_menu_food_response.dart';

import '../../../../config/theme/color.dart';

enum MenuMainType { menu, topping }

enum MenuType { active, notRegistered, pendingApproval, unsuccessful }

enum ToppingType { active, notRegistered }

enum StatisticMenuType { sold, views, likes }

enum DetailMenuActionType { advertisement, hide, edit, more }

enum ActionNotRegisterType { advertisement, show, edit, delete }

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

  String get productStatus {
    switch (this) {
      case MenuType.notRegistered:
        return "inactive";
      default:
        return "active";
    }
  }

  String get approvalStatus {
    switch (this) {
      case MenuType.active:
      case MenuType.notRegistered:
        return "approved";
      case MenuType.pendingApproval:
        return "pending";
      case MenuType.unsuccessful:
        return "rejected";
    }
  }
}

extension ToppingTypeEx on ToppingType {
  String get title {
    switch (this) {
      case ToppingType.active:
        return "Đang sử dụng (#VALUE)";
      case ToppingType.notRegistered:
        return "Chưa sử dụng (#VALUE)";
    }
  }

  String get status {
    switch (this) {
      case ToppingType.active:
        return "active";
      case ToppingType.notRegistered:
        return "inactive";
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

extension ActionNotRegisterTypeEx on ActionNotRegisterType {
  String get title {
    switch (this) {
      case ActionNotRegisterType.advertisement:
        return "Quảng cáo";
      case ActionNotRegisterType.show:
        return "Hiển thị";
      case ActionNotRegisterType.edit:
        return "Sửa";
      case ActionNotRegisterType.delete:
        return "Xoá";
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

class DataToppingTypeDomain {
  final ToppingType type;
  final List<GrAddToppingResponse>? data;

  DataToppingTypeDomain(this.data, this.type);
}

class DataMenuTypeDomain {
  final MenuType type;
  final int? totalProducts;
  final List<ItemLinkFood>? data;

  DataMenuTypeDomain(
      {this.data, this.type = MenuType.active, this.totalProducts});
}

// class ListFoodByMenuDomain {
//   final List<MenuFoodResponseItem>? listFoodByMenu;
//   final MenuType? type;
//   final int? idSellected;
//
//   ListFoodByMenuDomain({this.idSellected, this.listFoodByMenu, this.type});
// }

class ShowDetailMenuDomain {
  final MenuType type;
  final int idShow;

  ShowDetailMenuDomain({required this.idShow, required this.type});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ShowDetailMenuDomain) return false;
    return other.idShow == idShow && other.type == type;
  }

  @override
  int get hashCode => Object.hash(idShow, type);
}

class ResultSearchMenuTypeDomain {
  final MenuType type;
  final List<MenuFoodResponseItem> listResult;

  ResultSearchMenuTypeDomain(
      {this.listResult = const [], this.type = MenuType.active});
}
