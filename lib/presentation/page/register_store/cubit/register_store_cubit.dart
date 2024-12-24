import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/district_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';
import 'package:oneship_merchant_app/presentation/data/validations/user_validation.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

import '../../../data/model/store/group_service_model.dart';
import '../../../data/model/store/provinces_model.dart';
import 'register_request.dart';

part 'register_store_state.dart';

class RegisterStoreCubit extends Cubit<RegisterStoreState> {
  final StoreRepository repository;
  RegisterStoreCubit(this.repository) : super(RegisterStoreState());

  final pageController = PageController();

  setStatusState(EState value) {
    emit(state.copyWith(status: value));
  }

  getAll() async {
    setStatusState(EState.loading);
    final response = await execute(
      () => repository.getAll(),
      isShowFailDialog: true,
    );
    response.when(success: (data) {
      setStatusState(EState.success);
      emit(state.copyWith(stores: data.items ?? []));
    }, failure: (error) {
      setStatusState(EState.failure);
    });
  }

  resetState() {
    emit(RegisterStoreState());
  }

  setAcceptTermsAndConditions(bool value) {
    emit(state.copyWith(isAcceptTermsAndConditions: value));
  }

  setCurrentPage(ERegisterPageType page) {
    emit(state.copyWith(currentPage: page));
  }

  setNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    if (state.currentPage == ERegisterPageType.typeOfService) {
      _getAllLocationBussiness();
      _getAllGroupService();
    }
    setCurrentPage(ERegisterPageType.values[state.currentPage.index + 1]);
  }

  setPreviousPage() {
    if (state.currentPage.index == 0) {
      dialogService.showAlertDialog(
        title: 'Thông báo',
        description: 'Bạn có chắc chắn muốn thoát khỏi quá trình đăng ký?',
        buttonTitle: 'Thoát',
        onCancel: () => Get.back(),
        onPressed: () {
          Get.back();
          Get.back();
        },
        buttonCancelTitle: 'Hủy',
      );
      return;
    }
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setCurrentPage(ERegisterPageType.values[state.currentPage.index - 1]);
  }

  typeServiceSellect(int type) {
    emit(state.copyWith(typeService: type));
  }

  alcoholSellect(bool isAlcohol) {
    emit(state.copyWith(isAlcohol: isAlcohol));
  }

  _getAllLocationBussiness() async {
    if (state.listProvinces.isEmpty) {
      final listProvinces = (await repository.getProvinces())?.provinces;
      emit(state.copyWith(listProvinces: listProvinces));
    }
  }

  sellectLocationBussiness(ProvinceModel provinces) {
    emit(state.copyWith(locationBusSellected: provinces));
  }

  nameStoreVerify(String? value) {
    emit(state.copyWith(showHintNameStore: !value.isNotNullOrEmpty));
  }

  validatePhone(String? phone) {
    if (phone.isNotNullOrEmpty) {
      final isPhone = injector.get<UserValidate>().phoneValid(phone!);
      if (isPhone) {
        emit(state.copyWith(errorPhoneContact: null));
      } else {
        emit(state.copyWith(errorPhoneContact: "Số điện thoại không đúng."));
      }
    } else {
      emit(state.copyWith(errorPhoneContact: null));
    }
  }

  _getAllGroupService() async {
    if (state.listGroupService.isEmpty) {
      final listGroupService = await repository.getGroupService();
      emit(state.copyWith(listGroupService: listGroupService));
    }
  }

  changeProvices(ProvinceModel provices) async {
    if (provices.id != null) {
      final listDistrict = await repository.listDistrict(provices.id!);
      emit(state.copyWith(listDistrict: listDistrict));
    }
  }

  changeDistrict(DistrictModel district) async {
    if (district.id != null) {
      final listWard = await repository.listWard(district.id!);
      emit(state.copyWith(listWard: listWard));
    }
  }

  verifyContinueInfoStore(
      {String? nameStore,
      String? phoneNumber,
      String? groupService,
      String? provinces,
      String? district,
      String? ward,
      String? homeAndStreet}) {
    if (nameStore.isNotNullOrEmpty &&
        phoneNumber.isNotNullOrEmpty &&
        groupService.isNotNullOrEmpty &&
        provinces.isNotNullOrEmpty &&
        district.isNotNullOrEmpty &&
        ward.isNotNullOrEmpty &&
        homeAndStreet.isNotNullOrEmpty) {
      emit(state.copyWith(isNextEnable: true));
    } else {
      emit(state.copyWith(isNextEnable: false));
    }
  }
}
