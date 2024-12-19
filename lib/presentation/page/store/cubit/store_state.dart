part of 'store_cubit.dart';

class StoreState {
  final EState status;
  final List<StoreModel> stores;

  StoreState({
    this.status = EState.initial,
    this.stores = const [],
  });

  StoreState copyWith({
    EState? status,
    List<StoreModel>? stores,
  }) {
    return StoreState(
      status: status ?? this.status,
      stores: stores ?? this.stores,
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
