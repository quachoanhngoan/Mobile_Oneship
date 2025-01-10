import 'package:equatable/equatable.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/domain/menu_domain.dart';

import '../../data/model/menu/list_menu_food_response.dart';

class MenuSearchState extends Equatable {
  final List<MenuFoodResponseItem> listResultSearch;
  final MenuMainType menuMainType;
  final MenuType menuType;
  final bool isLoading;
  final String? errorEditTopping;

  const MenuSearchState({
    this.listResultSearch = const [],
    this.menuMainType = MenuMainType.menu,
    this.menuType = MenuType.active,
    this.isLoading = false,
    this.errorEditTopping,
    // this.listMenu = const [],
  });

  MenuSearchState copyWith({
    List<MenuFoodResponseItem>? listResultSearch,
    MenuMainType? menuMainType,
    MenuType? menuType,
    bool? isLoading,
    String? errorEditTopping,
    // List<DataMenuTypeDomain>? listMenu,
  }) {
    return MenuSearchState(
      listResultSearch: listResultSearch ?? this.listResultSearch,
      menuMainType: menuMainType ?? this.menuMainType,
      menuType: menuType ?? this.menuType,
      isLoading: isLoading ?? false,
      errorEditTopping: errorEditTopping,
      // listMenu: listMenu ?? this.listMenu,
    );
  }

  @override
  List<Object?> get props => [
        listResultSearch,
        menuMainType,
        menuType,
        errorEditTopping,
        // listMenu,
      ];
}
