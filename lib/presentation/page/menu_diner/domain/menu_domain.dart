
enum MenuMainType { menu, topping }

enum MenuType { active, notRegistered, pendingApproval }

enum ToppingType { active, notRegistered }

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
