import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';
import 'package:oneship_merchant_app/presentation/data/repository/cart_repository.dart';
import 'package:oneship_merchant_app/presentation/data/time_utils.dart';
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
      getAllCart();
    }
  }

  getAllCart() async {
    try {
      emit(state.copyWith(isLoading: true));
      Map<String?, List<OrderCartResponse>>? listCartBook;
      List<OrderCartResponse>? listCartNew = [];
      List<ListCartConfirmDomain>? listCartConfirm = [];
      Map<String?, List<OrderCartResponse>>? listCartComplete;
      Map<String?, List<OrderCartResponse>>? listCartCancel;

      for (var type in CartType.values) {
        final request = ListCartRequest(status: type.status);
        final response = await repository.getListCart(request);
        switch (type) {
          case CartType.book:
            if (response?.orders != null) {
              Map<String?, List<OrderCartResponse>> groupedDomains = groupBy(
                  response!.orders!,
                  (order) => TimeUtils().convertIsoDateToDate(order.createdAt));

              final timeNow = DateFormat('dd/MM/yyyy').format(DateTime.now());
              if (groupedDomains.containsKey(timeNow)) {
                var value = groupedDomains[timeNow];
                if (value != null) {
                  groupedDomains["Hôm nay"] = value;
                  groupedDomains.remove(timeNow);
                }
              }
              listCartBook =
                  Map.fromEntries(groupedDomains.entries.toList().reversed);
            }
            break;
          case CartType.newCart:
            listCartNew.addAll(response?.orders ?? []);
            break;
          case CartType.confirm:
            listCartConfirm.addAll([]);
            break;
          case CartType.complete:
            if (response?.orders != null) {
              Map<String?, List<OrderCartResponse>>? groupedDomains = groupBy(
                  response!.orders!,
                  (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
              listCartComplete = groupedDomains;
            }
            break;
          case CartType.cancel:
            if (response?.orders != null) {
              Map<String?, List<OrderCartResponse>>? groupedDomains = groupBy(
                  response!.orders!,
                  (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
              listCartCancel = groupedDomains;
            }
            break;
        }
      }
      emit(state.copyWith(
        listCartBook: listCartBook,
        listCartNew: listCartNew,
        listCartConfirm: listCartConfirm,
        listCartCancel: listCartCancel,
        listCartComplete: listCartComplete,
      ));
    } on DioException catch (e) {
      log("getAllTopping error: ${e.message}");
      emit(state.copyWith(isLoading: false));
    }
  }

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

  sellectTimeRange(List<DateTime> listTime, {bool isComplete = true}) async {
    try {
      final firstDate = listTime.first;
      final lastDate = listTime.last;

      if (firstDate == lastDate) {
        final String title = DateFormat('dd/MM/yyyy').format(firstDate);
        if (isComplete) {
          final request = ListCartRequest(status: CartType.complete.status);
          final response = await repository.getListCart(request);
          if (response?.orders != null) {
            Map<String?, List<OrderCartResponse>>? listCartComplete = groupBy(
                response!.orders!,
                (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
            emit(state.copyWith(
                timeRangeTitleComplete: title,
                listCartComplete: listCartComplete));
          } else {
            final request = ListCartRequest(status: CartType.cancel.status);
            final response = await repository.getListCart(request);
            if (response?.orders != null) {
              Map<String?, List<OrderCartResponse>>? listCartCancel = groupBy(
                  response!.orders!,
                  (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
              emit(state.copyWith(
                  timeRangeTitleCancel: title, listCartCancel: listCartCancel));
            }
          }
        }
      } else {
        final String title =
            "${DateFormat('dd/MM/yyyy').format(firstDate)} - ${DateFormat('dd/MM/yyyy').format(lastDate)}";
        if (isComplete) {
          final request = ListCartRequest(status: CartType.complete.status);
          final response = await repository.getListCart(request);
          if (response?.orders != null) {
            Map<String?, List<OrderCartResponse>>? listCartComplete = groupBy(
                response!.orders!,
                (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
            emit(state.copyWith(
                timeRangeTitleComplete: title,
                listCartComplete: listCartComplete));
          }
        } else {
          final request = ListCartRequest(status: CartType.cancel.status);
          final response = await repository.getListCart(request);
          if (response?.orders != null) {
            Map<String?, List<OrderCartResponse>>? listCartCancel = groupBy(
                response!.orders!,
                (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
            emit(state.copyWith(
                timeRangeTitleCancel: title, listCartCancel: listCartCancel));
          }
        }
      }
    } on DioException catch (e) {
      log("sellect time range error: $e");
    } catch (e) {
      log("sellect time range error: $e");
    }
  }

  hireOrShowDetailFoodSearch({required ShowDetailFoodCartDomain value}) {
    final currentListShow = List.of(state.listSearchShowDetailFood);
    final isShow = currentListShow.contains(value);
    if (isShow) {
      currentListShow.remove(value);
    } else {
      currentListShow.add(value);
    }
    emit(state.copyWith(listSearchShowDetailFood: currentListShow));
  }

  hireOrShowDetailFood({required ShowDetailFoodCartDomain value}) {
    final currentListShow = List.of(state.listShowDetailFood);
    final isShow = currentListShow.contains(value);
    if (isShow) {
      currentListShow.remove(value);
    } else {
      currentListShow.add(value);
    }
    emit(state.copyWith(listShowDetailFood: currentListShow));
  }

  searchTyping(String value) {
    try {
      bool _enableChangePage = true;
      CartType _typeScrollPage = CartType.book;
      final Map<String?, List<OrderCartResponse>> listSearchBook = {};
      final List<OrderCartResponse> listSearchNewCart = [];
      final Map<String?, List<OrderCartResponse>> listSearchComplete = {};
      final Map<String?, List<OrderCartResponse>> listSearchCancel = {};
      for (var type in CartType.values) {
        switch (type) {
          case CartType.book:
            state.listCartBook.forEach((key, orderCartResponses) {
              List<OrderCartResponse> filteredResponses = orderCartResponses
                  .where((response) =>
                      removeDiacritics(response.client?.name ?? "")
                          .toLowerCase()
                          .contains(removeDiacritics(value.toLowerCase())))
                  .toList();
              if (filteredResponses.isNotEmpty) {
                listSearchBook[key] = filteredResponses;
                _typeScrollPage = type;
                _enableChangePage = false;
              }
            });
            break;
          case CartType.newCart:
            final listNewCart = List.of(state.listCartNew);
            listSearchNewCart.addAll(listNewCart.where((e) =>
                removeDiacritics(e.client?.name ?? "")
                    .toLowerCase()
                    .contains(removeDiacritics(value.toLowerCase())) ==
                true));
            if (listSearchNewCart.isNotEmpty && _enableChangePage) {
              _typeScrollPage = type;
              _enableChangePage = false;
            }
            break;
          case CartType.confirm:
            break;
          case CartType.complete:
            state.listCartComplete.forEach((key, orderCartResponses) {
              List<OrderCartResponse> filteredResponses = orderCartResponses
                  .where((response) =>
                      removeDiacritics(response.client?.name ?? "")
                          .toLowerCase()
                          .contains(removeDiacritics(value.toLowerCase())))
                  .toList();
              if (filteredResponses.isNotEmpty && _enableChangePage) {
                listSearchComplete[key] = filteredResponses;
                _typeScrollPage = type;
                _enableChangePage = false;
              }
            });
            break;
          case CartType.cancel:
            state.listSearchCartCancel.forEach((key, orderCartResponses) {
              List<OrderCartResponse> filteredResponses = orderCartResponses
                  .where((response) =>
                      removeDiacritics(response.client?.name ?? "")
                          .toLowerCase()
                          .contains(removeDiacritics(value.toLowerCase())))
                  .toList();
              if (filteredResponses.isNotEmpty && _enableChangePage) {
                listSearchCancel[key] = filteredResponses;
                _typeScrollPage = type;
                _enableChangePage = false;
              }
            });
            break;
        }
      }
      changeCartType(_typeScrollPage.index, _typeScrollPage);
      emit(state.copyWith(
          listSearchCartBook: listSearchBook,
          listSearchCartCancel: listSearchCancel,
          listSearchCartComplete: listSearchComplete,
          listSearchCartNew: listSearchNewCart));
    } catch (e) {
      log("searchTyping error: $e");
    }
  }
}
