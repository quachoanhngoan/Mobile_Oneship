import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/repository/menu_repository.dart';
import 'package:oneship_merchant_app/presentation/page/menu_dishes_custom/menu_dishes_state.dart';
import 'package:oneship_merchant_app/presentation/page/menu_dishes_custom/model/time_sell_type.dart';
import 'package:oneship_merchant_app/presentation/page/menu_dishes_custom/model/time_sellect_type.dart';

import '../../data/model/menu/food_register_request.dart';
import '../../data/model/menu/gr_topping_request.dart';
import '../../data/model/menu/linkfood_request.dart';
import '../../data/model/menu/linkfood_response.dart';

class MenuDishesCubit extends Cubit<MenuDishesState> {
  final MenuRepository repository;
  MenuDishesCubit(this.repository) : super(const MenuDishesState());

  late TextEditingController nameFoodController;
  late TextEditingController priceController;
  late TextEditingController categoryController;
  late TextEditingController toppingController;
  late TextEditingController descriptionController;

  late TextEditingController mondayTimeStartController;
  late TextEditingController mondayTimeEndController;
  late TextEditingController tuesdayTimeStartController;
  late TextEditingController tuesdayTimeEndController;
  late TextEditingController webnesdayTimeStartController;
  late TextEditingController webnesdayTimeEndController;
  late TextEditingController thursdayTimeStartController;
  late TextEditingController thursdayTimeEndController;
  late TextEditingController fridayTimeStartController;
  late TextEditingController fridayTimeEndController;
  late TextEditingController saturdayTimeStartController;
  late TextEditingController saturdayTimeEndController;
  late TextEditingController sundayTimeStartController;
  late TextEditingController sundayTimeEndController;

  final List<ProductWorkingTime> _listTimeSellect = [];

  init() {
    nameFoodController = TextEditingController();
    priceController = TextEditingController();
    categoryController = TextEditingController();
    toppingController = TextEditingController();
    descriptionController = TextEditingController();
    mondayTimeStartController = TextEditingController();
    mondayTimeEndController = TextEditingController();
    tuesdayTimeStartController = TextEditingController();
    tuesdayTimeEndController = TextEditingController();
    webnesdayTimeEndController = TextEditingController();
    webnesdayTimeStartController = TextEditingController();
    thursdayTimeEndController = TextEditingController();
    thursdayTimeStartController = TextEditingController();
    fridayTimeEndController = TextEditingController();
    fridayTimeStartController = TextEditingController();
    saturdayTimeEndController = TextEditingController();
    saturdayTimeStartController = TextEditingController();
    sundayTimeEndController = TextEditingController();
    sundayTimeStartController = TextEditingController();

    getLinkFood();
    getListCategory();
  }

  TextEditingController getControllerStartByType(DateTimeSellectType type) {
    switch (type) {
      case DateTimeSellectType.monday:
        return mondayTimeStartController;
      case DateTimeSellectType.tuesday:
        return tuesdayTimeStartController;
      case DateTimeSellectType.wednesday:
        return webnesdayTimeStartController;
      case DateTimeSellectType.thursday:
        return thursdayTimeStartController;
      case DateTimeSellectType.friday:
        return fridayTimeStartController;
      case DateTimeSellectType.saturday:
        return saturdayTimeStartController;
      case DateTimeSellectType.sunday:
        return sundayTimeStartController;
    }
  }

  TextEditingController getControllerEndByType(DateTimeSellectType type) {
    switch (type) {
      case DateTimeSellectType.monday:
        return mondayTimeEndController;
      case DateTimeSellectType.tuesday:
        return tuesdayTimeEndController;
      case DateTimeSellectType.wednesday:
        return webnesdayTimeEndController;
      case DateTimeSellectType.thursday:
        return thursdayTimeEndController;
      case DateTimeSellectType.friday:
        return fridayTimeEndController;
      case DateTimeSellectType.saturday:
        return saturdayTimeEndController;
      case DateTimeSellectType.sunday:
        return sundayTimeEndController;
    }
  }

  validateNameFood() {
    if (nameFoodController.text.isNotNullOrEmpty) {
      emit(state.copyWith(isShowClearNameFood: true));
    } else {
      emit(state.copyWith(isShowClearNameFood: false));
    }
    _checkFilledAllInfo();
  }

