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
  final bool editNameGroupSuccess;
  final bool isLoading;
  final String? textErrorToast;
  final bool errorRemoveGroup;
  final DetailFoodResponse? detailFoodData;
  final bool showClearNameEditMenu;
  final bool isShowSearch;
  final List<ResultSearchMenuTypeDomain> listResultSearch;

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
    this.showClearNameEditMenu = true,
    this.editNameGroupSuccess = false,
    this.isShowSearch = false,
    this.listResultSearch = const [],
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
    bool? showClearNameEditMenu,
    bool? editNameGroupSuccess,
    bool? isShowSearch,
    List<ResultSearchMenuTypeDomain>? listResultSearch,
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
      detailFoodData: detailFoodData,
      showClearNameEditMenu: showClearNameEditMenu ?? true,
      editNameGroupSuccess: editNameGroupSuccess ?? false,
      isShowSearch: isShowSearch ?? this.isShowSearch,
      listResultSearch: listResultSearch ?? this.listResultSearch,
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
        errorRemoveGroup,
        isLoading,
        textErrorToast,
        detailFoodData,
        showClearNameEditMenu,
        editNameGroupSuccess,
        isShowSearch,
        listResultSearch,
      ];
}
