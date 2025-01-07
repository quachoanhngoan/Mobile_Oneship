class FoodRegisterMenuRequest {
  String name;
  String? description;
  double price;
  String status;
  int productCategoryId;
  String imageId;
  bool isNormalTime;
  List<ProductWorkingTime>? productWorkingTimes;
  List<int>? optionIds;

  FoodRegisterMenuRequest({
    required this.name,
    this.description,
    required this.price,
    this.status = "active",
    this.productCategoryId = 0,
    required this.imageId,
    required this.isNormalTime,
    this.productWorkingTimes,
    this.optionIds,
  });

  factory FoodRegisterMenuRequest.fromJson(Map<String, dynamic> json) {
    return FoodRegisterMenuRequest(
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      status: json['status'] as String,
      productCategoryId: json['productCategoryId'] as int,
      imageId: json['imageId'] as String,
      isNormalTime: json['isNormalTime'] as bool,
      productWorkingTimes: (json['productWorkingTimes'] as List)
          .map((item) => ProductWorkingTime.fromJson(item))
          .toList(),
      optionIds: List<int>.from(json['optionIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'status': status,
      'productCategoryId': productCategoryId,
      'imageId': imageId,
      'isNormalTime': isNormalTime,
      'productWorkingTimes':
          productWorkingTimes?.map((item) => item.toJson()).toList(),
      'optionIds': optionIds,
    };
  }

  Map<String, dynamic> removeNullValues() {
    return toJson()..removeWhere((key, value) => value == null);
  }
}

class ProductWorkingTime {
  int dayOfWeek;
  int openTime;
  int closeTime;

  ProductWorkingTime({
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
  });

  factory ProductWorkingTime.fromJson(Map<String, dynamic> json) {
    return ProductWorkingTime(
      dayOfWeek: json['dayOfWeek'] as int,
      openTime: json['openTime'] as int,
      closeTime: json['closeTime'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }
}
