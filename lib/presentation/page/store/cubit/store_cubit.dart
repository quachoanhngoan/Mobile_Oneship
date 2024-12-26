import 'package:bloc/bloc.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository repository;
  StoreCubit(this.repository) : super(StoreState());

  setStatusState(EState value) {
    emit(state.copyWith(status: value));
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

  resetState() {
    emit(StoreState());
  }
}
