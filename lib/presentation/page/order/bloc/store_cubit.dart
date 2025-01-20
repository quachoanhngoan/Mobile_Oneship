import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/store_request_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/work_time_page.dart';

part 'store_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final StoreRepository repository;
  OrderCubit(this.repository) : super(OrderState());

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
    // try {
    //   final response = await execute(
    //     () => repository.getStoreModelById(currentStore!.id!),
    //     isShowFailDialog: true,
    //   );
    //   response.when(success: (data) {
    //     setStatusState(EState.success);
    //     emit(state.copyWith(
    //       store: data,
    //       isPause: data.isPause ?? false,
    //       isSpecialWorkingTime: data.isSpecialWorkingTime ?? false,
    //       specialWorkingTimes: data.specialWorkingTimes ?? [],
    //     ));
    //   }, failure: (error) {
    //     setStatusState(EState.failure);
    //   });
    // } catch (e) {
    //   setStatusState(EState.failure);
    // }
  }
}
