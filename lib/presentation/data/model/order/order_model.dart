import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/extensions/time_extention.dart';
import 'package:oneship_merchant_app/presentation/data/model/cart/list_cart_response.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_RepresentativeInformation.dart';

enum EOrderStatus {
  pending,
  confirmed,
  inDelivery,
  delivered,
  cancelled,
  offerSentToDriver,
  driverAccepted,
  searchingForDriver;

  bool get isPending {
    return this == EOrderStatus.pending;
  }

  bool get isConfirmed {
    return this == EOrderStatus.confirmed;
  }

  bool get isInDelivery {
    return this == EOrderStatus.inDelivery;
  }

  bool get isDelivered {
    return this == EOrderStatus.delivered;
  }

  bool get isCancelled {
    return this == EOrderStatus.cancelled;
  }

  bool get isOfferSentToDriver {
    return this == EOrderStatus.offerSentToDriver;
  }

  bool get isDriverAccepted {
    return this == EOrderStatus.driverAccepted;
  }

  bool get isSearchingForDriver {
    return this == EOrderStatus.searchingForDriver;
  }

  String get name {
    switch (this) {
      case EOrderStatus.pending:
        return 'Đang chờ';
      case EOrderStatus.confirmed:
        return 'Đã xác nhận';
      case EOrderStatus.inDelivery:
        return 'Đang giao';
      case EOrderStatus.delivered:
        return 'Đã giao';
      case EOrderStatus.cancelled:
        return 'Đã hủy';
      case EOrderStatus.offerSentToDriver:
        return 'Đã gửi đề nghị tới tài xế';
      case EOrderStatus.driverAccepted:
        return 'Tài xế đã chấp nhận';
      case EOrderStatus.searchingForDriver:
        return 'Đang tìm tài xế';
    }
  }

  static EOrderStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return EOrderStatus.pending;
      case 'confirmed':
        return EOrderStatus.confirmed;
      case 'in_delivery':
        return EOrderStatus.inDelivery;
      case 'delivered':
        return EOrderStatus.delivered;
      case 'cancelled':
        return EOrderStatus.cancelled;
      case 'offer_sent_to_driver':
        return EOrderStatus.offerSentToDriver;
      case 'driver_accepted':
        return EOrderStatus.driverAccepted;
      case 'searching_for_driver':
        return EOrderStatus.searchingForDriver;
      default:
        return EOrderStatus.pending;
    }
  }
}

enum EPaymentStatus {
  unpaid,
  paid,
  refunded;

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

  static EPaymentStatus fromString(String status) {
    switch (status) {
      case 'unpaid':
        return EPaymentStatus.unpaid;
      case 'paid':
        return EPaymentStatus.paid;
      case 'refunded':
        return EPaymentStatus.refunded;
      default:
        return EPaymentStatus.unpaid;
    }
  }
}

class OrderM {
  final int? id;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final DateTime? updatedAt;
  final int? clientId;
  final int? storeId;
  final int? driverId;
  final String? totalAmount;
  final String? status;
  final String? paymentStatus;
  final String? deliveryAddress;
  final double? deliveryLatitude;
  final double? deliveryLongitude;
  final double? tip;
  final String? notes;
  final List<CartOrderItem>? orderItems;
  final List<Activity>? activities;
  final Store? store;
  final Client? client;

  OrderM({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.clientId,
    this.storeId,
    this.driverId,
    this.totalAmount,
    this.status,
    this.paymentStatus,
    this.deliveryAddress,
    this.deliveryLatitude,
    this.deliveryLongitude,
    this.tip,
    this.notes,
    this.orderItems,
    this.activities,
    this.store,
    this.client,
  });

