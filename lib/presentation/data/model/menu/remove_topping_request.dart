import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_response.dart';

class RemoveToppingResponse {
  final String createdAt;
  final String? deletedAt;
  final String updatedAt;
  final String name;
  final int storeId;
  final bool isMultiple;
  final String status;
  final List<OptionAddToppingResponse> productOptionGroups;

  const RemoveToppingResponse({
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
    required this.name,
    required this.storeId,
    required this.isMultiple,
    required this.status,
    required this.productOptionGroups,
  });

  factory RemoveToppingResponse.fromJson(Map<String, dynamic> json) {
    return RemoveToppingResponse(
      createdAt: json['createdAt'] as String,
      deletedAt: json['deletedAt'] as String?,
      updatedAt: json['updatedAt'] as String,
      name: json['name'] as String,
      storeId: json['storeId'] as int,
      isMultiple: json['isMultiple'] as bool,
      status: json['status'] as String,
      productOptionGroups: (json['productOptionGroups'] as List<dynamic>)
          .map((e) =>
              OptionAddToppingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
      'name': name,
      'storeId': storeId,
      'isMultiple': isMultiple,
      'status': status,
      'productOptionGroups':
          productOptionGroups.map((e) => e.toJson()).toList(),
    };
  }
}
