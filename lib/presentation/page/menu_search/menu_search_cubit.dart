import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/food_register_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/list_menu_food_response.dart';
import 'package:oneship_merchant_app/presentation/data/repository/menu_repository.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/domain/menu_domain.dart';
import 'package:oneship_merchant_app/presentation/page/menu_search/menu_search_state.dart';

class MenuSearchCubit extends Cubit<MenuSearchState> {
  final MenuRepository repository;
  MenuSearchCubit(this.repository) : super(const MenuSearchState());

  // init()async{

  // }

  changeMainPage(MenuMainType type) {
    emit(state.copyWith(menuMainType: type));
  }

  changPageMenu(MenuType type) {}

  hideOrShowMenuFood(MenuFoodResponseItem item,
      {bool isHide = true, required int productCategoryId}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final request = FoodRegisterMenuRequest(
        status: isHide ? "inactive" : "active",
        name: item.name,
        price: item.price.toDouble(),
        imageId: item.imageId,
        productCategoryId: productCategoryId,
      );

      final httpRequest =
          await repository.updateFoodInMenu(request, id: item.id);
      if (httpRequest != null) {
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(
            errorEditTopping: "Không thể thay đổi trạng thái topping"));
      }
    } on DioException catch (e) {
      log("hideOrShowMenuFood error: ${e.message}");
      emit(state.copyWith(errorEditTopping: e.message));
    }
  }
}
