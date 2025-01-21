class ListCartRequest {
  int? limit;
  int? page;
  String? search;
  String? status;
  String? paymentStatus;
  int? storeId;
  String? keyword;
  String? startDate;
  String? endDate;
  String? sortBy;
  String? sortOrder;
  int? minTotalAmount;
  int? maxTotalAmount;
  int? driverId;

  ListCartRequest({
    this.limit,
    this.page,
    this.search,
    this.status,
    this.paymentStatus,
    this.storeId,
    this.keyword,
    this.startDate,
    this.endDate,
    this.sortBy,
    this.sortOrder,
    this.minTotalAmount,
    this.maxTotalAmount,
    this.driverId,
  });

  factory ListCartRequest.fromJson(Map<String, dynamic> json) {
    return ListCartRequest(
      limit: json['limit'] as int?,
      page: json['page'] as int?,
      search: json['search'] as String?,
      status: json['status'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      storeId: json['storeId'] as int?,
      keyword: json['keyword'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      sortBy: json['sortBy'] as String?,
      sortOrder: json['sortOrder'] as String?,
      minTotalAmount: json['minTotalAmount'] as int?,
      maxTotalAmount: json['maxTotalAmount'] as int?,
      driverId: json['driverId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
      'search': search,
      'status': status,
      'paymentStatus': paymentStatus,
      'storeId': storeId,
      'keyword': keyword,
      'startDate': startDate,
      'endDate': endDate,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'minTotalAmount': minTotalAmount,
      'maxTotalAmount': maxTotalAmount,
      'driverId': driverId,
    };
  }

  Map<String, dynamic> removeNullValues() {
    return toJson()..removeWhere((key, value) => value == null);
  }
}