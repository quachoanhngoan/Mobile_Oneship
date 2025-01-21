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
