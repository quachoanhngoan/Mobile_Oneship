import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';

import '../model/cart/list_cart_request.dart';
import '../utils.dart';

mixin CartUrl {
  static const String orders = "/api/v1/merchant/orders";
}

abstract class CartRepository {
  Future<ListCartResponse?> getListCart(ListCartRequest request);
}

class CartRepositoryImp implements CartRepository {
  final DioUtil _clientDio;

  CartRepositoryImp(this._clientDio);

  final String tag = "CartRepository";

  @override
  Future<ListCartResponse?> getListCart(ListCartRequest request) async {
    try {
      final httpRequest = await _clientDio.get(CartUrl.orders,
          queryParameters: request.removeNullValues());
      return ListCartResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("getListCart error: $e", name: tag);
    }
    return null;
  }
}
