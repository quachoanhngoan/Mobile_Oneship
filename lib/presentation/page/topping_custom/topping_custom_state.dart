import 'package:equatable/equatable.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
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
  final String? showErrorComplete;
  final bool? isCompleteSuccess;
  final bool isLoading;
  final List<ItemLinkFood> listLinkFood;

  const ToppingCustomState(
      {this.isFilledInfo = false,
      this.title = "Thêm nhóm topping",
      this.indexOptionTopping = 0,
      this.errorNameTopping,
      // this.errorPriceTopping,
      this.isToppingClearButton = false,
      this.isPriceClearButton = false,
      this.listTopping = const [],
      this.showErrorComplete,
      this.isCompleteSuccess,
      this.isLoading = false,
      this.listLinkFood = const []});

  @override
  List<Object?> get props => [
        title,
        isFilledInfo,
        indexOptionTopping,
        errorNameTopping,
        isToppingClearButton,
        isPriceClearButton,
        listTopping,
        showErrorComplete,
        isCompleteSuccess,
        isLoading,
        listLinkFood,
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
    String? showErrorComplete,
    bool? isCompleteSuccess,
    bool? isLoading,
    List<ItemLinkFood>? listLinkFood,
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
        showErrorComplete: showErrorComplete,
        isCompleteSuccess: isCompleteSuccess,
        isLoading: isLoading ?? false,
        listLinkFood: listLinkFood ?? this.listLinkFood);
  }

  bool isButtonNextEnable() {
    return isFilledInfo;
  }
}
