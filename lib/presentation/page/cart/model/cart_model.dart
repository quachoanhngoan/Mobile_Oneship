import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';

enum CartType { book, newCart, confirm, complete, cancel }

extension CartTypeExt on CartType {
  String get title {
    switch (this) {
      case CartType.book:
        return "Đặt trước";
      case CartType.newCart:
        return "Mới";
      case CartType.confirm:
        return "Đã xác nhận";
      case CartType.complete:
        return "Đã hoàn thành";
      case CartType.cancel:
        return "Đã huỷ";
    }
  }

  String get status {
    switch (this) {
      case CartType.book:
        return "pending";
      case CartType.newCart:
        return "pending";
      case CartType.confirm:
        return "confirmed";
      case CartType.complete:
        return "delivered";
      case CartType.cancel:
        return "cancelled";
    }
  }
}

enum TimeCartType { book, takeOrder, delivery }

extension TimeCartTypeExt on TimeCartType {
  String get title {
    switch (this) {
      case TimeCartType.book:
        return "Giờ đặt";
      case TimeCartType.takeOrder:
        return "Giờ lấy đơn";
      case TimeCartType.delivery:
        return "Giờ giao khách";
    }
  }
}

enum CartConfirmType { findDriver, driving }

extension CartConfirmTypeExt on CartConfirmType {
  String get title {
    switch (this) {
      case CartConfirmType.findDriver:
        return "Đang tìm tài xế (#VALUE)";
      case CartConfirmType.driving:
        return "Tài xế đang đến (#VALUE)";
    }
  }
}

class ListCartConfirmDomain {
  final CartConfirmType type;
  final List<OrderCartResponse> listData;

  ListCartConfirmDomain({required this.type, this.listData = const []});
}

class ShowDetailFoodCartDomain {
  final CartType? type;
  final int? idShow;
  final CartConfirmType? confirmType;
  ShowDetailFoodCartDomain({
    this.idShow,
    this.type,
    this.confirmType,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ShowDetailFoodCartDomain) return false;
    return other.idShow == idShow && other.type == type;
  }

  @override
  int get hashCode => Object.hash(idShow, type);
}
