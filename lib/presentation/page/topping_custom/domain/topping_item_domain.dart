enum StatusToppingType { isInUse, isUnused }

extension StatusToppingExtension on StatusToppingType {
  String get title {
    switch (this) {
      case StatusToppingType.isInUse:
        return "Đang sử dụng";
      case StatusToppingType.isUnused:
        return "Chưa sử dụng";
    }
  }
}

class ToppingItemDomain {
  final String? name;
  final String? price;
  StatusToppingType type;

  ToppingItemDomain(
      {this.name, this.price, this.type = StatusToppingType.isUnused});

  ToppingItemDomain copyWith(
      {String? name, String? price, StatusToppingType? type}) {
    return ToppingItemDomain(
      name: name ?? this.name,
      price: price ?? this.price,
      type: type ?? this.type,
    );
  }
}
