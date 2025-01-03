class LinkfoodResponse {
  List<ItemLinkFood> items;
  int total;

  LinkfoodResponse({required this.items, required this.total});

  factory LinkfoodResponse.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<ItemLinkFood> items =
        itemsList.map((i) => ItemLinkFood.fromJson(i)).toList();

    return LinkfoodResponse(
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

class ItemLinkFood {
  int id;
  String name;
  int? storeId;
  List<DetailLinkFood>? products;
  int totalProducts;

  ItemLinkFood({
    required this.id,
    required this.name,
    this.storeId,
    required this.products,
    required this.totalProducts,
  });

  factory ItemLinkFood.fromJson(Map<String, dynamic> json) {
    var productList =
        json['products'] != null ? json['products'] as List : null;
    List<DetailLinkFood>? products =
        productList?.map((p) => DetailLinkFood.fromJson(p)).toList();

    return ItemLinkFood(
      id: json['id'],
      name: json['name'],
      storeId: json['storeId'],
      products: products,
      totalProducts: json['totalProducts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'storeId': storeId,
      'products': products?.map((product) => product.toJson()).toList(),
      'totalProducts': totalProducts,
    };
  }
}

class DetailLinkFood {
  int id;
  String name;

  DetailLinkFood({required this.id, required this.name});

  factory DetailLinkFood.fromJson(Map<String, dynamic> json) {
    return DetailLinkFood(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
