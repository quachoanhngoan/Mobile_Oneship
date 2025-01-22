import 'package:equatable/equatable.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';

class CartState extends Equatable {
  final bool isShowSearch;
  final bool isShowClearSearch;
  final CartType cartTypeSellected;
  final CartConfirmType cartConfirmTypeSellected;
  final String? timeRangeTitleComplete;
  final String? timeRangeTitleCancel;
  // final List<ListCartTypeDomain>? listAllCart;
  final Map<String?, List<OrderCartResponse>> listCartBook;
  final List<OrderCartResponse> listCartNew;
  final List<ListCartConfirmDomain> listCartConfirm;
  final Map<String?, List<OrderCartResponse>> listCartComplete;
  final Map<String?, List<OrderCartResponse>> listCartCancel;

  const CartState({
    this.isShowSearch = false,
    this.isShowClearSearch = false,
    this.cartTypeSellected = CartType.book,
    this.cartConfirmTypeSellected = CartConfirmType.findDriver,
    this.timeRangeTitleComplete,
    this.timeRangeTitleCancel,
    this.listCartBook = const {},
    this.listCartNew = const [],
    this.listCartConfirm = const [],
    this.listCartCancel = const {},
    this.listCartComplete = const {},
  });

  @override
  List<Object?> get props => [
        isShowSearch,
        isShowClearSearch,
        cartTypeSellected,
        timeRangeTitleComplete,
        cartConfirmTypeSellected,
        timeRangeTitleCancel,
        listCartBook,
        listCartNew,
        listCartConfirm,
        listCartCancel,
        listCartComplete,
      ];

  CartState copyWith({
    bool? isShowSearch,
    bool? isShowClearSearch,
    CartType? cartTypeSellected,
    CartConfirmType? cartConfirmTypeSellected,
    String? timeRangeTitleComplete,
    String? timeRangeTitleCancel,
    Map<String?, List<OrderCartResponse>>? listCartBook,
    List<OrderCartResponse>? listCartNew,
    List<ListCartConfirmDomain>? listCartConfirm,
    Map<String?, List<OrderCartResponse>>? listCartComplete,
    Map<String?, List<OrderCartResponse>>? listCartCancel,
  }) {
    return CartState(
      isShowSearch: isShowSearch ?? this.isShowSearch,
      isShowClearSearch: isShowClearSearch ?? this.isShowClearSearch,
      cartTypeSellected: cartTypeSellected ?? this.cartTypeSellected,
      cartConfirmTypeSellected:
          cartConfirmTypeSellected ?? this.cartConfirmTypeSellected,
      timeRangeTitleComplete:
          timeRangeTitleComplete ?? this.timeRangeTitleComplete,
      timeRangeTitleCancel: timeRangeTitleCancel ?? this.timeRangeTitleCancel,
      listCartBook: listCartBook ?? this.listCartBook,
      listCartNew: listCartNew ?? this.listCartNew,
      listCartConfirm: listCartConfirm ?? this.listCartConfirm,
      listCartComplete: listCartComplete ?? this.listCartComplete,
      listCartCancel: listCartCancel ?? this.listCartCancel,
    );
  }
}
