import 'package:equatable/equatable.dart';

import '../../data/model/menu/detail_food_response.dart';
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
  final bool errorRemoveGroup;
  final DetailFoodResponse? detailFoodData;

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
    this.errorRemoveGroup = false,
    this.textErrorToast,
    this.detailFoodData,
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
    bool? errorRemoveGroup,
    bool? isLoading,
    String? textErrorToast,
    DetailFoodResponse? detailFoodData,
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
        errorRemoveGroup: errorRemoveGroup ?? false,
        isLoading: isLoading ?? false,
        textErrorToast: textErrorToast,
        detailFoodData: detailFoodData);
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
        errorRemoveGroup,
        isLoading,
        textErrorToast,
        detailFoodData,
      ];
}
