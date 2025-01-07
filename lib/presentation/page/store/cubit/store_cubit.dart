import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/routes/routes.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/create_store.response.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';

part 'store_state.dart';

StoreModel? currentStore;

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository repository;
  StoreCubit(this.repository) : super(StoreState());

  String tag = "StoreCubit";

  setStatusState(EState value) {
    emit(state.copyWith(status: value));
  }

  setLoginState(EState value) {
    emit(state.copyWith(loginState: value));
  }

  getAll() async {
    setStatusState(EState.loading);
    try {
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
    } catch (e) {
      print(e);
      setStatusState(EState.failure);
    }
  }

  deleteStore(int id) async {
    setStatusState(EState.loading);
    try {
      final response = await execute(
        () => repository.deleteStore(id),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        setStatusState(EState.success);
        emit(state.copyWith(
            stores:
                state.stores.where((element) => element.id != id).toList()));
        getAll();
      }, failure: (error) {
        setStatusState(EState.failure);
      });
    } catch (e) {
      setStatusState(EState.failure);
    }
  }

  loginStore(StoreModel store) async {
    setLoginState(EState.loading);
    try {
      log("store id login: ${store.id}", name: tag);
      final response = await execute(
        () => repository.loginStore(store.id!),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        setLoginState(EState.success);
        prefManager.token = data!.accessToken!;
        prefManager.refreshToken = data.refreshToken!;
        currentStore = store;
        Get.offAllNamed(AppRoutes.homepage);
      }, failure: (error) {
        setLoginState(EState.failure);
      });
    } catch (e) {
      setLoginState(EState.failure);
    }
  }

  resetState() {
    emit(StoreState());
  }
}
