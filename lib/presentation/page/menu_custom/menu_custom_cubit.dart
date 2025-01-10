import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_menu_register_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/data/repository/menu_repository.dart';
import 'package:oneship_merchant_app/presentation/page/menu_custom/menu_custom_state.dart';

import '../../data/model/menu/category_global_response.dart';

class MenuCustomCubit extends Cubit<MenuCustomState> {
  final MenuRepository repository;
  MenuCustomCubit(this.repository) : super(const MenuCustomState());

  late TextEditingController gooCategoryController;
  late TextEditingController storeCategorController;

  init() {
    gooCategoryController = TextEditingController();
    storeCategorController = TextEditingController();
    getListCategory();
  }

  getListCategory() async {
    try {
      final response = await repository.getCategoryGlobal();
      emit(state.copyWith(listCategoryGlobal: response?.items));
    } on DioException catch (e) {
      log("error getLinkFood: ${e.message}");
    }
  }

  sellectCommonGooMenu() {
    if (!state.isSellectCheckBox) {
      storeCategorController.text = gooCategoryController.text;
    }
    emit(state.copyWith(isSellectCheckBox: !state.isSellectCheckBox));
    checkFilledInfo();
  }

  checkFilledInfo() {
    final isFilled = gooCategoryController.text.isNotNullOrEmpty &&
        storeCategorController.text.isNotNullOrEmpty;
    emit(state.copyWith(
      isFilledInfo: isFilled,
      isShowGooCategoryClear: gooCategoryController.text.isNotNullOrEmpty,
      isShowStoreCategorClear: storeCategorController.text.isNotNullOrEmpty,
    ));
  }

  sellectCategoryGoo(ItemCategoryGlobal value) {
    emit(state.copyWith(categorySellectGlobal: value));
  }

  confirmSellectCategoryGoo() {
    gooCategoryController.text = state.categorySellectGlobal?.name ?? "";
    if (state.isSellectCheckBox) {
      storeCategorController.text = gooCategoryController.text;
    }
    checkFilledInfo();
  }

  saveInfoClick() async {
    try {
      emit(state.copyWith(isLoading: true));
      var request = GrMenuRegisterRequest(
          name: storeCategorController.text,
          parentId: state.categorySellectGlobal?.id ?? 0);
      if (state.isSellectCheckBox) {
        request = GrMenuRegisterRequest(
            parentId: state.categorySellectGlobal?.id ?? 0);
      }
      final httpResponse = await repository.registerGroupMenu(request);
      if (httpResponse != null) {
        emit(state.copyWith(isCompleteSuccess: true));
      } else {
        emit(state.copyWith(isCompleteError: AppErrorString.kServerError));
      }
    } on DioException catch (e) {
      log("save Info Click error: ${e.message}");
      switch (e.message) {
        case "NAME_EXISTED":
          emit(state.copyWith(isCompleteError: "Tên danh mục đã tồn tại"));
          break;

        case "OK":
          emit(state.copyWith(
              isCompleteError: "Danh mục đã được tạo trước đó"));
          break;
        default:
          emit(state.copyWith(isCompleteError: e.message));
          break;
      }
    }
  }
}
