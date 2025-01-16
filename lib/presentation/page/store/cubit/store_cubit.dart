import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/routes/routes.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/store_request_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/work_time_page.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

part 'store_state.dart';

StoreModel? currentStore;

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository repository;
  StoreCubit(this.repository) : super(StoreState());

  String tag = "StoreCubit";
  addEmptySpecialWorkingTime() {
    final newData = List<SpecialWorkingTime>.from(state.specialWorkingTimes);
    newData.add(SpecialWorkingTime(
      date: null,
      startTime: null,
      endTime: null,
    ));

    emit(state.copyWith(
      specialWorkingTimes: newData,
    ));
  }

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
      setStatusState(EState.failure);
    }
  }

  getStoreById() async {
    setStatusState(EState.loading);
    try {
      final response = await execute(
        () => repository.getStoreModelById(currentStore!.id!),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        setStatusState(EState.success);
        emit(state.copyWith(
          store: data,
          isPause: data.isPause ?? false,
          isSpecialWorkingTime: data.isSpecialWorkingTime ?? false,
          specialWorkingTimes: data.specialWorkingTimes ?? [],
        ));
        currentStore = data;
        setWorkingTime(data.workingTimes!);
      }, failure: (error) {
        setStatusState(EState.failure);
      });
    } catch (e) {
      setStatusState(EState.failure);
    }
  }

  setWorkingTime(List<WorkingTime> value) {
    emit(state.copyWith(wkts: const [
      WorkTimeModel(
        dayOfWeek: "Thứ 2",
        dayOfWeekNumber: 1,
        isOff: false,
      ),
      WorkTimeModel(
        dayOfWeek: "Thứ 3",
        dayOfWeekNumber: 2,
        isOff: false,
      ),
      WorkTimeModel(
        dayOfWeek: "Thứ 4",
        dayOfWeekNumber: 3,
        isOff: false,
      ),
      WorkTimeModel(
        dayOfWeek: "Thứ 5",
        dayOfWeekNumber: 4,
        isOff: false,
      ),
      WorkTimeModel(
        dayOfWeek: "Thứ 6",
        dayOfWeekNumber: 5,
        isOff: false,
      ),
      WorkTimeModel(
        dayOfWeek: "Thứ 7",
        dayOfWeekNumber: 6,
        isOff: false,
      ),
      WorkTimeModel(
        dayOfWeek: "Chủ nhật",
        dayOfWeekNumber: 0,
        isOff: false,
      ),
    ]));
    for (var el in value) {
      if (el.dayOfWeek != null) {
        final finedDayOfWeek = state.wkts
            .firstWhere((element) => element.dayOfWeekNumber == el.dayOfWeek);
        final index = state.wkts.indexOf(finedDayOfWeek);
        //remove all element in list

        //asign new value
        var newData = List<WorkTimeModel>.from(state.wkts);
        var wkts = List<WKT>.from(newData[index].wkt);
        wkts.add(WKT(
          dayOfWeek: el.dayOfWeek!,
          openTime: el.openTime!,
          closeTime: el.closeTime!,
        ));
        newData[index] = newData[index].copyWith(wkt: wkts);

        emit(state.copyWith(wkts: newData));
      }
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

        dialogService.showNotificationSuccess("Đăng nhập thành công");
      }, failure: (error) {
        setLoginState(EState.failure);
      });
    } catch (e) {
      setLoginState(EState.failure);
    }
  }

  setUpdateStore(EState value) {
    emit(state.copyWith(updateStore: value));
  }

  Future registerStorePress() async {
    setUpdateStore(EState.loading);
    final List<WKT> listWorkingTimes = [];
    for (var element in state.wkts) {
      listWorkingTimes.addAll(element.wkt);

      //check closeTime empty
      if (element.wkt.any(
          (element) => element.closeTime == null || element.closeTime! < 0)) {
        dialogService.showNotificationError("Không được để trống khung giờ");
        setUpdateStore(EState.failure);
        return;
      }
      if (element.wkt.any(
          (element) => element.closeTime == null || element.openTime! < 0)) {
        dialogService.showNotificationError("Không được để trống khung giờ");
        setUpdateStore(EState.failure);
        return;
      }
    }

    final workingTimesParse = listWorkingTimes
        .map((e) => WorkingTime(
              dayOfWeek: e.dayOfWeek,
              openTime: e.openTime,
              closeTime: e.closeTime,
            ))
        .toList();

    final request = StoreRequestModel(
      workingTimes: workingTimesParse,
    );

    final response = await execute(
      () => repository.registerPatchStore(currentStore!.id!, request),
      isShowFailDialog: true,
    );
    response.when(success: (data) {
      dialogService.showNotificationSuccess("Cập nhật thành công");
      setUpdateStore(EState.success);
      getStoreById();
    }, failure: (error) {
      dialogService.showNotificationError(error);
      setUpdateStore(EState.failure);
    });
  }

  Future updateSpecialWorkingTime() async {
    setUpdateStore(EState.loading);
    if (state.specialWorkingTimes
        .any((element) => element.date == null || element.date! == "")) {
      dialogService.showNotificationError("Không được để trống ngày");
      setUpdateStore(EState.failure);
      return;
    }
    if (state.specialWorkingTimes.any(
        (element) => element.startTime == null || element.startTime! < 0)) {
      dialogService.showNotificationError("Không được để trống khung giờ");
      setUpdateStore(EState.failure);
      return;
    }
    if (state.specialWorkingTimes
        .any((element) => element.endTime == null || element.endTime! < 0)) {
      dialogService.showNotificationError("Không được để trống khung giờ");
      setUpdateStore(EState.failure);
      return;
    }

    final request = StoreRequestModel(
      specialWorkingTimes: state.specialWorkingTimes,
    );

    final response = await execute(
      () => repository.registerPatchStore(currentStore!.id!, request),
      isShowFailDialog: true,
    );
    response.when(success: (data) {
      dialogService.showNotificationSuccess("Cập nhật thành công");
      setUpdateStore(EState.success);
      getStoreById();
    }, failure: (error) {
      // dialogService.showNotificationError(error);
      setUpdateStore(EState.failure);
    });
  }

  Future setPauseStore(bool value) async {
    // setStatus(EState.loading);

    final request = StoreRequestModel(isPause: value);

    final response = await execute(
      () => repository.registerPatchStore(currentStore!.id!, request),
      isShowFailDialog: true,
    );
    response.when(success: (data) {
      emit(state.copyWith(
        isPause: data.isPause,
      ));
      dialogService.showNotificationSuccess(
          "Chế độ tạm nghỉ đã được ${data.isPause! ? "kích hoạt" : "tắt"}");
      // setStatus(EState.success);
    }, failure: (error) {
      dialogService.showNotificationError("Có lỗi xảy ra");
    });
  }

  Future setSpecialWorkingTime(bool value) async {
    // setStatus(EState.loading);

    final request = StoreRequestModel(isSpecialWorkingTime: value);

    final response = await execute(
      () => repository.registerPatchStore(currentStore!.id!, request),
      isShowFailDialog: false,
    );
    response.when(success: (data) {
      emit(state.copyWith(
        isSpecialWorkingTime: data.isSpecialWorkingTime,
      ));
      dialogService.showNotificationSuccess(
          "Chế độ ngày đặc biệt đã được ${data.isSpecialWorkingTime == true ? "kích hoạt" : "tắt"}");
      // setStatus(EState.success);
    }, failure: (error) {
      dialogService.showNotificationError("Có lỗi xảy ra");
    });
  }

  setSpecialWorkingTimeValue(SpecialWorkingTime value, int index) {
    final finedDayOfWeek = state.specialWorkingTimes[index];
    final index2 = state.specialWorkingTimes.indexOf(finedDayOfWeek);
    final newData = List<SpecialWorkingTime>.from(state.specialWorkingTimes);
    newData[index2] = value;
    emit(state.copyWith(specialWorkingTimes: newData));
  }

  Future setSpecialTimeStore(bool value) async {
    // setStatus(EState.loading);

    final request = StoreRequestModel(isSpecialWorkingTime: value);

    final response = await execute(
      () => repository.registerPatchStore(currentStore!.id!, request),
      isShowFailDialog: true,
    );
    response.when(success: (data) {
      emit(state.copyWith(
        isSpecialWorkingTime: data.isSpecialWorkingTime,
      ));
      dialogService.showNotificationSuccess(
          "Chế độ ngày đặc biệt đã được ${data.isSpecialWorkingTime == true ? "kích hoạt" : "tắt"}");
      // setStatus(EState.success);
    }, failure: (error) {
      dialogService.showNotificationError("Có lỗi xảy ra");
    });
  }

  setDayOfWeek(WorkTimeModel value) {
    final finedDayOfWeek = state.wkts.firstWhere(
        (element) => element.dayOfWeekNumber == value.dayOfWeekNumber);
    final index = state.wkts.indexOf(finedDayOfWeek);

    //asign new value
    var newData = List<WorkTimeModel>.from(state.wkts);
    newData[index] = value;

    emit(state.copyWith(wkts: newData));
  }

  removeSpecialWorkingTime(int index) {
    final finedDayOfWeek = state.specialWorkingTimes[index];
    final index2 = state.specialWorkingTimes.indexOf(finedDayOfWeek);

    //asign new value
    var newData = List<SpecialWorkingTime>.from(state.specialWorkingTimes);
    newData.removeAt(index2);
    emit(state.copyWith(specialWorkingTimes: newData));
  }

  resetState() {
    emit(StoreState());
  }
}
