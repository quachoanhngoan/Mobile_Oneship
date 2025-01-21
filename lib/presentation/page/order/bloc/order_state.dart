part of 'order_cubit.dart';

class OrderState {
  final EState status;
  final EState loginState;
  final EState updateStore;

  final List<String> listCancelOrder;

  OrderState({
    this.status = EState.initial,
    this.loginState = EState.initial,
    this.updateStore = EState.initial,
    this.listCancelOrder = const [
      "Khách hàng không muốn mua hàng nữa",
      "Khách hàng không liên lạc được",
      "Khách hàng không đồng ý với giá",
      "Khách hàng không đồng ý với chất lượng sản phẩm",
      "Khách hàng không đồng ý với thời gian giao hàng",
    ],
  });

  OrderState copyWith({
    EState? status,
    EState? loginState,
    EState? updateStore,
    List<String>? listCancelOrder,
  }) {
    return OrderState(
      status: status ?? this.status,
      loginState: loginState ?? this.loginState,
      updateStore: updateStore ?? this.updateStore,
      listCancelOrder: listCancelOrder ?? this.listCancelOrder,
    );
  }
}
