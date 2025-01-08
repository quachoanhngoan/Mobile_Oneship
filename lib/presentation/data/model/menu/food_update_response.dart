class FoodUpdateResponse {
  final int? sold;
  final int? viewed;
  final int? liked;
  final int? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final String? name;
  final String? code;
  final int? price;
  final String? status;
  final String? approvalStatus;
  final String? reason;
  final int? storeId;
  final String? imageId;
  final String? description;
  final bool? isNormalTime;
  final Store? store;

  FoodUpdateResponse({
    this.sold,
    this.viewed,
    this.liked,
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.name,
    this.code,
    this.price,
    this.status,
    this.approvalStatus,
    this.reason,
    this.storeId,
    this.imageId,
    this.description,
    this.isNormalTime,
    this.store,
  });

  factory FoodUpdateResponse.fromJson(Map<String, dynamic> json) {
    return FoodUpdateResponse(
      sold: json['sold'],
      viewed: json['viewed'],
      liked: json['liked'],
      id: json['id'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      name: json['name'],
      code: json['code'],
      price: json['price'],
      status: json['status'],
      approvalStatus: json['approvalStatus'],
      reason: json['reason'],
      storeId: json['storeId'],
      imageId: json['imageId'],
      description: json['description'],
      isNormalTime: json['isNormalTime'],
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sold': sold,
      'viewed': viewed,
      'liked': liked,
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'name': name,
      'code': code,
      'price': price,
      'status': status,
      'approvalStatus': approvalStatus,
      'reason': reason,
      'storeId': storeId,
      'imageId': imageId,
      'description': description,
      'isNormalTime': isNormalTime,
      'store': store?.toJson(),
    };
  }
}

class Store {
  final int? id;
  final String? storeCode;

  Store({
    this.id,
    this.storeCode,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      storeCode: json['storeCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeCode': storeCode,
    };
  }
}