  factory OrderM.fromRawJson(String str) => OrderM.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderM.fromJson(Map<String, dynamic> json) => OrderM(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        clientId: json["clientId"],
        storeId: json["storeId"],
        driverId: json["driverId"],
        totalAmount: json["totalAmount"],
        status: json["status"],
        paymentStatus: json["paymentStatus"],
        deliveryAddress: json["deliveryAddress"],
        deliveryLatitude: json["deliveryLatitude"]?.toDouble(),
        deliveryLongitude: json["deliveryLongitude"]?.toDouble(),
        tip: json["tip"],
        notes: json["notes"],
        orderItems: json["orderItems"] == null
            ? []
            : List<CartOrderItem>.from(json["orderItems"]!.map((x) => x)),
        activities: json["activities"] == null
            ? []
            : List<Activity>.from(
                json["activities"]!.map((x) => Activity.fromJson(x))),
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "clientId": clientId,
        "storeId": storeId,
        "driverId": driverId,
        "totalAmount": totalAmount,
        "status": status,
        "paymentStatus": paymentStatus,
        "deliveryAddress": deliveryAddress,
        "deliveryLatitude": deliveryLatitude,
        "deliveryLongitude": deliveryLongitude,
        "tip": tip,
        "notes": notes,
        "orderItems": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x)),
        "activities": activities == null
            ? []
            : List<dynamic>.from(activities!.map((x) => x.toJson())),
        "store": store?.toJson(),
        "client": client?.toJson(),
      };

  String? getCustomerName() {
    return client?.name;
  }

  String? getCustomerPhone() {
    return client?.phone;
  }

  String? getCustomerAvatar() {
    return client?.avatarId;
  }

  String? getDriverName() {
    return driverId == null ? null : 'Tài xế';
  }

  EOrderStatus? getOrderStatus() {
    return EOrderStatus.fromString(status!);
  }

  EPaymentStatus? getPaymentStatus() {
    return EPaymentStatus.fromString(paymentStatus!);
  }

  String getOrderStatusName() {
    return getOrderStatus()!.name;
  }

  Activity? getActiveActivityCancel() {
    final activity = activities!.firstWhereOrNull(
      (element) => element.status == 'cancelled',
    );
    return activity;
  }

  Activity? getActiveActivityDelivered() {
    final activity = activities!.firstWhereOrNull(
      (element) => element.status == 'delivered',
    );
    return activity;
  }

  Activity? getActiveActivityDriverAccepted() {
    final activity = activities!.firstWhereOrNull(
      (element) => element.status == 'driver_accepted',
    );
    return activity;
  }

  Activity? getActiveActivityOfferSentToDriver() {
    final activity = activities!.firstWhereOrNull(
      (element) => element.status == 'offer_sent_to_driver',
    );
    return activity;
  }

  Activity? getActiveActivitySearchingForDriver() {
    final activity = activities!.firstWhereOrNull(
      (element) => element.status == 'searching_for_driver',
    );
    return activity;
  }

  Activity? getActiveActivityInDelivery() {
    final activity = activities!.firstWhereOrNull(
      (element) => element.status == 'in_delivery',
    );
    return activity;
  }

  Activity? getActiveActivityConfirmed() {
    final activity = activities!.firstWhereOrNull(
      (element) => element.status == 'confirmed',
    );
    return activity;
  }

  Activity? getActiveActivityPending() {
    final activity = activities!.firstWhereOrNull(
      (element) => element.status == 'pending',
    );
    return activity;
  }

  String? totalAmountFormat() {
    return NumberFormat.currency(
      locale: 'vi',
      symbol: 'đ',
      decimalDigits: 0,
    ).format(double.parse(totalAmount ?? "0"));
  }
}

class Activity {
  final int? id;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final DateTime? updatedAt;
  final int? orderId;
  final String? status;
  final String? description;
  final String? performedBy;
  final dynamic cancellationReason;
  final dynamic cancellationType;
  String? cancellationTime() {
    return updatedAt?.formatHHMMDD();
  }

  Activity({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.orderId,
    this.status,
    this.description,
    this.performedBy,
    this.cancellationReason,
    this.cancellationType,
  });

  factory Activity.fromRawJson(String str) =>
      Activity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        orderId: json["orderId"],
        status: json["status"],
        description: json["description"],
        performedBy: json["performedBy"],
        cancellationReason: json["cancellationReason"],
        cancellationType: json["cancellationType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "orderId": orderId,
        "status": status,
        "description": description,
        "performedBy": performedBy,
        "cancellationReason": cancellationReason,
        "cancellationType": cancellationType,
      };
}

class Client {
  final int? id;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final DateTime? updatedAt;
  final dynamic name;
  final dynamic email;
  final dynamic avatarId;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? deviceToken;
  final DateTime? lastLogin;

