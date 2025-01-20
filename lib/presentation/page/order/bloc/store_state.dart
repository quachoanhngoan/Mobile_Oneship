part of 'store_cubit.dart';

class OrderState {
  final EState status;
  final EState loginState;
  final EState updateStore;
  final List<StoreModel> stores;
  final bool isPause;
  final bool isSpecialWorkingTime;
  final List<SpecialWorkingTime> specialWorkingTimes;

  final StoreModel? store;
  final List<WorkTimeModel> wkts;

  OrderState({
    this.status = EState.initial,
    this.stores = const [],
    this.loginState = EState.initial,
    this.updateStore = EState.initial,
    this.store,
    this.isPause = false,
    this.specialWorkingTimes = const [],
    this.wkts = const [
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
    ],
    this.isSpecialWorkingTime = false,
  });

  OrderState copyWith({
    EState? status,
    EState? loginState,
    EState? updateStore,
    List<StoreModel>? stores,
    bool? isPause,
    bool? isSpecialWorkingTime,
    List<SpecialWorkingTime>? specialWorkingTimes,
    StoreModel? store,
    List<WorkTimeModel>? wkts,
  }) {
    return OrderState(
      status: status ?? this.status,
      loginState: loginState ?? this.loginState,
      updateStore: updateStore ?? this.updateStore,
      stores: stores ?? this.stores,
      isPause: isPause ?? this.isPause,
      isSpecialWorkingTime: isSpecialWorkingTime ?? this.isSpecialWorkingTime,
      specialWorkingTimes: specialWorkingTimes ?? this.specialWorkingTimes,
      store: store ?? this.store,
      wkts: wkts ?? this.wkts,
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
