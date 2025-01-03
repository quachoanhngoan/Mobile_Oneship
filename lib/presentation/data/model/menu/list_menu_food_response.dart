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
  int sold;
  int viewed;
  int liked;
  int id;
  DateTime createdAt;
  String name;
  int price;
  String status;
  String approvalStatus;
  String? reason;
  String imageId;

  MenuFoodResponseItem({
    required this.sold,
    required this.viewed,
    required this.liked,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.price,
    required this.status,
    required this.approvalStatus,
    this.reason,
    required this.imageId,
  });

  factory MenuFoodResponseItem.fromJson(Map<String, dynamic> json) {
    return MenuFoodResponseItem(
      sold: json['sold'],
      viewed: json['viewed'],
      liked: json['liked'],
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
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
      'createdAt': createdAt.toIso8601String(),
      'name': name,
      'price': price,
      'status': status,
      'approvalStatus': approvalStatus,
      'reason': reason,
      'imageId': imageId,
    };
  }
}