  validatePriceFood() {
    if (priceController.text.isNotNullOrEmpty) {
      emit(state.copyWith(isShowClearPrice: true));
    } else {
      emit(state.copyWith(isShowClearPrice: false));
    }
    _checkFilledAllInfo();
  }

  sellectCategoryStore(ItemLinkFood item) {
    emit(state.copyWith(categoryStoreSellect: item));
  }

  categoryStoreSellectClear() {
    categoryController.clear();
    emit(
        state.copyWith(isShowClearCategory: false, categoryStoreSellect: null));
  }

  confirmSellectCategoryGoo() {
    categoryController.text = state.categoryStoreSellect?.name ?? "";
    emit(state.copyWith(
        isShowClearCategory: categoryController.text.isNotNullOrEmpty));
    _checkFilledAllInfo();
  }

  sellectTypeTimeSell(TimeSellType type) {
    emit(state.copyWith(typeTime: type));
  }

  _sellectTimeStart(DateTimeSellectType type, {required DateTime time}) {
    final minute = time.minute == 0 ? "00" : time.minute;
    switch (type) {
      case DateTimeSellectType.monday:
        mondayTimeStartController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.tuesday:
        tuesdayTimeStartController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.wednesday:
        webnesdayTimeStartController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.thursday:
        thursdayTimeStartController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.friday:
        fridayTimeStartController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.saturday:
        saturdayTimeStartController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.sunday:
        sundayTimeStartController.text = "${time.hour}:$minute";
        break;
    }
  }

  _sellectTimeEnd(DateTimeSellectType type, {required DateTime time}) {
    final minute = time.minute == 0 ? "00" : time.minute;
    switch (type) {
      case DateTimeSellectType.monday:
        mondayTimeEndController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.tuesday:
        tuesdayTimeEndController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.wednesday:
        webnesdayTimeEndController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.thursday:
        thursdayTimeEndController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.friday:
        fridayTimeEndController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.saturday:
        saturdayTimeEndController.text = "${time.hour}:$minute";
        break;
      case DateTimeSellectType.sunday:
        sundayTimeEndController.text = "${time.hour}:$minute";
        break;
    }
  }

  compareStringTime(DateTimeSellectType type,
      {bool isSellectEnd = false, required DateTime time}) {
    emit(state.copyWith(errorTimeSellect: null));
    if (isSellectEnd) {
      _sellectTimeEnd(time: time, type);
    } else {
      _sellectTimeStart(type, time: time);
    }
    final startController = getControllerStartByType(type);
    final endController = getControllerEndByType(type);

    if (startController.text.isNotNullOrEmpty &&
        endController.text.isNotNullOrEmpty) {
      final startTime = _convertStringToDateTime(startController.text);
      final endTime = _convertStringToDateTime(endController.text);
      if (startTime.isBefore(endTime)) {
        log("start time is earlier than end time");
      } else if (startTime.isAfter(endTime)) {
        log("start time is later than end time");
        if (isSellectEnd) {
          endController.clear();
        } else {
          startController.clear();
        }
        emit(state.copyWith(
            errorTimeSellect: "Giờ kết thúc không được nhỏ hơn giờ bắt đầu"));
      } else {
        log("start is equal to end");
        if (isSellectEnd) {
          endController.clear();
        } else {
          startController.clear();
        }
        emit(state.copyWith(
            errorTimeSellect: "Giờ kết thúc không được bằng giờ bắt đầu"));
      }
    }
    checkFilledChooseTime();
  }

  checkFilledChooseTime() {
    final isFilled = (mondayTimeEndController.text.isNotNullOrEmpty &&
            mondayTimeStartController.text.isNotNullOrEmpty) ||
        (tuesdayTimeEndController.text.isNotNullOrEmpty &&
            tuesdayTimeStartController.text.isNotNullOrEmpty) ||
        (webnesdayTimeEndController.text.isNotNullOrEmpty &&
            webnesdayTimeStartController.text.isNotNullOrEmpty) ||
        (thursdayTimeEndController.text.isNotNullOrEmpty &&
            thursdayTimeStartController.text.isNotNullOrEmpty) ||
        (fridayTimeEndController.text.isNotNullOrEmpty &&
            fridayTimeStartController.text.isNotNullOrEmpty) ||
        (saturdayTimeEndController.text.isNotNullOrEmpty &&
            saturdayTimeStartController.text.isNotNullOrEmpty) ||
        (sundayTimeEndController.text.isNotNullOrEmpty &&
            sundayTimeStartController.text.isNotNullOrEmpty);
    emit(state.copyWith(isFilledSellectTime: isFilled));
  }

