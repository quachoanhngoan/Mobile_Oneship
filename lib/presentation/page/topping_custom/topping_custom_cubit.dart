import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_response.dart';
import 'package:oneship_merchant_app/presentation/data/repository/menu_repository.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/domain/topping_item_domain.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom_state.dart';

import '../../data/model/menu/linkfood_request.dart';

class ToppingCustomCubit extends Cubit<ToppingCustomState> {
  final MenuRepository repository;

  ToppingCustomCubit(this.repository) : super(const ToppingCustomState());

  final TextEditingController nameGroupToppingController =
      TextEditingController();
  final TextEditingController linkFoodController = TextEditingController();
  final TextEditingController nameToppingController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final PageController pageController = PageController();

  var _isEditTopping = false;

  late ToppingItemDomain toppingEdit;
  GrAddToppingResponse? dataEditGroupTopping;

  // List<ProductAddTopping> _listIdLinkFoodSellected = [];

  init({GrAddToppingResponse? topping}) {
    getLinkFood();
    if (topping != null) {
      dataEditGroupTopping = topping;
      nameGroupToppingController.text = topping.name;
      List<ToppingItemDomain> listTopping = [];
      for (var item in topping.options) {
        listTopping.add(ToppingItemDomain(
            name: item.name,
            price: "${item.price} vnđ",
            type: item.status == "active"
                ? StatusToppingType.isInUse
                : StatusToppingType.isUnused));
      }
      emit(state.copyWith(listTopping: listTopping));
      checkFilledInfomation();
    } else {
      dataEditGroupTopping = null;
    }
  }

  pageChange(int value) {
    if (value > 0) {
      emit(state.copyWith(title: "Thêm topping"));
    } else {
      emit(state.copyWith(title: "Thêm nhóm topping"));
    }
    checkFilledInfomation();
  }

  previousStepPage() {
    if (pageController.page != null && pageController.page!.round() > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      nameToppingController.clear();
      priceController.clear();
    } else {
      Get.back();
    }
  }

  nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  checkFilledInfomation() {
    if (dataEditGroupTopping == null) {
      if (pageController.page != null && pageController.page!.round() > 0) {
        final isFilled = nameToppingController.text.isNotNullOrEmpty &&
            priceController.text.isNotNullOrEmpty &&
            (state.errorNameTopping == null || state.errorNameTopping == "");
        emit(state.copyWith(isFilledInfo: isFilled, isShowClearName: true));
      } else {
        final isFilled = nameGroupToppingController.text.isNotNullOrEmpty &&
            state.listTopping.isNotEmpty;
        emit(state.copyWith(
            isFilledInfo: isFilled,
            isShowClearName: nameGroupToppingController.text.isNotNullOrEmpty));
      }
    } else {
      final isFilled = nameGroupToppingController.text.isNotNullOrEmpty;
      emit(state.copyWith(isFilledInfo: isFilled, isShowClearName: isFilled));
    }
  }

  changeTypeOptionTopping(int index) {
    emit(state.copyWith(indexOptionTopping: index));
  }

  validateNameTopping() {
    if (nameToppingController.text.isNullOrEmpty) {
      emit(state.copyWith(errorNameTopping: null, isToppingClearButton: false));
    } else {
      final listTopping = state.listTopping;
      var isConflictName = false;
      for (var item in listTopping) {
        if (item.name?.toLowerCase() ==
            nameToppingController.text.toLowerCase()) {
          isConflictName = true;
        }
      }
      if (isConflictName) {
        emit(state.copyWith(
            errorNameTopping: AppErrorString.kNameToppingConflict,
            isToppingClearButton: true));
      } else {
        emit(state.copyWith(errorNameTopping: "", isToppingClearButton: true));
      }
    }
  }

  validatePriceTopping() {
    emit(state.copyWith(
        isPriceClearButton: priceController.text.isNotNullOrEmpty));
  }

