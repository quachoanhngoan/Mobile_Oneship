import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/bank.model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

import '../../../data/model/store/provinces_model.dart';
import 'register_request.dart';

part 'register_store_state.dart';

class RegisterStoreCubit extends Cubit<RegisterStoreState> {
  final StoreRepository repository;
  RegisterStoreCubit(this.repository) : super(RegisterStoreState()) {
    _getAllBanks();
  }

  final pageController = PageController();
  final TextEditingController dateController = TextEditingController();
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
    }
    if (state.currentPage == ERegisterPageType.bankInformation) {
      _getAllBanks();
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

  _getAllBanks() async {
    if (state.banks.isEmpty) {
      final banks = await execute(
        () => repository.getBanks(),
        isShowFailDialog: true,
      );
      banks.when(
          success: (data) {
            emit(state.copyWith(banks: data ?? []));
          },
          failure: (error) {});
    }
  }

  _getBranchBanks(String bankId) async {
    final branchBanks = await execute(
      () => repository.getBanksBranch(bankId),
      isShowFailDialog: true,
    );
    branchBanks.when(
        success: (data) {
          emit(state.copyWith(branchBanks: data ?? []));
        },
        failure: (error) {});
  }

  sellectLocationBussiness(ProvinceModel provinces) {
    emit(state.copyWith(locationBusSellected: provinces));
  }

  setBankRequest(BankRequest? request) {
    if (request != null) {
      if (request.bankId != null &&
          request.bankId != state.bankRequest?.bankId) {
        emit(state.copyWith(
          bankRequest: request,
          branchBanks: [],
        ));
        _getBranchBanks(request.bankId!);
      } else {
        emit(state.copyWith(bankRequest: request));
      }
    }
  }

  nameStoreVerify(String? value) {
    emit(state.copyWith(showHintNameStore: !value.isNotNullOrEmpty));
  }

  setRepresentative(Representative? value) {
    print("value?.type");
    print(value?.type);
    emit(state.copyWith(representative: value));
  }
}
