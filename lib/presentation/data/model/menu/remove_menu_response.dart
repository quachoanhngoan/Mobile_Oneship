class RemoveMenuResponse {
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final String? code;
  final String? name;
  final String? status;
  final int? serviceGroupId;
  final String? description;
  final int? storeId;
  final int? totalProducts;

  RemoveMenuResponse({
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.code,
    this.name,
    this.status,
    this.serviceGroupId,
    this.description,
    this.storeId,
    this.totalProducts,
  });

  factory RemoveMenuResponse.fromJson(Map<String, dynamic> json) {
    return RemoveMenuResponse(
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      code: json['code'],
      name: json['name'],
      status: json['status'],
      serviceGroupId: json['serviceGroupId'],
      description: json['description'],
      storeId: json['storeId'],
      totalProducts: json['totalProducts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'code': code,
      'name': name,
      'status': status,
      'serviceGroupId': serviceGroupId,
      'description': description,
      'storeId': storeId,
      'totalProducts': totalProducts,
    };
  }
}