  saveInfoClick() async {
    if (pageController.page != null && pageController.page! > 0) {
      //add or edit topping
      if (!_isEditTopping) {
        final listTopping = List.of(state.listTopping);
        listTopping.add(ToppingItemDomain(
            name: nameToppingController.text,
            price: priceController.text,
            type: StatusToppingType.isInUse));
        emit(state.copyWith(
            listTopping: listTopping,
            isPriceClearButton: false,
            isToppingClearButton: false));
      } else {
        final listTopping = state.listTopping.map((e) {
          if (e == toppingEdit) {
            return e.copyWith(
                name: nameToppingController.text, price: priceController.text);
          }
          return e;
        }).toList();
        emit(state.copyWith(listTopping: listTopping));
      }
      previousStepPage();
    } else {
      if (dataEditGroupTopping == null) {
        try {
          //save all add topping
          emit(state.copyWith(isLoading: true));

          final listAddTopping = state.listTopping;
          List<OptionAddTopping> convertListAddTopping = [];
          for (ToppingItemDomain option in listAddTopping) {
            if (option.convertAddTopping() != null) {
              convertListAddTopping.add(option.convertAddTopping()!);
            }
          }

          final request = GrToppingRequest(
              name: nameGroupToppingController.text,
              isMultiple: state.indexOptionTopping != 0,
              status: "active",
              options: convertListAddTopping);
          final response = await repository.addGroupTopping(request);
          if (response != null) {
            emit(state.copyWith(isCompleteSuccess: true));
          } else {
            emit(
                state.copyWith(showErrorComplete: AppErrorString.kServerError));
          }
        } on DioException catch (e) {
          log("check error: ${e.message}");
          emit(state.copyWith(
              showErrorComplete: e.message == "NAME_EXISTED"
                  ? "Tên nhóm topping đã tồn tại"
                  : e.message));
        }
      } else {
        try {
          //save all edit group topping
          emit(state.copyWith(isLoading: true));

          final listAddTopping = state.listTopping;
          List<OptionAddTopping> convertListAddTopping = [];
          for (ToppingItemDomain option in listAddTopping) {
            if (option.convertAddTopping() != null) {
              convertListAddTopping.add(option.convertAddTopping()!);
            }
          }

          final requestBody = GrToppingRequest(
              name: nameGroupToppingController.text,
              isMultiple: state.indexOptionTopping != 0,
              status: "active",
              options: convertListAddTopping,
              products: state.listIdLinkFoodSellected);
          final response = await repository.addGroupTopping(requestBody,
              id: dataEditGroupTopping!.id);
          if (response != null) {
            emit(state.copyWith(isCompleteSuccess: true));
          } else {
            emit(
                state.copyWith(showErrorComplete: AppErrorString.kServerError));
          }
        } on DioException catch (e) {
          log("check error: ${e.message}");
          emit(state.copyWith(
              showErrorComplete: e.message == "NAME_EXISTED"
                  ? "Tên nhóm topping đã tồn tại"
                  : e.message));
        }
      }
    }
  }

  changeStatusTopping(ToppingItemDomain item) {
    final updateListTopping = state.listTopping.map((e) {
      if (e.name == item.name) {
        if (e.type == StatusToppingType.isUnused) {
          return e.copyWith(type: StatusToppingType.isInUse);
        } else {
          return e.copyWith(type: StatusToppingType.isUnused);
        }
      }
      return e;
    }).toList();
    emit(state.copyWith(listTopping: updateListTopping));
  }

  removeTopping(ToppingItemDomain item) {
    final listTopping = List.of(state.listTopping);
    listTopping.remove(item);
    emit(state.copyWith(listTopping: listTopping));
  }

  setArgEditTopping(bool isEditToppinp) {
    _isEditTopping = isEditToppinp;
  }

  editTopping(ToppingItemDomain item) {
    nameToppingController.text = item.name ?? "";
    priceController.text = item.price ?? "";
    toppingEdit = item;
    nextPage();
  }

  getLinkFood() async {
    try {
      final request = LinkFoodRequest(
        includeProducts: true,
        status: "active",
        productStatus: "active",
        approvalStatus: "approved",
      );
      final response = await repository.getListMenu(request);
      emit(state.copyWith(listLinkFood: response?.items));
    } on DioException catch (e) {
      log("error getLinkFood: ${e.message}");
    }
  }

  listIdLinkFoodSellect(int id, {bool isAll = false}) {
    final listId = List<ProductAddTopping>.from(state.listIdLinkFoodSellected);
    final listLinkFood = state.listLinkFood;
    final isSellected = listId.firstWhereOrNull((e) => e.id == id) != null;
    if (isSellected) {
      if (isAll) {
        final listDetailLinkFood = listLinkFood
                .where((e) => e.id == id)
                .toList()
                .firstOrNull
                ?.products ??
            [];
        for (var detail in listDetailLinkFood) {
          listId.removeWhere((e) => e.id == detail.id);
        }
      }
      listId.removeWhere((e) => e.id == id);
    } else {
      if (isAll) {
        final listDetailLinkFood = listLinkFood
                .where((e) => e.id == id)
                .toList()
                .firstOrNull
                ?.products ??
            [];
        for (var detail in listDetailLinkFood) {
          listId.add(ProductAddTopping(id: detail.id));
        }
      }
      listId.add(ProductAddTopping(id: id));
    }
    // _listIdLinkFoodSellected.addAll(_filterDuplicateProducts(listId));
    emit(state.copyWith(
        listIdLinkFoodSellectedDraft: _filterDuplicateProducts(listId)));
  }

  List<ProductAddTopping> _filterDuplicateProducts(
      List<ProductAddTopping> products) {
    final seenIds = <int>{};
    return products.where((product) => seenIds.add(product.id)).toList();
  }

  clearListIdLinkFood() {
    // _listIdLinkFoodSellected.clear();
    emit(state.copyWith(listIdLinkFoodSellectedDraft: []));
  }

  listIdLinkFoodSellectConfirm() {
    List<String> listNameSellect = [];
    final listIdSellect = List.of(state.listIdLinkFoodSellectedDraft);
    for (var product in listIdSellect) {
      for (var linkFoodMain in state.listLinkFood) {
        if (linkFoodMain.id == product.id) {
          listNameSellect.add(linkFoodMain.name);
        } else {
          if (linkFoodMain.products != null &&
              linkFoodMain.products?.isNotEmpty == true) {
            for (var detail in linkFoodMain.products!) {
              if (detail.id == product.id) {
                listNameSellect.add(detail.name);
              }
            }
          }
        }
      }
    }
    // emit(state.copyWith(listIdLinkFoodSellected: _listIdLinkFoodSellected));
  }
}
