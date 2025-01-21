import 'package:equatable/equatable.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';

class CartState extends Equatable {
  final bool isShowSearch;
  final bool isShowClearSearch;
  final CartType cartTypeSellected;
  final CartConfirmType cartConfirmTypeSellected;
  const CartState({
    this.isShowSearch = false,
    this.isShowClearSearch = false,
    this.cartTypeSellected = CartType.book,
    this.cartConfirmTypeSellected = CartConfirmType.findDriver,
  });

  @override
  List<Object?> get props => [
        isShowSearch,
        isShowClearSearch,
        cartTypeSellected,
        cartConfirmTypeSellected,
      ];

  CartState copyWith({
    bool? isShowSearch,
    bool? isShowClearSearch,
    CartType? cartTypeSellected,
    CartConfirmType? cartConfirmTypeSellected,
  }) {
    return CartState(
      isShowSearch: isShowSearch ?? this.isShowSearch,
      isShowClearSearch: isShowClearSearch ?? this.isShowClearSearch,
      cartTypeSellected: cartTypeSellected ?? this.cartTypeSellected,
      cartConfirmTypeSellected:
          cartConfirmTypeSellected ?? this.cartConfirmTypeSellected,
    );
  }
}
