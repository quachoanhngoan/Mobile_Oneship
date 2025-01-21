import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/cart/list_cart_request.dart';
import '../utils.dart';

mixin CartUrl {
  static const String orders = "/api/v1/merchant/orders";
}

abstract class CartRepository {
  Future getListCart(ListCartRequest request);
}

class CartRepositoryImp implements CartRepository {
  final DioUtil _clientDio;

  CartRepositoryImp(this._clientDio);

  final String tag = "CartRepository";

  @override
  Future getListCart(ListCartRequest request) async {
    try {
      final httpRequest = await _clientDio.get(CartUrl.orders,
          queryParameters: request.removeNullValues());
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("getListCart error: $e", name: tag);
    }
  }
}
