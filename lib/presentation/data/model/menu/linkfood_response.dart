import 'list_menu_food_response.dart';

class LinkfoodResponse {
  List<ItemLinkFood> items;
  int total;
  int? totalProducts;

  LinkfoodResponse(
      {required this.items, required this.total, this.totalProducts});

  factory LinkfoodResponse.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<ItemLinkFood> items =
        itemsList.map((i) => ItemLinkFood.fromJson(i)).toList();

    return LinkfoodResponse(
      items: items,
      total: json['total'],
      totalProducts: json['totalProducts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'totalProducts': totalProducts,
    };
  }
}

class ItemLinkFood {
  int id;
  String? name;
  int? storeId;
  List<MenuFoodResponseItem>? products;
  int? totalProducts;

  ItemLinkFood({
    required this.id,
    this.name,
    this.storeId,
    this.products,
    this.totalProducts,
  });

  factory ItemLinkFood.fromJson(Map<String, dynamic> json) {
    var productList =
        json['products'] != null ? json['products'] as List : null;
    List<MenuFoodResponseItem>? products =
        productList?.map((p) => MenuFoodResponseItem.fromJson(p)).toList();

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

// class DetailLinkFood {
//   int id;
//   String name;
//   int? sold;
//   int? viewed;
//   int? liked;
//   int? price;
//   String? status;
//   String? imageId;
//   String? reason;
//
//   DetailLinkFood({
//     required this.id,
//     required this.name,
//     this.imageId,
//     this.liked,
//     this.price,
//     this.sold,
//     this.status,
//     this.viewed,
//     this.reason,
//   });
//
//   factory DetailLinkFood.fromJson(Map<String, dynamic> json) {
//     return DetailLinkFood(
//       id: json['id'],
//       name: json['name'],
//       imageId: json['imageId'],
//       liked: json['liked'],
//       price: json['price'],
//       sold: json['sold'],
//       status: json['status'],
//       viewed: json['viewed'],
//       reason: json['reason'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'imageId': imageId,
//       'price': price,
//       'liked': liked,
//       'sold': sold,
//       'status': status,
//       'viewed': viewed,
//       'reason': reason,
//     };
//   }
// }
