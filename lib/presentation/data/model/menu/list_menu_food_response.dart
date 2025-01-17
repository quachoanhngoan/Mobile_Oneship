class ListMenuFoodResponse {
  List<MenuFoodResponseItem> items;
  int total;

  ListMenuFoodResponse({required this.items, required this.total});

  factory ListMenuFoodResponse.fromJson(Map<String, dynamic> json) {
    var itemList = json['items'] as List;
    List<MenuFoodResponseItem> items =
        itemList.map((item) => MenuFoodResponseItem.fromJson(item)).toList();

    return ListMenuFoodResponse(
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

class MenuFoodResponseItem {
  int? sold;
  int? viewed;
  int? liked;
  int id;
  DateTime? createdAt;
  String? name;
  int? price;
  String? status;
  String? approvalStatus;
  String? reason;
  String? imageId;

  MenuFoodResponseItem({
    this.sold,
    this.viewed,
    this.liked,
    required this.id,
    this.createdAt,
    this.name,
    this.price,
    this.status,
    this.approvalStatus,
    this.reason,
    this.imageId,
  });

  factory MenuFoodResponseItem.fromJson(Map<String, dynamic> json) {
    return MenuFoodResponseItem(
      sold: json['sold'],
      viewed: json['viewed'],
      liked: json['liked'],
      id: json['id'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      name: json['name'],
      price: json['price'],
      status: json['status'],
      approvalStatus: json['approvalStatus'],
      reason: json['reason'],
      imageId: json['imageId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sold': sold,
      'viewed': viewed,
      'liked': liked,
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'name': name,
      'price': price,
      'status': status,
      'approvalStatus': approvalStatus,
      'reason': reason,
      'imageId': imageId,
    };
  }
}
