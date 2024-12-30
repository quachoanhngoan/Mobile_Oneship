import 'package:equatable/equatable.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/domain/topping_item_domain.dart';

class ToppingCustomState extends Equatable {
  final bool isFilledInfo;
  final String title;
  final int indexOptionTopping;
  final String? errorNameTopping;
  // final String? errorPriceTopping;
  final bool isToppingClearButton;
  final bool isPriceClearButton;
  final List<ToppingItemDomain> listTopping;

  const ToppingCustomState(
      {this.isFilledInfo = false,
      this.title = "Thêm nhóm topping",
      this.indexOptionTopping = 0,
      this.errorNameTopping,
      // this.errorPriceTopping,
      this.isToppingClearButton = false,
      this.isPriceClearButton = false,
      this.listTopping = const []});

  @override
  List<Object?> get props => [
        title,
        isFilledInfo,
        indexOptionTopping,
        errorNameTopping,
        isToppingClearButton,
        isPriceClearButton,
        listTopping,
      ];

  ToppingCustomState copyWith({
    String? title,
    bool? isFilledInfo,
    int? indexOptionTopping,
    String? errorNameTopping,
    // String? errorPriceTopping,
    bool? isToppingClearButton,
    bool? isPriceClearButton,
    List<ToppingItemDomain>? listTopping,
  }) {
    return ToppingCustomState(
      title: title ?? this.title,
      isFilledInfo: isFilledInfo ?? this.isFilledInfo,
      indexOptionTopping: indexOptionTopping ?? this.indexOptionTopping,
      errorNameTopping: errorNameTopping ?? this.errorNameTopping,
      // errorPriceTopping: errorPriceTopping ?? this.errorPriceTopping,
      isToppingClearButton: isToppingClearButton ?? this.isToppingClearButton,
      isPriceClearButton: isPriceClearButton ?? this.isPriceClearButton,
      listTopping: listTopping ?? this.listTopping,
    );
  }

  bool isButtonNextEnable() {
    return isFilledInfo;
  }
}
