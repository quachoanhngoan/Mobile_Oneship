import 'package:equatable/equatable.dart';

import 'domain/menu_domain.dart';

class MenuDinerState extends Equatable {
  final MenuMainType menuMainType;
  final MenuType menuType;
  final ToppingType toppingType;

  const MenuDinerState(
      {this.toppingType = ToppingType.active,
      this.menuMainType = MenuMainType.menu,
      this.menuType = MenuType.active});

  MenuDinerState copyWith({
    ToppingType? toppingType,
    MenuMainType? menuMainType,
    MenuType? menuType,
  }) {
    return MenuDinerState(
        toppingType: toppingType ?? this.toppingType,
        menuMainType: menuMainType ?? this.menuMainType,
        menuType: menuType ?? this.menuType);
  }

  @override
  List<Object?> get props => [toppingType, menuMainType, menuType];
}
