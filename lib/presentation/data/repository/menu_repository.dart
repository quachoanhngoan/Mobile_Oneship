import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/food_register_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/food_register_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/food_update_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_menu_register_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/hide_menu_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/list_menu_food_request.dart';

import '../model/menu/gr_menu_register_request.dart';
import '../model/menu/list_menu_food_response.dart';
import '../model/menu/remove_topping_request.dart';
import '../utils.dart';

mixin AuthUrl {
  static const String optionGroup = "/api/v1/merchant/option-groups";
  static const String productCategories = "/api/v1/merchant/product-categories";
  static const String products = "/api/v1/merchant/products";
}

abstract class MenuRepository {
  Future<GrAddToppingResponse?> addGroupTopping(GrToppingRequest request,
      {int? id});

  Future<LinkfoodResponse?> getListMenu(LinkFoodRequest request);

  Future<GetGrToppingResponse?> getGroupTopping(GetGroupToppingRequest request);

  Future<ListMenuFoodResponse?> detailFoodByMenu(ListMenuFoodRequest request);

  Future<RemoveToppingResponse?> removeGroupTopping(int id);

  Future<GrMenuRegisterResponse?> registerGroupMenu(
      GrMenuRegisterRequest request);

  Future<FoodRegisterMenuResponse?> registerFoodInMenu(
      FoodRegisterMenuRequest request);

  Future<FoodUpdateResponse?> updateFoodInMenu(FoodRegisterMenuRequest request,
      {required int id});

  Future<HideMenuResponse?> hideOrShowMenuGroup(int id, {bool isHide = false});
}

class MenuRepositoryImp implements MenuRepository {
  final DioUtil _clientDio;

  MenuRepositoryImp(this._clientDio);

  @override
  Future<GrAddToppingResponse?> addGroupTopping(GrToppingRequest request,
      {int? id}) async {
    try {
      if (id != null) {
        final httpRequest = await _clientDio.patch("${AuthUrl.optionGroup}/$id",
            data: request.removeNullValues());
        return GrAddToppingResponse.fromJson(httpRequest.data ?? {});
      } else {
        final httpRequest = await _clientDio.post(AuthUrl.optionGroup,
            data: request.removeNullValues(), isTranformData: true);
        return GrAddToppingResponse.fromJson(httpRequest.data ?? {});
      }
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception('Unknown error');
    }
  }

  @override
  Future<LinkfoodResponse?> getListMenu(LinkFoodRequest request) async {
    try {
      final httpRequest = await _clientDio.get(AuthUrl.productCategories,
          queryParameters: request.removeNullValues());
      return LinkfoodResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("getListMenu error: $e");
    }
    return null;
  }

  @override
  Future<GetGrToppingResponse?> getGroupTopping(
      GetGroupToppingRequest request) async {
    try {
      final httpRequest = await _clientDio.get(AuthUrl.optionGroup,
          queryParameters: request.removeNullValues());
      return GetGrToppingResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("getListMenu error: $e");
    }
    return null;
  }

  @override
  Future<ListMenuFoodResponse?> detailFoodByMenu(
      ListMenuFoodRequest request) async {
    try {
      final httpRequest = await _clientDio.get(AuthUrl.products,
          queryParameters: request.removeNullValues());
      return ListMenuFoodResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("detailFoodByMenu error: $e");
    }
    return null;
  }

  @override
  Future<RemoveToppingResponse?> removeGroupTopping(int id) async {
    try {
      final httpRequest = await _clientDio.delete("${AuthUrl.optionGroup}/$id");
      return RemoveToppingResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("detailFoodByMenu error: $e");
    }
    return null;
  }

  @override
  Future<GrMenuRegisterResponse?> registerGroupMenu(
      GrMenuRegisterRequest request) async {
    try {
      final httpRequest = await _clientDio.post(AuthUrl.productCategories,
          data: request.toJson());
      return GrMenuRegisterResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("detailFoodByMenu error: $e");
    }
    return null;
  }

  @override
  Future<FoodRegisterMenuResponse?> registerFoodInMenu(
      FoodRegisterMenuRequest request) async {
    try {
      final httpRequest = await _clientDio.post(AuthUrl.products,
          data: request.removeNullValues());
      return FoodRegisterMenuResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("detailFoodByMenu error: $e");
    }
    return null;
  }

  @override
  Future<FoodUpdateResponse?> updateFoodInMenu(FoodRegisterMenuRequest request,
      {required int id}) async {
    try {
      final httpRequest = await _clientDio.patch("${AuthUrl.products}/$id",
          data: request.removeNullValues());
      return FoodUpdateResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("detailFoodByMenu error: $e");
    }
    return null;
  }

  @override
  Future<HideMenuResponse?> hideOrShowMenuGroup(int id,
      {bool isHide = false}) async {
    try {
      final pathUrl = isHide ? "hide-products" : "show-products";
      final httpRequest =
          await _clientDio.patch("${AuthUrl.productCategories}/$id/$pathUrl");
      return HideMenuResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("detailFoodByMenu error: $e");
    }
    return null;
  }
}
