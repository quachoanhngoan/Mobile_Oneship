import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom_state.dart';

class ToppingCustomCubit extends Cubit<ToppingCustomState> {
  ToppingCustomCubit() : super(const ToppingCustomState());

  final TextEditingController nameGroupToppingController =
      TextEditingController();
  final TextEditingController linkFoodController = TextEditingController();
  final TextEditingController nameToppingController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final PageController pageController = PageController();

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
    } else {
      Get.back();
    }
  }

  nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  checkFilledInfomation() {
    if (pageController.page != null && pageController.page!.round() > 0) {
      final isFilled = nameToppingController.text.isNotNullOrEmpty &&
          priceController.text.isNotNullOrEmpty;
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

  String nameToppingTest = "Nhiều đá";

  validateNameTopping(String value) {
    if (value.isNullOrEmpty) {
      emit(state.copyWith(errorNameTopping: null, isToppingClearButton: false));
    } else {
      if (value == nameToppingTest) {
        emit(state.copyWith(
            errorNameTopping: AppErrorString.kNameToppingConflict,
            isToppingClearButton: true));
      } else {
        emit(state.copyWith(errorNameTopping: "", isToppingClearButton: true));
      }
    }
  }

  validatePriceTopping(String value) {
    // if (value.isNullOrEmpty) {
    //   emit(state.copyWith(errorPriceTopping: null));
    // } else {
    //   log("check price: $value");
    //   if (value.length > 3) {
    //     emit(state.copyWith(errorPriceTopping: null));
    //   } else {
    //     emit(state.copyWith(errorPriceTopping: AppErrorString.kPriceTopping));
    //   }
    // }
    emit(state.copyWith(isPriceClearButton: value.isNotNullOrEmpty));
  }
}
