import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';

import '../utils.dart';

mixin AuthUrl {
  static const String optionGroup = "/api/v1/merchant/option-groups";
  static const String productCategories = "/api/v1/merchant/product-categories";
}

abstract class MenuRepository {
  Future<GrAddToppingResponse?> addGroupTopping(GrToppingRequest request);
  Future<LinkfoodResponse?> getListMenu(LinkFoodRequest request);
}

class MenuRepositoryImp implements MenuRepository {
  final DioUtil _clientDio;
  MenuRepositoryImp(this._clientDio);

  @override
  Future<GrAddToppingResponse?> addGroupTopping(
      GrToppingRequest request) async {
    try {
      final httpRequest = await _clientDio.post(AuthUrl.optionGroup,
          data: request.removeNullValues(), isTranformData: true);
      return GrAddToppingResponse.fromJson(httpRequest.data ?? {});
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
      throw Exception('Unknown error');
    }
  }
}
