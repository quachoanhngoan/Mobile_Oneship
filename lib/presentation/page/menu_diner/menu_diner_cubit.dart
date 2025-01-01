import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';

import 'domain/menu_domain.dart';

class MenuDinerCubit extends Cubit<MenuDinerState> {
  MenuDinerCubit() : super(const MenuDinerState());

  late PageController mainController;
  late PageController groupToppingController;
  late PageController menuController;

  init() {
    mainController = PageController();
    groupToppingController = PageController();
    menuController = PageController();
  }

  dispose() {
    mainController.dispose();
    groupToppingController.dispose();
    menuController.dispose();
  }

  changeMainPage(int index, MenuMainType type) {
    mainController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    emit(state.copyWith(menuMainType: type));
  }

  changeGroupTopping(int index, ToppingType type) {
    groupToppingController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    emit(state.copyWith(toppingType: type));
  }

  changePageMenu(int index, MenuType type) {
    menuController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    emit(state.copyWith(menuType: type));
  }
}
