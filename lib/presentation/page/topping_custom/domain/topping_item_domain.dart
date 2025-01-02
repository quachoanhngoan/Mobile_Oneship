import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_request.dart';

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

  String requestName() {
    switch (this) {
      case StatusToppingType.isInUse:
        return "active";
      case StatusToppingType.isUnused:
        return "inactive";
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

  OptionAddTopping? convertAddTopping() {
    if (name != null && price != null) {
      return OptionAddTopping(
          name: name!,
          price:
              int.parse(price!.split(" ").first.replaceAll(RegExp(r','), "")),
          status: type.requestName());
    }
    return null;
  }
}
