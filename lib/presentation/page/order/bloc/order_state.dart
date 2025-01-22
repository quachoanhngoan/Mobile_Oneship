part of 'order_cubit.dart';

class OrderState {
  final EState status;
  final EState cancelState;
  final EState confirmState;
  final OrderM? order;
  final List<CancelModel> listCancelOrder;

  OrderState({
    this.status = EState.initial,
    this.cancelState = EState.initial,
    this.confirmState = EState.initial,
    this.order,
    this.listCancelOrder = const [
      CancelModel(
        id: 0,
        name: 'Lý do khác',
      ),
    ],
  });

  OrderState copyWith({
    EState? status,
    EState? cancelState,
    EState? confirmState,
    OrderM? order,
    List<CancelModel>? listCancelOrder,
  }) {
    return OrderState(
      status: status ?? this.status,
      cancelState: cancelState ?? this.cancelState,
      confirmState: confirmState ?? this.confirmState,
      order: order ?? this.order,
      listCancelOrder: listCancelOrder ?? this.listCancelOrder,
    );
  }
}
