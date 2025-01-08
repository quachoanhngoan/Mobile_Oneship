import 'linkfood_response.dart';

class CategoryGlobalResponse {
  final List<ItemCategoryGlobal>? items;
  final int? total;

  CategoryGlobalResponse({
    this.items,
    this.total,
  });

  factory CategoryGlobalResponse.fromJson(Map<String, dynamic> json) {
    return CategoryGlobalResponse(
      items: (json['items'] as List?)
          ?.map((e) => ItemCategoryGlobal.fromJson(e))
          .toList(),
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((e) => e.toJson()).toList(),
      'total': total,
    };
  }
}

class ItemCategoryGlobal {
  final int? id;
  final String? name;

  ItemCategoryGlobal({
    this.id,
    this.name,
  });

  factory ItemCategoryGlobal.fromJson(Map<String, dynamic> json) {
    return ItemCategoryGlobal(
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

  ItemLinkFood? convertToLinkFood() {
    if (id != null) {
      return ItemLinkFood(id: id!, name: name ?? "");
    }
    return null;
  }
}
