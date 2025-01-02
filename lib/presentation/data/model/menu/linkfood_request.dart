class LinkFoodRequest {
  int limit;
  int page;
  String? search;
  String? status;
  bool includeProducts;
  String productStatus;
  String approvalStatus;

  LinkFoodRequest({
    this.limit = 10,
    this.page = 1,
    this.search,
    this.status,
    this.includeProducts = false,
    required this.productStatus,
    required this.approvalStatus,
  });

  factory LinkFoodRequest.fromJson(Map<String, dynamic> json) {
    return LinkFoodRequest(
      limit: json['limit'] ?? 10,
      page: json['page'] ?? 1,
      search: json['search'] ?? '',
      status: json['status'] ?? '',
      includeProducts: json['includeProducts'] ?? false,
      productStatus: json['productStatus'] ?? '',
      approvalStatus: json['approvalStatus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
      'search': search,
      'status': status,
      'includeProducts': includeProducts,
      'productStatus': productStatus,
      'approvalStatus': approvalStatus,
    };
  }

  Map<String, dynamic> removeNullValues() {
    return toJson()..removeWhere((key, value) => value == null);
  }
}