  updateImage(String id) {
    emit(state.copyWith(imageId: id));
  }

  _checkFilledAllInfo() {
    final isFilled = nameFoodController.text.isNotNullOrEmpty &&
        priceController.text.isNotNullOrEmpty &&
        categoryController.text.isNotNullOrEmpty;

    emit(state.copyWith(isFilledAllInfo: isFilled));
  }

  getLinkFood() async {
    try {
      final request = LinkFoodRequest(
        includeProducts: true,
        productStatus: "active",
        approvalStatus: "approved",
      );
      final response = await repository.getListMenu(request);
      emit(state.copyWith(listLinkFood: response?.items));
    } on DioException catch (e) {
      log("error getLinkFood: ${e.message}");
    }
  }

  getListCategory() async {
    try {
      final request = LinkFoodRequest(
        productStatus: "active",
        approvalStatus: "approved",
      );
      final response = await repository.getListMenu(request);
      emit(state.copyWith(listCategoryStore: response?.items));
    } on DioException catch (e) {
      log("error getLinkFood: ${e.message}");
    }
  }

  listIdLinkFoodSellect(int id, {bool isAll = false}) {
    final listId = List<ProductAddTopping>.from(state.listIdLinkFoodSellected);
    final listLinkFood = state.listLinkFood;
    final isSellected = listId.firstWhereOrNull((e) => e.id == id) != null;
    if (isSellected) {
      if (isAll) {
        final listDetailLinkFood = listLinkFood
                .where((e) => e.id == id)
                .toList()
                .firstOrNull
                ?.products ??
            [];
        for (var detail in listDetailLinkFood) {
          listId.removeWhere((e) => e.id == detail.id);
        }
      }
      listId.removeWhere((e) => e.id == id);
    } else {
      if (isAll) {
        final listDetailLinkFood = listLinkFood
                .where((e) => e.id == id)
                .toList()
                .firstOrNull
                ?.products ??
            [];
        for (var detail in listDetailLinkFood) {
          listId.add(ProductAddTopping(id: detail.id));
        }
      }
      listId.add(ProductAddTopping(id: id));
    }

    emit(state.copyWith(
        listIdLinkFoodSellected: _filterDuplicateProducts(listId)));
  }

  List<ProductAddTopping> _filterDuplicateProducts(
      List<ProductAddTopping> products) {
    final seenIds = <int>{};
    return products.where((product) => seenIds.add(product.id)).toList();
  }

  listIdLinkFoodSellectConfirm() {
    final listIdSellect = List.of(state.listIdLinkFoodSellected);
    List<String> listNameSellect = [];
    for (var product in listIdSellect) {
      for (var linkFoodMain in state.listLinkFood) {
        if (linkFoodMain.id == product.id) {
          listNameSellect.add(linkFoodMain.name);
        } else {
          if (linkFoodMain.products != null &&
              linkFoodMain.products!.isNotEmpty) {
            for (var detail in linkFoodMain.products!) {
              if (detail.id == product.id) {
                listNameSellect.add(detail.name);
              }
            }
          }
        }
      }
    }

    toppingController.text = listNameSellect.join(', ');
    emit(state.copyWith(
        isShowClearTopping: toppingController.text.isNotNullOrEmpty));
  }

  listIdLinkFoodSellectClear() {
    emit(
        state.copyWith(isShowClearTopping: false, listIdLinkFoodSellected: []));
  }

  saveInfoClick() async {
    try {
      emit(state.copyWith(isLoading: true));
      double numericPrice = double.tryParse(
              priceController.text.replaceAll(RegExp(r'[^\d.]'), '')) ??
          0.0;

      final listIdLinkFoodSellected = List.of(state.listIdLinkFoodSellected);
      final listIdSellected = <int>[];
      for (var id in listIdLinkFoodSellected) {
        listIdSellected.add(id.id);
      }

      final request = FoodRegisterMenuRequest(
          name: nameFoodController.text,
          price: numericPrice,
          imageId: state.imageId!,
          productCategoryId: state.categoryStoreSellect!.id,
          isNormalTime: state.typeTime == TimeSellType.timeStore,
          productWorkingTimes: _listTimeSellect,
          description: descriptionController.text,
          optionIds: listIdSellected);
      final httpRequest = await repository.registerFoodInMenu(request);
    } on DioException catch (e) {
      log("saveInfoClick error: ${e.message}");
    }
  }

