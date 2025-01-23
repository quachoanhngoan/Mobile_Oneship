import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/order/cancel.model.dart';
import 'package:oneship_merchant_app/presentation/data/model/order/order_model.dart';

import '../model/cart/list_cart_request.dart';
import '../utils.dart';

mixin CartUrl {
  static const String orders = "/api/v1/merchant/orders";
  static const String ordersCancel = "/api/v1/merchant/orders/:id/cancel";
  static const String ordersConfirm = "/api/v1/merchant/orders/:id/confirm";
  static const String ordersCancelReasons =
      "/api/v1/merchant/cancel-order-reasons";
}

abstract class CartRepository {
  Future<ListCartResponse?> getListCart(ListCartRequest request);
  Future<OrderM?> getOrderByID(String id);
  Future<bool> cancelOrder(String id, String reason);
  Future<bool> confirmOrder(String id);
  Future<List<CancelModel>> getCancelReasons();
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

  @override
  Future<OrderM?> getOrderByID(String id) async {
    final httpRequest = await _clientDio.get("${CartUrl.orders}/$id");
    return OrderM.fromJson(httpRequest.data ?? {});
  }

  @override
  Future<bool> cancelOrder(String id, String reason) async {
    final response = await _clientDio.patch(
      CartUrl.ordersCancel.replaceAll(":id", id),
      data: {"reasons": reason},
    );
    return response.statusCode == 200;
  }

  @override
  Future<bool> confirmOrder(String id) async {
    final respone =
        await _clientDio.patch(CartUrl.ordersConfirm.replaceAll(":id", id));
    return respone.statusCode == 200;
  }

  @override
  Future<List<CancelModel>> getCancelReasons() async {
    final response =
        await _clientDio.get(CartUrl.ordersCancelReasons, isTranformData: true);
    final data = response.data as List<dynamic>;
    return data.map((e) => CancelModel.fromJson(e)).toList();
  }
}
