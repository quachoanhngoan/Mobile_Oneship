class GrToppingRequest {
  String? name;
  bool? isMultiple;
  String? status;
  List<OptionAddTopping>? options;
  List<ProductAddTopping>? products;

  GrToppingRequest({
    this.name,
    this.isMultiple,
    this.status,
    this.options,
    this.products,
  });

  factory GrToppingRequest.fromJson(Map<String, dynamic> json) {
    return GrToppingRequest(
      name: json['name'] ?? '',
      isMultiple: json['isMultiple'] ?? false,
      status: json['status'] ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => OptionAddTopping.fromJson(e))
              .toList() ??
          [],
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductAddTopping.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isMultiple': isMultiple,
      'status': status,
      'options': options?.map((e) => e.toJson()).toList(),
      'products': products?.map((e) => e.toJson()).toList(),
    };
  }

  GrToppingRequest copyWith({
    String? name,
    bool? isMultiple,
    String? status,
    List<OptionAddTopping>? options,
    List<ProductAddTopping>? products,
  }) {
    return GrToppingRequest(
      name: name ?? this.name,
      isMultiple: isMultiple ?? this.isMultiple,
      status: status ?? this.status,
      options: options ?? this.options,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> removeNullValues() {
    return toJson()..removeWhere((key, value) => value == null);
  }
}

class OptionAddTopping {
  String name;
  int price;
  String status;

  OptionAddTopping({
    required this.name,
    required this.price,
    required this.status,
  });

  factory OptionAddTopping.fromJson(Map<String, dynamic> json) {
    return OptionAddTopping(
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'status': status,
    };
  }

  OptionAddTopping copyWith({
    String? name,
    int? price,
    String? status,
  }) {
    return OptionAddTopping(
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }
}

class ProductAddTopping {
  int id;

  ProductAddTopping({
    required this.id,
  });

  factory ProductAddTopping.fromJson(Map<String, dynamic> json) {
    return ProductAddTopping(
      id: json['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  ProductAddTopping copyWith({
    int? id,
  }) {
    return ProductAddTopping(
      id: id ?? this.id,
    );
  }
}

class GetGroupToppingRequest {
  int limit;
  int page;
  String? search;
  String? status;

  GetGroupToppingRequest({
    this.limit = 0,
    this.page = 1,
    this.search,
    this.status,
  });

  factory GetGroupToppingRequest.fromJson(Map<String, dynamic> json) {
    return GetGroupToppingRequest(
      limit: json['limit'],
      page: json['page'],
      search: json['search'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
      'search': search,
      'status': status,
    };
  }

  Map<String, dynamic> removeNullValues() {
    return toJson()..removeWhere((key, value) => value == null);
  }
}