  saveTimeSellect() {
    _listTimeSellect.clear();
    if (mondayTimeEndController.text.isNotNullOrEmpty &&
        mondayTimeStartController.text.isNotNullOrEmpty) {
      _listTimeSellect.add(ProductWorkingTime(
          dayOfWeek: 0,
          openTime: _convertStringToDateTime(mondayTimeStartController.text)
              .microsecondsSinceEpoch,
          closeTime: _convertStringToDateTime(mondayTimeEndController.text)
              .microsecondsSinceEpoch));
    }

    if (tuesdayTimeEndController.text.isNotNullOrEmpty &&
        tuesdayTimeStartController.text.isNotNullOrEmpty) {
      _listTimeSellect.add(ProductWorkingTime(
          dayOfWeek: 1,
          openTime: _convertStringToDateTime(tuesdayTimeStartController.text)
              .microsecondsSinceEpoch,
          closeTime: _convertStringToDateTime(tuesdayTimeEndController.text)
              .microsecondsSinceEpoch));
    }
    if (webnesdayTimeEndController.text.isNotNullOrEmpty &&
        webnesdayTimeStartController.text.isNotNullOrEmpty) {
      _listTimeSellect.add(ProductWorkingTime(
          dayOfWeek: 2,
          openTime: _convertStringToDateTime(webnesdayTimeStartController.text)
              .microsecondsSinceEpoch,
          closeTime: _convertStringToDateTime(webnesdayTimeEndController.text)
              .microsecondsSinceEpoch));
    }
    if (thursdayTimeEndController.text.isNotNullOrEmpty &&
        thursdayTimeStartController.text.isNotNullOrEmpty) {
      _listTimeSellect.add(ProductWorkingTime(
          dayOfWeek: 3,
          openTime: _convertStringToDateTime(thursdayTimeStartController.text)
              .microsecondsSinceEpoch,
          closeTime: _convertStringToDateTime(thursdayTimeEndController.text)
              .microsecondsSinceEpoch));
    }
    if (fridayTimeEndController.text.isNotNullOrEmpty &&
        fridayTimeStartController.text.isNotNullOrEmpty) {
      _listTimeSellect.add(ProductWorkingTime(
          dayOfWeek: 4,
          openTime: _convertStringToDateTime(fridayTimeStartController.text)
              .microsecondsSinceEpoch,
          closeTime: _convertStringToDateTime(fridayTimeEndController.text)
              .microsecondsSinceEpoch));
    }
    if (saturdayTimeEndController.text.isNotNullOrEmpty &&
        saturdayTimeStartController.text.isNotNullOrEmpty) {
      _listTimeSellect.add(ProductWorkingTime(
          dayOfWeek: 5,
          openTime: _convertStringToDateTime(saturdayTimeStartController.text)
              .microsecondsSinceEpoch,
          closeTime: _convertStringToDateTime(saturdayTimeEndController.text)
              .microsecondsSinceEpoch));
    }
    if (sundayTimeEndController.text.isNotNullOrEmpty &&
        sundayTimeStartController.text.isNotNullOrEmpty) {
      _listTimeSellect.add(ProductWorkingTime(
          dayOfWeek: 6,
          openTime: _convertStringToDateTime(sundayTimeStartController.text)
              .microsecondsSinceEpoch,
          closeTime: _convertStringToDateTime(sundayTimeEndController.text)
              .microsecondsSinceEpoch));
    }
  }

  // int _convertStringToTimestamp(String time) {
  //   List<String> parts = time.split(":");
  //   int hour = int.parse(parts[0]);
  //   int minute = int.parse(parts[1]);

  //   DateTime now = DateTime.now();

  //   DateTime dateTime = DateTime(
  //     now.year,
  //     now.month,
  //     now.day,
  //     hour,
  //     minute,
  //   );

  //   return dateTime.millisecondsSinceEpoch;
  // }

  DateTime _convertStringToDateTime(String time) {
    List<String> parts = time.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    DateTime now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  }
}
