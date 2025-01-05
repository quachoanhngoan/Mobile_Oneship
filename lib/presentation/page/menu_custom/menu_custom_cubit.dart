import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_menu_register_request.dart';
import 'package:oneship_merchant_app/presentation/data/repository/menu_repository.dart';
import 'package:oneship_merchant_app/presentation/page/menu_custom/menu_custom_state.dart';

class MenuCustomCubit extends Cubit<MenuCustomState> {
  final MenuRepository repository;
  MenuCustomCubit(this.repository) : super(const MenuCustomState());

  late TextEditingController gooCategoryController;
  late TextEditingController storeCategorController;

  init() {
    gooCategoryController = TextEditingController();
    storeCategorController = TextEditingController();
    emit(state.copyWith(listCategoryGlobal: listCategoryTest));
  }

  final List<String> listCategoryTest = [
    "Nước tăng lực",
    "Nước có gas",
    "Trà đá",
    "Nhân trần"
  ];

  sellectCommonGooMenu() {
    emit(state.copyWith(isSellectCheckBox: !state.isSellectCheckBox));
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

  sellectCategoryGoo(String value) {
    emit(state.copyWith(categorySellectGlobal: value));
  }

  confirmSellectCategoryGoo() {
    gooCategoryController.text = state.categorySellectGlobal ?? "";
    checkFilledInfo();
  }

  saveInfoClick() async {
    try {
      emit(state.copyWith(isLoading: true));
      final request =
          GrMenuRegisterRequest(name: storeCategorController.text, parentId: 0);
      final httpResponse = await repository.registerGroupMenu(request);
      if (httpResponse != null) {
        emit(state.copyWith(isCompleteSuccess: true));
      } else {
        emit(state.copyWith(isCompleteError: AppErrorString.kServerError));
      }
    } on DioException catch (e) {
      log("save Info Click error: ${e.message}");
      emit(state.copyWith(
          isCompleteError: e.message == "NAME_EXISTED"
              ? "Tên danh mục đã tồn tại"
              : e.message));
    }
  }
}
