import 'package:equatable/equatable.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';

class ToppingCustomState extends Equatable {
  final String? nameTopping;
  final String? linkedFoodName;

  const ToppingCustomState({this.linkedFoodName, this.nameTopping});
  @override
  List<Object?> get props => [];

  bool isButtonNextEnable() {
    return nameTopping.isNotNullOrEmpty && linkedFoodName.isNotNullOrEmpty;
  }
}
