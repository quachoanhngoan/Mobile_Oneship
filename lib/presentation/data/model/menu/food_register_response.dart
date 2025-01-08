class FoodRegisterMenuResponse {
  final int? sold;
  final int? viewed;
  final int? liked;
  final String? name;
  final String? description;
  final int? price;
  final String? status;
  final int? productCategoryId;
  final String? imageId;
  final bool? isNormalTime;
  final List<ProductWorkingTimeResponse>? productWorkingTimes;
  final int? storeId;
  final String? code;
  final String? approvalStatus;
  final List<dynamic>? productOptionGroups;
  final String? reason;
  final int? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;

  FoodRegisterMenuResponse({
    this.sold,
    this.viewed,
    this.liked,
    this.name,
    this.description,
    this.price,
    this.status,
    this.productCategoryId,
    this.imageId,
    this.isNormalTime,
    this.productWorkingTimes,
    this.storeId,
    this.code,
    this.approvalStatus,
    this.productOptionGroups,
    this.reason,
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
  });

  factory FoodRegisterMenuResponse.fromJson(Map<String, dynamic> json) {
    return FoodRegisterMenuResponse(
      sold: json['sold'],
      viewed: json['viewed'],
      liked: json['liked'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      status: json['status'],
      productCategoryId: json['productCategoryId'],
      imageId: json['imageId'],
      isNormalTime: json['isNormalTime'],
      productWorkingTimes: (json['productWorkingTimes'] as List)
          .map((e) => ProductWorkingTimeResponse.fromJson(e))
          .toList(),
      storeId: json['storeId'],
      code: json['code'],
      approvalStatus: json['approvalStatus'],
      productOptionGroups: json['productOptionGroups'] ?? [],
      reason: json['reason'],
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sold': sold,
      'viewed': viewed,
      'liked': liked,
      'name': name,
      'description': description,
      'price': price,
      'status': status,
      'productCategoryId': productCategoryId,
      'imageId': imageId,
      'isNormalTime': isNormalTime,
      'productWorkingTimes':
          productWorkingTimes?.map((e) => e.toJson()).toList(),
      'storeId': storeId,
      'code': code,
      'approvalStatus': approvalStatus,
      'productOptionGroups': productOptionGroups,
      'reason': reason,
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class ProductWorkingTimeResponse {
  final int? dayOfWeek;
  final int? openTime;
  final int? closeTime;
  final int? productId;
  final int? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;

  ProductWorkingTimeResponse({
    this.dayOfWeek,
    this.openTime,
    this.closeTime,
    this.productId,
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
  });

  factory ProductWorkingTimeResponse.fromJson(Map<String, dynamic> json) {
    return ProductWorkingTimeResponse(
      dayOfWeek: json['dayOfWeek'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      productId: json['productId'],
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'openTime': openTime,
      'closeTime': closeTime,
      'productId': productId,
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
