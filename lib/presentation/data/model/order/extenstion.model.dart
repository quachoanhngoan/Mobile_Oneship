import 'package:oneship_merchant_app/presentation/data/model/order/order_model.dart';

extension EOrderStatusExtension on EOrderStatus {
  String get name {
    switch (this) {
      case EOrderStatus.pending:
        return 'pending';
      case EOrderStatus.confirmed:
        return 'confirmed';
      case EOrderStatus.inDelivery:
        return 'in_delivery';
      case EOrderStatus.delivered:
        return 'delivered';
      case EOrderStatus.cancelled:
        return 'cancelled';
      case EOrderStatus.offerSentToDriver:
        return 'offer_sent_to_driver';
      case EOrderStatus.driverAccepted:
        return 'driver_accepted';
      case EOrderStatus.searchingForDriver:
        return 'searching_for_driver';
    }
  }
}

extension EPaymentStatusExtension on EPaymentStatus {
  String get name {
    switch (this) {
      case EPaymentStatus.unpaid:
        return 'unpaid';
      case EPaymentStatus.paid:
        return 'paid';
      case EPaymentStatus.refunded:
        return 'refunded';
    }
  }
}
