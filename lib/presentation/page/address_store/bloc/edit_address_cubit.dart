import 'package:bloc/bloc.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/address.model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';
import 'package:oneship_merchant_app/presentation/page/address_store/bloc/request_update_address.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

part 'edit_address_state.dart';

class EditAddressBloc extends Cubit<EditAddressState> {
  final StoreRepository repository;
  EditAddressBloc(this.repository) : super(EditAddressState());

  Future<void> getAddresss() async {
    setGetBannerStatus(EState.loading);
    try {
      final response = await execute(
        () => repository.getAddresss(),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        setGetBannerStatus(EState.success);
        emit(state.copyWith(addressStores: data));
      }, failure: (error) {
        setGetBannerStatus(EState.failure);
      });
    } catch (e) {
      setGetBannerStatus(EState.failure);
    }
  }

  Future<void> updateAddress(String type) async {
    setUpdateStatus(EState.loading);
    setRequestUpdateAddress(
      state.requestUpdateAddress.copyWith(
        type: type,
      ),
    );
    try {
      final response = await execute(
        () => repository.updateAddresss(
          state.requestUpdateAddress,
        ),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        setUpdateStatus(EState.success);
        dialogService.showNotificationSuccess("Cập nhật thành công");
      }, failure: (error) {
        // dialogService.showNotificationError(error);
        setUpdateStatus(EState.failure);
      });
    } catch (e) {
      setUpdateStatus(EState.failure);
    }
  }

  setUpdateStatus(EState value) {
    emit(state.copyWith(updateAddressStatus: value));
  }

  setGetBannerStatus(EState value) {
    emit(state.copyWith(getBannerStatus: value));
  }

  resetState() {
    emit(EditAddressState());
  }

  setRequestUpdateAddress(RequestUpdateAddress value) {
    emit(state.copyWith(requestUpdateAddress: value));
  }
}
