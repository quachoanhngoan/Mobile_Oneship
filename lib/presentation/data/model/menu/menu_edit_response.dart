class MenuEditResponse {
  int? id;
  DateTime? createdAt;
  DateTime? deletedAt;
  DateTime? updatedAt;
  String? code;
  String? name;
  String? status;
  int? serviceGroupId;
  String? description;
  int? storeId;

  MenuEditResponse({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.code,
    this.name,
    this.status,
    this.serviceGroupId,
    this.description,
    this.storeId,
  });

  factory MenuEditResponse.fromJson(Map<String, dynamic> json) {
    return MenuEditResponse(
      id: json['id'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      code: json['code'],
      name: json['name'],
      status: json['status'],
      serviceGroupId: json['serviceGroupId'],
      description: json['description'],
      storeId: json['storeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'code': code,
      'name': name,
      'status': status,
      'serviceGroupId': serviceGroupId,
      'description': description,
      'storeId': storeId,
    };
  }
}