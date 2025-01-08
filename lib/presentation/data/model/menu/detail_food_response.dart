import 'package:oneship_merchant_app/presentation/data/model/menu/category_global_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/food_register_response.dart';

class DetailFoodResponse {
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
  final List<ProductOptionGroup>? productOptionGroups;
  final List<ProductWorkingTimeResponse>? productWorkingTimes;
  final ItemCategoryGlobal? productCategory;

  DetailFoodResponse({
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
    this.productOptionGroups,
    this.productWorkingTimes,
    this.productCategory,
  });

  factory DetailFoodResponse.fromJson(Map<String, dynamic> json) {
    return DetailFoodResponse(
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
      productOptionGroups: (json['productOptionGroups'] as List?)
          ?.map((e) => ProductOptionGroup.fromJson(e))
          .toList(),
      productWorkingTimes: (json['productWorkingTimes'] as List?)
          ?.map((e) => ProductWorkingTimeResponse.fromJson(e))
          .toList(),
      productCategory: json['productCategory'] != null
          ? ItemCategoryGlobal.fromJson(json['productCategory'])
          : null,
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
      'productOptionGroups': productOptionGroups?.map((e) => e.toJson()).toList(),
      'productWorkingTimes': productWorkingTimes?.map((e) => e.toJson()).toList(),
      'productCategory': productCategory?.toJson(),
    };
  }
}

class ProductOptionGroup {
  final int? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final int? productId;
  final int? optionGroupId;
  final List<OptionDetail>? options;
  final OptionGroup? optionGroup;

  ProductOptionGroup({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.productId,
    this.optionGroupId,
    this.options,
    this.optionGroup,
  });

  factory ProductOptionGroup.fromJson(Map<String, dynamic> json) {
    return ProductOptionGroup(
      id: json['id'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      productId: json['productId'],
      optionGroupId: json['optionGroupId'],
      options: json['options'] != null
          ? (json['options'] as List)
              .map((option) => OptionDetail.fromJson(option))
              .toList()
          : [],
      optionGroup: json['optionGroup'] != null
          ? OptionGroup.fromJson(json['optionGroup'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'productId': productId,
      'optionGroupId': optionGroupId,
      'options': options?.map((option) => option.toJson()).toList(),
      'optionGroup': optionGroup?.toJson(),
    };
  }
}

class OptionDetail {
  final int? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final String? name;
  final int? price;
  final String? status;
  final int? optionGroupId;

  OptionDetail({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.name,
    this.price,
    this.status,
    this.optionGroupId,
  });

  factory OptionDetail.fromJson(Map<String, dynamic> json) {
    return OptionDetail(
      id: json['id'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      name: json['name'],
      price: json['price'],
      status: json['status'],
      optionGroupId: json['optionGroupId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'name': name,
      'price': price,
      'status': status,
      'optionGroupId': optionGroupId,
    };
  }
}

class OptionGroup {
  final int? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final String? name;
  final int? storeId;
  final bool? isMultiple;
  final String? status;

  OptionGroup({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.name,
    this.storeId,
    this.isMultiple,
    this.status,
  });

  factory OptionGroup.fromJson(Map<String, dynamic> json) {
    return OptionGroup(
      id: json['id'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      name: json['name'],
      storeId: json['storeId'],
      isMultiple: json['isMultiple'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'name': name,
      'storeId': storeId,
      'isMultiple': isMultiple,
      'status': status,
    };
  }
}