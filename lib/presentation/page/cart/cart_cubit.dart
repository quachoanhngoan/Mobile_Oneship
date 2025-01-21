import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/repository/cart_repository.dart';
import 'package:oneship_merchant_app/presentation/page/cart/cart_state.dart';
import 'package:oneship_merchant_app/presentation/page/cart/model/cart_model.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;

  CartCubit(this.repository) : super(const CartState());

  late TextEditingController searchController;
  late PageController pageController;
  late PageController confirmPageController;

  bool isInit = false;

  init() {
    searchController = TextEditingController();
    pageController = PageController(initialPage: state.cartTypeSellected.index);
    confirmPageController =
        PageController(initialPage: state.cartConfirmTypeSellected.index);
    if (!isInit) {
      isInit = true;
      emit(state.copyWith(
        timeRangeTitleComplete: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        timeRangeTitleCancel: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      ));
    }
  }

  getAllCart() {}

  dispose() {
    searchController.dispose();
    pageController.dispose();
    confirmPageController.dispose();
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

  hideOrShowSearch() {
    searchController.clear();
    emit(state.copyWith(isShowSearch: !state.isShowSearch));
  }

  sellectTimeRange(List<DateTime> listTime, {bool isComplete = true}) {
    final firstDate = listTime.first;
    final lastDate = listTime.last;
    if (firstDate == lastDate) {
      final String title = DateFormat('dd/MM/yyyy').format(firstDate);
      if (isComplete) {
        emit(state.copyWith(timeRangeTitleComplete: title));
      } else {
        emit(state.copyWith(timeRangeTitleCancel: title));
      }
    } else {
      final String title =
          "${DateFormat('dd/MM/yyyy').format(firstDate)} - ${DateFormat('dd/MM/yyyy').format(lastDate)}";
      if (isComplete) {
        emit(state.copyWith(timeRangeTitleComplete: title));
      } else {
        emit(state.copyWith(timeRangeTitleCancel: title));
      }
    }
  }
}
