import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/food_register_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/list_menu_food_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/list_menu_food_response.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';

import '../../data/model/menu/gr_topping_response.dart';
import '../../data/repository/menu_repository.dart';
import 'domain/menu_domain.dart';

class MenuDinerCubit extends Cubit<MenuDinerState> {
  final MenuRepository repository;

  MenuDinerCubit(this.repository) : super(const MenuDinerState());

  final String tag = "MenuDinerCubit";

  late PageController mainController;
  late PageController groupToppingController;
  late PageController menuController;

  late TextEditingController nameMenuEditController;
  late TextEditingController searchController;

  init() async {
    emit(state.copyWith(isLoading: true));
    mainController = PageController();
    groupToppingController = PageController();
    menuController = PageController();
    // searchMainController = PageController();
    nameMenuEditController = TextEditingController();
    searchController = TextEditingController();
    await getAllTopping();
    await getAllMenu();
    emit(state.copyWith(isLoading: false));
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
            status: "active",
            productStatus: type.productStatus,
            approvalStatus: type.approvalStatus);
        final response = await repository.getListMenu(request);
        // log("check json: ${response?.toJson()}");
        listAllMenu.add(DataMenuTypeDomain(
            data: response?.items,
            type: type,
            totalProducts: response?.totalProducts));
      }
      emit(state.copyWith(
          listMenu: listAllMenu,
          listFoodByMenu: ListFoodByMenuDomain(
              idSellected: null, type: null, listFoodByMenu: [])));
    } on DioException catch (e) {
      log("getAllMenu error: ${e.message}");
    }
  }

  getListFoodByMenu(
      {required MenuType type, required int productCategoryId}) async {
    try {
      emit(state.copyWith(isLoading: true));
      if (state.listFoodByMenu?.type == type &&
          state.listFoodByMenu?.idSellected == productCategoryId) {
        emit(state.copyWith(isHideListFoodByMenu: !state.isHideListFoodByMenu));
      } else {
        final request = ListMenuFoodRequest(
            status: type.productStatus,
            approvalStatus: type.approvalStatus,
            productCategoryId: productCategoryId);
        final response = await repository.detailFoodByMenu(request);
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(
            listFoodByMenu: ListFoodByMenuDomain(
                idSellected: productCategoryId,
                type: type,
                listFoodByMenu: response?.items),
            isHideListFoodByMenu: false,
            textErrorToast:
                response?.items.isNotEmpty == true ? null : "Không có món ăn"));
      }
    } on DioException catch (e) {
      log("getListMenuFood error: ${e.message}");
      emit(state.copyWith(textErrorToast: e.message));
    }
  }

  checkShowClearSearch() {
    emit(state.copyWith(
        isShowClearSearch: searchController.text.isNotNullOrEmpty));
  }

  searchFoodByMenu(String value) async {
    try {
      List<ResultSearchMenuTypeDomain> listResultSearch = [];
      bool _enableChangePage = true;
      if (value.isNotNullOrEmpty) {
        for (var type in MenuType.values) {
          final request = ListMenuFoodRequest(
            status: type.productStatus,
            approvalStatus: type.approvalStatus,
            search: value,
          );
          final response = await repository.detailFoodByMenu(request);
          if (response != null) {
            if (response.items.isNotEmpty && _enableChangePage) {
              log("result focus: $type", name: "MenuDinerCubit");
              _enableChangePage = false;
              changePageMenu(type.index, type);
            }
            if (_enableChangePage) {
              log("focus active", name: "MenuDinerCubit");
              changePageMenu(0, MenuType.active);
            }
            listResultSearch.add(ResultSearchMenuTypeDomain(
                type: type, listResult: response.items));
          }
        }
        emit(state.copyWith(listResultSearchMenu: listResultSearch));
      }
      // else {
      //   Timer(const Duration(milliseconds: 500), () {
      //     emit(state.copyWith(listResultSearchMenu: []));
      //     changePageMenu(0, MenuType.active);
      //   });
      // }
    } on DioException catch (e) {
      log("getAllMenu error: ${e.message}");
    }
  }

  searchTopping(String value) async {
    List<DataToppingTypeDomain> listResultSearch = [];
    bool _enableChangePage = true;
    if (value.isNotNullOrEmpty) {
      for (var type in ToppingType.values) {
        final request =
            GetGroupToppingRequest(status: type.status, search: value);
        final response = await repository.getGroupTopping(request);
        if (_enableChangePage && response?.items.isNotEmpty == true) {
          _enableChangePage = false;
          changeGroupTopping(type.index, type);
        }
        if (_enableChangePage) {
          changeGroupTopping(0, ToppingType.active);
        }
        listResultSearch.add(DataToppingTypeDomain(response?.items, type));
      }
      emit(state.copyWith(listResultSearchTopping: listResultSearch));
    }
    // else {
    //   Timer(const Duration(milliseconds: 500), () {
    //     emit(state.copyWith(listResultSearchTopping: [
    //       DataToppingTypeDomain([], ToppingType.active)
    //     ]));
    //     changeGroupTopping(0, ToppingType.active);
    //   });
    // }
  }

  hideOrShowTopping(GrAddToppingResponse topping,
      {bool isHide = true, bool isSearch = false}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final request =
          topping.responseToRequest(newStatus: isHide ? "inactive" : "active");
      final response =
          await repository.addGroupTopping(request, id: topping.id);
      if (response != null) {
        await getAllTopping();
        if (isSearch) {
          searchTopping(searchController.text);
        }
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(
            errorEditTopping: "Không thể thay đổi trạng thái topping"));
      }
    } on DioException catch (e) {
      log("editTopping error: ${e.message}");
      emit(state.copyWith(errorEditTopping: e.message));
    }
  }

  deleteGroupTopping(int id, {bool isSearch = false}) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await repository.removeGroupTopping(id);
      if (response != null) {
        await getAllTopping();
        if (isSearch) {
          searchTopping(searchController.text);
        }
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(errorEditTopping: "Không thể xoá topping"));
      }
    } on DioException catch (e) {
      log("deleteGroupTopping error: ${e.message}");
      emit(state.copyWith(errorEditTopping: e.message));
    }
  }

  hideOrShowMenuFood(MenuFoodResponseItem item,
      {bool isHide = true,
      required int productCategoryId,
      bool isSearch = false}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final request = FoodRegisterMenuRequest(
        status: isHide ? "inactive" : "active",
        name: item.name,
        price: item.price.toDouble(),
        imageId: item.imageId,
        productCategoryId: productCategoryId,
      );

      final httpRequest =
          await repository.updateFoodInMenu(request, id: item.id);
      if (httpRequest != null) {
        await getAllMenu();
        if (isSearch) {
          searchFoodByMenu(searchController.text);
        }
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(
            errorEditTopping: "Không thể thay đổi trạng thái topping"));
      }
    } on DioException catch (e) {
      log("hideOrShowMenuFood error: ${e.message}");
      emit(state.copyWith(errorEditTopping: e.message));
    }
  }

  hideShowMenuGroup(int id, {bool isHide = false}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final httpRequest =
          await repository.hideOrShowMenuGroup(id, isHide: isHide);
      if (httpRequest != null) {
        await getAllMenu();
        emit(state.copyWith(
            textErrorToast:
                "${isHide ? "Ẩn" : "Hiển thị"} tất cả các món thành công"));
      } else {
        emit(state.copyWith(
            errorEditTopping: "Không thể thay đổi trạng thái topping"));
      }
    } on DioException catch (e) {
      log("hideOrShowMenuFood error: ${e.message}");
      emit(state.copyWith(errorEditTopping: e.message));
    }
  }

  deleteMenuFood({required int id, bool isSearch = false}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final httpRequest = await repository.deleteFood(id);
      if (httpRequest != null) {
        await getAllMenu();
        if (isSearch) {
          searchFoodByMenu(searchController.text);
        }
        emit(state.copyWith(textErrorToast: "Xoá món thành công"));
      } else {
        emit(state.copyWith(errorEditTopping: "Không thể xoá món"));
      }
    } on DioException catch (e) {
      log("hideOrShowMenuFood error: ${e.message}");
      emit(state.copyWith(errorEditTopping: e.message));
    }
  }

  deleteGroupMenu(int id) async {
    try {
      emit(state.copyWith(isLoading: true));
      final httpRequest = await repository.removeGroupMenu(id);
      if (httpRequest != null) {
        await getAllMenu();
        emit(state.copyWith(textErrorToast: "Xoá món thành công"));
      } else {
        // emit(state.copyWith(errorEditTopping: "Không thể xoá món"));
        emit(state.copyWith(errorRemoveGroup: true));
      }
    } on DioException catch (e) {
      log("hideOrShowMenuFood error: ${e.message}");
      emit(state.copyWith(
          errorEditTopping: e.message == "CATEGORY_HAS_PRODUCTS"
              ? "Danh mục chứa sản phẩm đang hoạt động."
              : e.message));
    }
  }

  getDetailFoodById(int id) async {
    try {
      emit(state.copyWith(isLoading: true));
      final httpRequest = await repository.getDetailFoodById(id);
      if (httpRequest != null) {
        log("get detail topping success: $httpRequest", name: tag);
        emit(state.copyWith(detailFoodData: httpRequest));
      } else {
        emit(state.copyWith(errorRemoveGroup: true));
      }
    } on DioException catch (e) {
      log("hideOrShowMenuFood error: ${e.message}");
      emit(state.copyWith(errorEditTopping: e.message));
    }
  }

  editMenuGroupName(int id) async {
    if (nameMenuEditController.text.isNotNullOrEmpty) {
      try {
        emit(state.copyWith(isLoading: true));
        final httpRequest =
            await repository.updateGroupMenu(nameMenuEditController.text, id);
        if (httpRequest != null) {
          // emit(state.copyWith(textErrorToast: "Sửa tên nhóm thành công"));
          emit(state.copyWith(editNameGroupSuccess: true));
        } else {
          emit(state.copyWith(errorEditTopping: "Không thể sửa tên nhóm"));
        }
      } on DioException catch (e) {
        log("hideOrShowMenuFood error: ${e.message}");

        emit(state.copyWith(
            errorEditTopping:
                e.message == "NAME_EXISTED" ? "Tên đã tồn tại" : e.message));
      }
    }
  }

  validateNameGrMenuEdit() {
    emit(state.copyWith(
        showClearNameEditMenu: nameMenuEditController.text.isNotNullOrEmpty));
  }

  hideOrShowSearch() {
    searchController.clear();
    emit(state.copyWith(
      isShowSearch: !state.isShowSearch,
      listResultSearchMenu: [],
      listResultSearchTopping: [],
    ));
  }
}