  Client({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.name,
    this.email,
    this.avatarId,
    this.phone,
    this.latitude,
    this.longitude,
    this.address,
    this.deviceToken,
    this.lastLogin,
  });

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        name: json["name"],
        email: json["email"],
        avatarId: json["avatarId"],
        phone: json["phone"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        deviceToken: json["deviceToken"],
        lastLogin: json["lastLogin"] == null
            ? null
            : DateTime.parse(json["lastLogin"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "name": name,
        "email": email,
        "avatarId": avatarId,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "deviceToken": deviceToken,
        "lastLogin": lastLogin?.toIso8601String(),
      };
}

class Store {
  final int? id;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final DateTime? updatedAt;
  final int? merchantId;
  final String? storeCode;
  final String? name;
  final String? specialDish;
  final String? streetName;
  final String? phoneNumber;
  final int? serviceTypeId;
  final bool? isAlcohol;
  final int? serviceGroupId;
  final int? businessAreaId;
  final int? provinceId;
  final int? districtId;
  final bool? isPause;
  final bool? isSpecialWorkingTime;
  final int? wardId;
  final String? address;
  final dynamic latitude;
  final dynamic longitude;
  final String? status;
  final String? approvalStatus;
  final DateTime? approvedAt;
  final String? storeAvatarId;
  final String? storeCoverId;
  final String? storeFrontId;
  final String? storeMenuId;
  final dynamic parkingFee;
  final dynamic rejectReason;

  Store({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.merchantId,
    this.storeCode,
    this.name,
    this.specialDish,
    this.streetName,
    this.phoneNumber,
    this.serviceTypeId,
    this.isAlcohol,
    this.serviceGroupId,
    this.businessAreaId,
    this.provinceId,
    this.districtId,
    this.isPause,
    this.isSpecialWorkingTime,
    this.wardId,
    this.address,
    this.latitude,
    this.longitude,
    this.status,
    this.approvalStatus,
    this.approvedAt,
    this.storeAvatarId,
    this.storeCoverId,
    this.storeFrontId,
    this.storeMenuId,
    this.parkingFee,
    this.rejectReason,
  });

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        merchantId: json["merchantId"],
        storeCode: json["storeCode"],
        name: json["name"],
        specialDish: json["specialDish"],
        streetName: json["streetName"],
        phoneNumber: json["phoneNumber"],
        serviceTypeId: json["serviceTypeId"],
        isAlcohol: json["isAlcohol"],
        serviceGroupId: json["serviceGroupId"],
        businessAreaId: json["businessAreaId"],
        provinceId: json["provinceId"],
        districtId: json["districtId"],
        isPause: json["isPause"],
        isSpecialWorkingTime: json["isSpecialWorkingTime"],
        wardId: json["wardId"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        approvalStatus: json["approvalStatus"],
        approvedAt: json["approvedAt"] == null
            ? null
            : DateTime.parse(json["approvedAt"]),
        storeAvatarId: json["storeAvatarId"],
        storeCoverId: json["storeCoverId"],
        storeFrontId: json["storeFrontId"],
        storeMenuId: json["storeMenuId"],
        parkingFee: json["parkingFee"],
        rejectReason: json["rejectReason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "merchantId": merchantId,
        "storeCode": storeCode,
        "name": name,
        "specialDish": specialDish,
        "streetName": streetName,
        "phoneNumber": phoneNumber,
        "serviceTypeId": serviceTypeId,
        "isAlcohol": isAlcohol,
        "serviceGroupId": serviceGroupId,
        "businessAreaId": businessAreaId,
        "provinceId": provinceId,
        "districtId": districtId,
        "isPause": isPause,
        "isSpecialWorkingTime": isSpecialWorkingTime,
        "wardId": wardId,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "approvalStatus": approvalStatus,
        "approvedAt": approvedAt?.toIso8601String(),
        "storeAvatarId": storeAvatarId,
        "storeCoverId": storeCoverId,
        "storeFrontId": storeFrontId,
        "storeMenuId": storeMenuId,
        "parkingFee": parkingFee,
        "rejectReason": rejectReason,
      };
}
