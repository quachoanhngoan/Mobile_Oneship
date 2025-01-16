class GrMenuRegisterResponse {
  final String name;
  final dynamic storeId;
  final dynamic serviceGroupId;
  final String? description;
  final dynamic id;
  final String createdAt;
  final String? deletedAt;
  final String updatedAt;
  final String code;
  final String status;

  GrMenuRegisterResponse({
    required this.name,
    required this.storeId,
    required this.serviceGroupId,
    this.description,
    required this.id,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
    required this.code,
    required this.status,
  });

  factory GrMenuRegisterResponse.fromJson(Map<String, dynamic> json) {
    return GrMenuRegisterResponse(
      name: json['name'],
      storeId: json['storeId'],
      serviceGroupId: json['serviceGroupId'],
      description: json['description'],
      id: json['id'],
      createdAt: json['createdAt'],
      deletedAt: json['deletedAt'],
      updatedAt: json['updatedAt'],
      code: json['code'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'storeId': storeId,
      'serviceGroupId': serviceGroupId,
      'description': description,
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
      'code': code,
      'status': status,
    };
  }
}