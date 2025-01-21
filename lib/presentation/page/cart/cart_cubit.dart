import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_state.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  late final TextEditingController searchController;
  late final PageController pageController;
  late final PageController confirmPageController;

  init() {
    searchController = TextEditingController();
    pageController = PageController();
    confirmPageController = PageController();
  }

  changeCartType(int index, CartType item) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    emit(state.copyWith(cartTypeSellected: item));
  }

  changeConfirmPage(int index, CartConfirmType type) {
    confirmPageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

    emit(state.copyWith(cartConfirmTypeSellected: type));
  }

  checkShowClearSearch() {
    emit(state.copyWith(
        isShowClearSearch: searchController.text.isNotNullOrEmpty));
  }

  hideOrShowSearch() {}
}
