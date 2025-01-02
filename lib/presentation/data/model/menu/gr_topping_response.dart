class GrAddToppingResponse {
  String name;
  bool isMultiple;
  String status;
  List<OptionAddToppingResponse> options;
  int storeId;
  int id;
  String createdAt;
  String? deletedAt;
  String updatedAt;

  GrAddToppingResponse({
    required this.name,
    required this.isMultiple,
    required this.status,
    required this.options,
    required this.storeId,
    required this.id,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
  });

  factory GrAddToppingResponse.fromJson(Map<String, dynamic> json) {
    return GrAddToppingResponse(
      name: json['name'] ?? '',
      isMultiple: json['isMultiple'] ?? false,
      status: json['status'] ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => OptionAddToppingResponse.fromJson(e))
              .toList() ??
          [],
      storeId: json['storeId'] ?? 0,
      id: json['id'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      deletedAt: json['deletedAt'],
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isMultiple': isMultiple,
      'status': status,
      'options': options.map((e) => e.toJson()).toList(),
      'storeId': storeId,
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
    };
  }
}

class OptionAddToppingResponse {
  String name;
  int price;
  String status;
  int optionGroupId;
  int id;
  String createdAt;
  String? deletedAt;
  String updatedAt;

  OptionAddToppingResponse({
    required this.name,
    required this.price,
    required this.status,
    required this.optionGroupId,
    required this.id,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
  });

  factory OptionAddToppingResponse.fromJson(Map<String, dynamic> json) {
    return OptionAddToppingResponse(
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      status: json['status'] ?? '',
      optionGroupId: json['optionGroupId'] ?? 0,
      id: json['id'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      deletedAt: json['deletedAt'],
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'status': status,
      'optionGroupId': optionGroupId,
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
    };
  }

  OptionAddToppingResponse copyWith({
    String? name,
    int? price,
    String? status,
    int? optionGroupId,
    int? id,
    String? createdAt,
    String? deletedAt,
    String? updatedAt,
  }) {
    return OptionAddToppingResponse(
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      optionGroupId: optionGroupId ?? this.optionGroupId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
