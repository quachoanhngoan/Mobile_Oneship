class ListMenuFoodRequest {
  int limit;
  int page;
  String? search;
  String status;
  String approvalStatus;
  bool? isDisplay;
  int productCategoryId;

  ListMenuFoodRequest({
    this.limit = 10,
    this.page = 1,
    this.search,
    required this.status,
    required this.approvalStatus,
    this.isDisplay,
    required this.productCategoryId,
  });

  factory ListMenuFoodRequest.fromJson(Map<String, dynamic> json) {
    return ListMenuFoodRequest(
      limit: json['limit'],
      page: json['page'],
      search: json['search'],
      status: json['status'],
      approvalStatus: json['approvalStatus'],
      isDisplay: json['isDisplay'],
      productCategoryId: json['productCategoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
      'search': search,
      'status': status,
      'approvalStatus': approvalStatus,
      'isDisplay': isDisplay,
      'productCategoryId': productCategoryId,
    };
  }

  Map<String, dynamic> removeNullValues() {
    return toJson()..removeWhere((key, value) => value == null);
  }
}
