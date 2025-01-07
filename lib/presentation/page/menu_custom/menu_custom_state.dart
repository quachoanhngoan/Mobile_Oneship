import 'package:equatable/equatable.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';

class MenuCustomState extends Equatable {
  final List<ItemLinkFood>? listCategoryGlobal;
  final bool isShowGooCategoryClear;
  final bool isShowStoreCategorClear;
  final bool isSellectCheckBox;
  final bool isFilledInfo;
  final ItemLinkFood? categorySellectGlobal;
  final bool isLoading;
  final bool isCompleteSuccess;
  final String? isCompleteError;

  const MenuCustomState({
    this.listCategoryGlobal,
    this.isFilledInfo = false,
    this.isSellectCheckBox = false,
    this.isShowGooCategoryClear = false,
    this.isShowStoreCategorClear = false,
    this.categorySellectGlobal,
    this.isCompleteSuccess = false,
    this.isCompleteError,
    this.isLoading = false,
  });

  MenuCustomState copyWith({
    List<ItemLinkFood>? listCategoryGlobal,
    String? errorNameGooCategory,
    String? errorNameStoreCategory,
    bool? isFilledInfo,
    bool? isSellectCheckBox,
    bool? isShowGooCategoryClear,
    bool? isShowStoreCategorClear,
    ItemLinkFood? categorySellectGlobal,
    bool? isCompleteSuccess,
    String? isCompleteError,
    bool? isLoading,
  }) {
    return MenuCustomState(
      listCategoryGlobal: listCategoryGlobal ?? this.listCategoryGlobal,
      isFilledInfo: isFilledInfo ?? this.isFilledInfo,
      isSellectCheckBox: isSellectCheckBox ?? this.isSellectCheckBox,
      isShowGooCategoryClear:
          isShowGooCategoryClear ?? this.isShowGooCategoryClear,
      isShowStoreCategorClear:
          isShowStoreCategorClear ?? this.isShowStoreCategorClear,
      categorySellectGlobal:
          categorySellectGlobal ?? this.categorySellectGlobal,
      isCompleteSuccess: isCompleteSuccess ?? false,
      isCompleteError: isCompleteError,
      isLoading: isLoading ?? false,
    );
  }

  bool isButtonNextEnable() {
    return isFilledInfo;
  }

  @override
  List<Object?> get props => [
        listCategoryGlobal,
        isShowStoreCategorClear,
        isShowGooCategoryClear,
        isFilledInfo,
        isSellectCheckBox,
        categorySellectGlobal,
        isCompleteSuccess,
        isCompleteError,
        isLoading,
      ];
}
