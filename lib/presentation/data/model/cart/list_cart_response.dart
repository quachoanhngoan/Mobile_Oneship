class ListCartResponse {
  List<OrderCartResponse>? orders;
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  ListCartResponse(
      {this.orders, this.total, this.page, this.limit, this.totalPages});

  factory ListCartResponse.fromJson(Map<String, dynamic> json) {
    return ListCartResponse(
      orders: (json['orders'] as List<dynamic>?)
          ?.map((order) => OrderCartResponse.fromJson(order))
          .toList(),
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders?.map((order) => order.toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
    };
  }
}

class OrderCartResponse {
  int? id;
  String? createdAt;
  String? deletedAt;
  String? updatedAt;
  int? clientId;
  int? storeId;
  int? driverId;
  String? totalAmount;
  String? status;
  String? paymentStatus;
  String? deliveryAddress;
  double? deliveryLatitude;
  double? deliveryLongitude;
  String? notes;
  ClientCart? client;
  List<CartOrderItem>? orderItems;
  List<CartActivity>? activities;

  OrderCartResponse({
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
    this.notes,
    this.client,
    this.orderItems,
    this.activities,
  });

  factory OrderCartResponse.fromJson(Map<String, dynamic> json) {
    return OrderCartResponse(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      clientId: json['clientId'] as int?,
      storeId: json['storeId'] as int?,
      driverId: json['driverId'] as int?,
      totalAmount: json['totalAmount'] as String?,
      status: json['status'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      deliveryLatitude: json['deliveryLatitude'] as double?,
      deliveryLongitude: json['deliveryLongitude'] as double?,
      notes: json['notes'] as String?,
      client:
          json['client'] != null ? ClientCart.fromJson(json['client']) : null,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((item) => CartOrderItem.fromJson(item))
          .toList(),
      activities: (json['activities'] as List<dynamic>?)
          ?.map((activity) => CartActivity.fromJson(activity))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
      'clientId': clientId,
      'storeId': storeId,
      'driverId': driverId,
      'totalAmount': totalAmount,
      'status': status,
      'paymentStatus': paymentStatus,
      'deliveryAddress': deliveryAddress,
      'deliveryLatitude': deliveryLatitude,
      'deliveryLongitude': deliveryLongitude,
      'notes': notes,
      'client': client?.toJson(),
      'orderItems': orderItems?.map((item) => item.toJson()).toList(),
      'activities': activities?.map((activity) => activity.toJson()).toList(),
    };
  }
}

class ClientCart {
  int? id;
  String? createdAt;
  String? deletedAt;
  String? updatedAt;
  String? name;
  String? email;
  int? avatarId;
  String? phone;
  double? latitude;
  double? longitude;
  String? address;
  String? deviceToken;
  String? lastLogin;

  ClientCart({
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

  factory ClientCart.fromJson(Map<String, dynamic> json) {
    return ClientCart(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      avatarId: json['avatarId'] as int?,
      phone: json['phone'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      address: json['address'] as String?,
      deviceToken: json['deviceToken'] as String?,
      lastLogin: json['lastLogin'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
      'name': name,
      'email': email,
      'avatarId': avatarId,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'deviceToken': deviceToken,
      'lastLogin': lastLogin,
    };
  }
}

class CartOrderItem {
  int? id;
  int? orderId;
  int? productId;
  String? productImage;
  String? productName;
  String? price;
  int? quantity;
  String? subtotal;
  String? note;
  List<CartProductOption>? cartProductOptions;

  CartOrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.productImage,
    this.productName,
    this.price,
    this.quantity,
    this.subtotal,
    this.note,
    this.cartProductOptions,
  });

  factory CartOrderItem.fromJson(Map<String, dynamic> json) {
    return CartOrderItem(
      id: json['id'] as int?,
      orderId: json['orderId'] as int?,
      productId: json['productId'] as int?,
      productImage: json['productImage'] as String?,
      productName: json['productName'] as String?,
      price: json['price'] as String?,
      quantity: json['quantity'] as int?,
      subtotal: json['subtotal'] as String?,
      note: json['note'] as String?,
      cartProductOptions: (json['cartProductOptions'] as List<dynamic>?)
          ?.map((option) => CartProductOption.fromJson(option))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'productImage': productImage,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'subtotal': subtotal,
      'note': note,
      'cartProductOptions':
          cartProductOptions?.map((option) => option.toJson()).toList(),
    };
  }
}

class CartProductOption {
  CartOptionGroup? optionGroup;
  List<CartOptions>? options;

  CartProductOption({this.optionGroup, this.options});

  factory CartProductOption.fromJson(Map<String, dynamic> json) {
    return CartProductOption(
      optionGroup: json['optionGroup'] != null
          ? CartOptionGroup.fromJson(json['optionGroup'])
          : null,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => CartOptions.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionGroup': optionGroup?.toJson(),
      'options': options?.map((e) => e.toJson()).toList(),
    };
  }
}

class CartOptionGroup {
  int? id;
  String? name;
  int? storeId;
  bool? isMultiple;
  String? status;
  String? createdAt;
  String? updateAt;

  CartOptionGroup({
    this.id,
    this.name,
    this.storeId,
    this.isMultiple,
    this.status,
    this.createdAt,
    this.updateAt,
  });

  factory CartOptionGroup.fromJson(Map<String, dynamic> json) {
    return CartOptionGroup(
      id: json['id'] as int?,
      name: json['name'] as String?,
      storeId: json['storeId'] as int?,
      isMultiple: json['isMultiple'] as bool?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updateAt: json['updateAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'storeId': storeId,
      'isMultiple': isMultiple,
      'status': status,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }
}

class CartOptions {
  int? id;
  String? name;
  int? price;
  String? status;
  int? optionGroupId;
  String? createdAt;
  String? updateAt;

  CartOptions({
    this.id,
    this.name,
    this.price,
    this.status,
    this.optionGroupId,
    this.createdAt,
    this.updateAt,
  });

  factory CartOptions.fromJson(Map<String, dynamic> json) {
    return CartOptions(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      status: json['status'] as String?,
      optionGroupId: json['optionGroupId'] as int?,
      createdAt: json['createdAt'] as String?,
      updateAt: json['updateAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'status': status,
      'optionGroupId': optionGroupId,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }
}

class CartActivity {
  final int id;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final DateTime updatedAt;
  final int orderId;
  final String status;
  final String description;
  final String performedBy;
  final String? cancellationReason;
  final String? cancellationType;

  CartActivity({
    required this.id,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
    required this.orderId,
    required this.status,
    required this.description,
    required this.performedBy,
    this.cancellationReason,
    this.cancellationType,
  });

  factory CartActivity.fromJson(Map<String, dynamic> json) {
    return CartActivity(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      updatedAt: DateTime.parse(json['updatedAt']),
      orderId: json['orderId'],
      status: json['status'],
      description: json['description'],
      performedBy: json['performedBy'],
      cancellationReason: json['cancellationReason'],
      cancellationType: json['cancellationType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'orderId': orderId,
      'status': status,
      'description': description,
      'performedBy': performedBy,
      'cancellationReason': cancellationReason,
      'cancellationType': cancellationType,
    };
  }
}
