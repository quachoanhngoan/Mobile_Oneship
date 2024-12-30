import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/domain/topping_item_domain.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom_state.dart';

class ToppingCustomCubit extends Cubit<ToppingCustomState> {
  ToppingCustomCubit() : super(const ToppingCustomState());

  final TextEditingController nameGroupToppingController =
      TextEditingController();
  final TextEditingController linkFoodController = TextEditingController();
  final TextEditingController nameToppingController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final PageController pageController = PageController();

  var _isEditTopping = false;
  late ToppingItemDomain toppingEdit;

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
    // nameToppingController.clear();
    // priceController.clear();
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  checkFilledInfomation() {
    if (pageController.page != null && pageController.page!.round() > 0) {
      final isFilled = nameToppingController.text.isNotNullOrEmpty &&
          priceController.text.isNotNullOrEmpty &&
          (state.errorNameTopping == null || state.errorNameTopping == "") &&
          priceController.text != "0 vnđ";
      emit(state.copyWith(isFilledInfo: isFilled));
    } else {
      final isFilled = nameGroupToppingController.text.isNotNullOrEmpty
          // && linkFoodController.text.isNotNullOrEmpty
          ;
      emit(state.copyWith(isFilledInfo: isFilled));
    }
  }

  changeTypeOptionTopping(int index) {
    emit(state.copyWith(indexOptionTopping: index));
  }

  validateNameTopping(String value) {
    if (value.isNullOrEmpty) {
      emit(state.copyWith(errorNameTopping: null, isToppingClearButton: false));
    } else {
      final listTopping = state.listTopping;
      var isConflictName = false;
      for (var item in listTopping) {
        if (item.name?.toLowerCase() == value.toLowerCase()) {
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

  validatePriceTopping(String value) {
    emit(state.copyWith(isPriceClearButton: value.isNotNullOrEmpty));
  }

  saveInfoClick() {
    if (pageController.page != null && pageController.page! > 0) {
      if (!_isEditTopping) {
        final listTopping = List.of(state.listTopping);
        listTopping.add(ToppingItemDomain(
            name: nameToppingController.text, price: priceController.text));
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
      // to do code
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
}
