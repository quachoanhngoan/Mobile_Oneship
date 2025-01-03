import 'gr_topping_request.dart';

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
      status: json['status'] ?? 'active',
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

  GrAddToppingResponse copyWith({
    String? name,
    bool? isMultiple,
    String? status,
    List<OptionAddToppingResponse>? options,
    int? storeId,
    int? id,
    String? createdAt,
    String? deletedAt,
    String? updatedAt,
  }) {
    return GrAddToppingResponse(
      name: name ?? this.name,
      isMultiple: isMultiple ?? this.isMultiple,
      status: status ?? this.status,
      options: options ?? this.options,
      storeId: storeId ?? this.storeId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  GrToppingRequest responseToRequest() {
    List<OptionAddTopping> listOption = [];
    for (var item in options) {
      listOption.add(item.convertOption());
    }
    return GrToppingRequest(
        name: name,
        isMultiple: isMultiple,
        status: status,
        options: listOption);
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
      status: json['status'] ?? 'active',
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

  OptionAddTopping convertOption() {
    return OptionAddTopping(name: name, price: price, status: status);
  }
}

class GetGrToppingResponse {
  List<GrAddToppingResponse> items;
  int total;

  GetGrToppingResponse({required this.items, required this.total});

  factory GetGrToppingResponse.fromJson(Map<String, dynamic> json) {
    var itemList = json['items'] as List;
    List<GrAddToppingResponse> items =
        itemList.map((i) => GrAddToppingResponse.fromJson(i)).toList();

    return GetGrToppingResponse(
      items: items,
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
    };
  }
}
