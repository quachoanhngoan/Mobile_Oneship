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
}
