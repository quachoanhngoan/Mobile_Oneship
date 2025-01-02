part of 'store_cubit.dart';

class StoreState {
  final EState status;
  final EState loginState;
  final List<StoreModel> stores;
  final CreateStoreResponse? store;

  StoreState({
    this.status = EState.initial,
    this.stores = const [],
    this.loginState = EState.initial,
    this.store,
  });

  StoreState copyWith({
    EState? status,
    EState? loginState,
    List<StoreModel>? stores,
    CreateStoreResponse? store,
  }) {
    return StoreState(
      status: status ?? this.status,
      loginState: loginState ?? this.loginState,
      stores: stores ?? this.stores,
      store: store ?? this.store,
    );
  }

  List<StoreModel> get getStoresDontApprove => stores
      .where(
          (element) => element.approvalStatus != EStoreApprovalStatus.approved)
      .toList();
  int get getStoresDontApproveCount => getStoresDontApprove.length;

  List<StoreModel> get getStoresApprove => stores
      .where(
          (element) => element.approvalStatus == EStoreApprovalStatus.approved)
      .toList();
  int get getStoresApproveCount => getStoresApprove.length;
}
