import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/order/cancel.model.dart';
import 'package:oneship_merchant_app/presentation/data/model/order/order_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/cart_repository.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final CartRepository repository;
  OrderCubit(this.repository) : super(OrderState()) {
    getCancelReasons();
  }

  setStatusState(EState value) {
    emit(state.copyWith(status: value));
  }

  setCancelState(EState value) {
    emit(state.copyWith(cancelState: value));
  }

  setConfirmState(EState value) {
    emit(state.copyWith(confirmState: value));
  }

  getOrderById(int id) async {
    setStatusState(EState.loading);
    try {
      final response = await execute(
        () => repository.getOrderByID(id.toString()),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        emit(state.copyWith(order: data));
        setStatusState(EState.success);
      }, failure: (error) {
        setStatusState(EState.failure);
      });
    } catch (e) {
      setStatusState(EState.failure);
    }
  }

  getOrderByIdNoneLoading(int id) async {
    final response = await execute(
      () => repository.getOrderByID(id.toString()),
      isShowFailDialog: true,
    );
    response.when(
        success: (data) {
          emit(state.copyWith(order: data));
        },
        failure: (error) {});
  }

  cancelById(int id, String reason) async {
    setCancelState(EState.loading);
    try {
      final response = await execute(
        () => repository.cancelOrder(id.toString(), reason),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        getOrderByIdNoneLoading(id);

        setCancelState(EState.success);
        dialogService.showAlertDialog(
            title: 'Thông báo',
            description: 'Đơn hàng đã được hủy thành công',
            buttonTitle: 'Đóng',
            onPressed: () {
              Get.back();
            });
      }, failure: (error) {
        setCancelState(EState.failure);
      });
    } catch (e) {
      setCancelState(EState.failure);
    }
  }

  confirmOrder(int id) async {
    setConfirmState(EState.loading);
    try {
      final response = await execute(
        () => repository.confirmOrder(id.toString()),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        getOrderByIdNoneLoading(id);

        setConfirmState(EState.success);
        dialogService.showAlertDialog(
            title: 'Thông báo',
            description: 'Đơn hàng đã được xác nhận thành công',
            buttonTitle: 'Đóng',
            onPressed: () {
              Get.back();
            });
      }, failure: (error) {
        setConfirmState(EState.failure);
      });
    } catch (e) {
      setConfirmState(EState.failure);
    }
  }

  getCancelReasons() async {
    try {
      final response = await execute(
        () => repository.getCancelReasons(),
        isShowFailDialog: true,
      );
      response.when(
          success: (data) {
            emit(state.copyWith(listCancelOrder: data));
            //add default reason
            emit(state.copyWith(
              listCancelOrder: [
                ...data,
                const CancelModel(id: 0, name: 'Lý do khác'),
              ],
            ));
          },
          failure: (error) {});
    } catch (e) {}
  }
}
