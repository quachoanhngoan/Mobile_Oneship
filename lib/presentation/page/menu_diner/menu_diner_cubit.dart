import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/list_menu_food_request.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';

import '../../data/model/menu/gr_topping_response.dart';
import '../../data/model/menu/linkfood_response.dart';
import '../../data/model/menu/list_menu_food_response.dart';
import '../../data/repository/menu_repository.dart';
import 'domain/menu_domain.dart';

class MenuDinerCubit extends Cubit<MenuDinerState> {
  final MenuRepository repository;
  MenuDinerCubit(this.repository) : super(const MenuDinerState());

  late PageController mainController;
  late PageController groupToppingController;
  late PageController menuController;

  init() {
    mainController = PageController();
    groupToppingController = PageController();
    menuController = PageController();
    getAllTopping();
    getAllMenu();
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

  getAllTopping() async {
    try {
      List<DataToppingTypeDomain> listAllTopping = [];
      for (var type in ToppingType.values) {
        final request = GetGroupToppingRequest(status: type.status);
        final response = await repository.getGroupTopping(request);
        listAllTopping.add(DataToppingTypeDomain(response?.items, type));
      }
      emit(state.copyWith(listTopping: listAllTopping));
    } on DioException catch (e) {
      log("getAllTopping error: ${e.message}");
    }
  }

  getAllMenu() async {
    try {
      List<DataMenuTypeDomain> listAllMenu = [];
      for (var type in MenuType.values) {
        final request = LinkFoodRequest(
            productStatus: type.productStatus,
            approvalStatus: type.approvalStatus);
        final response = await repository.getListMenu(request);
        listAllMenu.add(DataMenuTypeDomain(response?.items, type));
      }
      emit(state.copyWith(listMenu: listAllMenu));
    } on DioException catch (e) {
      log("getAllMenu error: ${e.message}");
    }
  }

  getListFoodByMenu(
      {required MenuType type, required int productCategoryId}) async {
    try {
      if (state.listFoodByMenu?.type == type &&
          state.listFoodByMenu?.idSellected == productCategoryId) {
        emit(state.copyWith(isHideListFoodByMenu: !state.isHideListFoodByMenu));
      } else {
        final request = ListMenuFoodRequest(
            status: type.productStatus,
            approvalStatus: type.approvalStatus,
            productCategoryId: productCategoryId);
        final response = await repository.detailFoodByMenu(request);
        emit(state.copyWith(
            listFoodByMenu: ListFoodByMenuDomain(
                idSellected: productCategoryId,
                type: type,
                listFoodByMenu: response?.items),
            isHideListFoodByMenu: false));
      }
    } on DioException catch (e) {
      log("getListMenuFood error: ${e.message}");
    }
  }

  hideOrShowTopping(GrAddToppingResponse topping, {bool isHide = true}) async {
    try {
      final request = topping.responseToRequest();
      final response = await repository.addGroupTopping(request);
      if (response != null) {
        getAllTopping();
      } else {}
    } on DioException catch (e) {
      log("editTopping error: ${e.message}");
    }
  }
}
