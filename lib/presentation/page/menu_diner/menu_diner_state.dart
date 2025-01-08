import 'package:equatable/equatable.dart';

import 'domain/menu_domain.dart';

class MenuDinerState extends Equatable {
  final MenuMainType menuMainType;
  final MenuType menuType;
  final ToppingType toppingType;
  final List<DataToppingTypeDomain>? listTopping;
  final List<DataMenuTypeDomain>? listMenu;
  final ListFoodByMenuDomain? listFoodByMenu;
  final bool isHideListFoodByMenu;
  final String? errorEditTopping;
  final bool isLoading;
  final String? textErrorToast;

  const MenuDinerState({
    this.toppingType = ToppingType.active,
    this.menuMainType = MenuMainType.menu,
    this.menuType = MenuType.active,
    this.listTopping = const [],
    this.listMenu = const [],
    this.listFoodByMenu,
    this.isHideListFoodByMenu = true,
    this.errorEditTopping,
    this.isLoading = false,
    this.textErrorToast,
  });

  MenuDinerState copyWith({
    ToppingType? toppingType,
    MenuMainType? menuMainType,
    MenuType? menuType,
    List<DataToppingTypeDomain>? listTopping,
    List<DataMenuTypeDomain>? listMenu,
    ListFoodByMenuDomain? listFoodByMenu,
    bool? isHideListFoodByMenu,
    String? errorEditTopping,
    bool? isLoading,
    String? textErrorToast,
  }) {
    return MenuDinerState(
      toppingType: toppingType ?? this.toppingType,
      menuMainType: menuMainType ?? this.menuMainType,
      menuType: menuType ?? this.menuType,
      listTopping: listTopping ?? this.listTopping,
      listMenu: listMenu ?? this.listMenu,
      listFoodByMenu: listFoodByMenu ?? this.listFoodByMenu,
      isHideListFoodByMenu: isHideListFoodByMenu ?? this.isHideListFoodByMenu,
      errorEditTopping: errorEditTopping,
      isLoading: isLoading ?? false,
      textErrorToast: textErrorToast,
    );
  }

  @override
  List<Object?> get props => [
        toppingType,
        menuMainType,
        menuType,
        listTopping,
        listMenu,
        listFoodByMenu,
        isHideListFoodByMenu,
        errorEditTopping,
        isLoading,
        textErrorToast,
      ];
}
