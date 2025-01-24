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
        switch (type) {
          case CartType.book:
            final request = ListCartRequest(status: type.status);
            final response = await repository.getListCart(request);
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
            final request = ListCartRequest(status: type.status);
            final response = await repository.getListCart(request);
            listCartNew.addAll(response?.orders ?? []);
            break;
          case CartType.confirm:
            for (var typeConfirm in CartConfirmType.values) {
              final request = ListCartRequest(status: typeConfirm.status);
              final response = await repository.getListCart(request);
              log("vao: ${typeConfirm.name}");
              listCartConfirm.add(ListCartConfirmDomain(
                type: typeConfirm,
                listData: response?.orders ?? [],
              ));
            }
            break;
          case CartType.complete:
            final request = ListCartRequest(status: type.status);
            final response = await repository.getListCart(request);
            if (response?.orders != null) {
              Map<String?, List<OrderCartResponse>>? groupedDomains = groupBy(
                  response!.orders!,
                  (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
              listCartComplete = groupedDomains;
            }
            break;
          case CartType.cancel:
            final request = ListCartRequest(status: type.status);
            final response = await repository.getListCart(request);
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
      emit(state.copyWith(isLoading: true));
      final firstDate = listTime.first;
      final lastDate = listTime.last;

      final convertFirstDate = DateFormat('yyyy/MM/dd').format(firstDate);
      final convertLastDate = DateFormat('yyyy/MM/dd').format(lastDate);

      if (firstDate == lastDate) {
        final String title = DateFormat('dd/MM/yyyy').format(firstDate);
        if (isComplete) {
          final request = ListCartRequest(
            status: CartType.complete.status,
            startDate: convertFirstDate,
            endDate: convertLastDate,
          );
          final response = await repository.getListCart(request);
          if (response?.orders != null) {
            Map<String?, List<OrderCartResponse>>? listCartComplete = groupBy(
                response!.orders!,
                (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
            emit(state.copyWith(
                timeRangeTitleComplete: title,
                listCartComplete: listCartComplete));
          } else {
            emit(state.copyWith(
                timeRangeTitleComplete: title, listCartComplete: const {}));
          }
        } else {
          final request = ListCartRequest(
            status: CartType.cancel.status,
            startDate: convertFirstDate,
            endDate: convertLastDate,
          );
          final response = await repository.getListCart(request);
          if (response?.orders != null) {
            Map<String?, List<OrderCartResponse>>? listCartCancel = groupBy(
                response!.orders!,
                (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
            emit(state.copyWith(
                timeRangeTitleCancel: title, listCartCancel: listCartCancel));
          } else {
            emit(state.copyWith(
                timeRangeTitleCancel: title, listCartCancel: const {}));
          }
        }
      } else {
        final String title =
            "${DateFormat('dd/MM/yyyy').format(firstDate)} - ${DateFormat('dd/MM/yyyy').format(lastDate)}";
        if (isComplete) {
          final request = ListCartRequest(
            status: CartType.complete.status,
            startDate: convertFirstDate,
            endDate: convertLastDate,
          );
          final response = await repository.getListCart(request);
          if (response?.orders != null) {
            Map<String?, List<OrderCartResponse>>? listCartComplete = groupBy(
                response!.orders!,
                (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
            emit(state.copyWith(
                timeRangeTitleComplete: title,
                listCartComplete: listCartComplete));
          } else {
            emit(state.copyWith(
                timeRangeTitleComplete: title, listCartComplete: const {}));
          }
        } else {
          final request = ListCartRequest(
            status: CartType.cancel.status,
            startDate: convertFirstDate,
            endDate: convertLastDate,
          );
          final response = await repository.getListCart(request);
          if (response?.orders != null) {
            Map<String?, List<OrderCartResponse>>? listCartCancel = groupBy(
                response!.orders!,
                (order) => TimeUtils().convertIsoDateToDate(order.createdAt));
            emit(state.copyWith(
                timeRangeTitleCancel: title, listCartCancel: listCartCancel));
          } else {
            emit(state.copyWith(
                timeRangeTitleCancel: title, listCartCancel: const {}));
          }
        }
      }
    } on DioException catch (e) {
      log("sellect time range error: $e");
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      log("sellect time range error: $e");
      emit(state.copyWith(isLoading: false));
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
      final List<ListCartConfirmDomain> listSearchConfirm = [];
      for (var type in CartType.values) {
        switch (type) {
          case CartType.book:
            state.listCartBook.forEach((key, orderCartResponses) {
              List<OrderCartResponse> filteredResponses = orderCartResponses
                  .where((response) => removeDiacritics(
                          response.client?.name ?? response.client?.phone ?? "")
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
                removeDiacritics(e.client?.name ?? e.client?.phone ?? "")
                    .toLowerCase()
                    .contains(removeDiacritics(value.toLowerCase())) ==
                true));
            if (listSearchNewCart.isNotEmpty && _enableChangePage) {
              _typeScrollPage = type;
              _enableChangePage = false;
            }
            break;
          case CartType.confirm:
            final listConfirm = List.of(state.listCartConfirm);
            for (var confirm in listConfirm) {
              final listResult = confirm.listData
                  .where((e) => removeDiacritics(
                          (e.client?.name ?? e.client?.phone ?? "")
                              .toLowerCase())
                      .contains(removeDiacritics(value.toLowerCase())))
                  .toList();
              listSearchConfirm.add(ListCartConfirmDomain(
                  type: confirm.type, listData: listResult));
            }
            break;
          case CartType.complete:
            state.listCartComplete.forEach((key, orderCartResponses) {
              List<OrderCartResponse> filteredResponses = orderCartResponses
                  .where((response) => removeDiacritics(
                          response.client?.name ?? response.client?.phone ?? "")
                      .toLowerCase()
                      .contains(removeDiacritics(value.toLowerCase())))
                  .toList();
              if (filteredResponses.isNotEmpty) {
                listSearchComplete[key] = filteredResponses;
                if (_enableChangePage) {
                  _typeScrollPage = type;
                  _enableChangePage = false;
                }
              }
            });
            break;
          case CartType.cancel:
            state.listCartCancel.forEach((key, orderCartResponses) {
              List<OrderCartResponse> filteredResponses = orderCartResponses
                  .where((response) => removeDiacritics(
                          response.client?.name ?? response.client?.phone ?? "")
                      .toLowerCase()
                      .contains(removeDiacritics(value.toLowerCase())))
                  .toList();
              if (filteredResponses.isNotEmpty) {
                listSearchCancel[key] = filteredResponses;
                if (_enableChangePage) {
                  _typeScrollPage = type;
                  _enableChangePage = false;
                }
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
        listSearchCartNew: listSearchNewCart,
        listSearchCartConfirm: listSearchConfirm,
      ));
    } catch (e) {
      log("searchTyping error: $e");
    }
  }
}
