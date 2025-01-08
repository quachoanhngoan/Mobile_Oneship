import 'package:equatable/equatable.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/page/menu_dishes_custom/model/time_sell_type.dart';

class MenuDishesState extends Equatable {
  final bool isLoading;
  final bool isCompleteSuccess;
  final String? isCompleteError;
  final bool isShowClearNameFood;
  final bool isShowClearPrice;
  final bool isShowClearTopping;
  final bool isShowClearCategory;
  final List<ItemLinkFood> listCategoryStore;
  final ItemLinkFood? categoryStoreSellect;
  final TimeSellType typeTime;
  final String? errorTimeSellect;
  final bool isFilledSellectTime;
  final bool isFilledAllInfo;
  final List<GrAddToppingResponse> listLinkFood;
  final List<ProductAddTopping> listIdLinkFoodSellected;
  final String? imageId;

  const MenuDishesState({
    this.isLoading = false,
    this.isCompleteSuccess = false,
    this.isCompleteError,
    this.isShowClearNameFood = false,
    this.isShowClearPrice = false,
    this.listCategoryStore = const [],
    this.categoryStoreSellect,
    this.typeTime = TimeSellType.timeStore,
    this.errorTimeSellect,
    this.isFilledSellectTime = false,
    this.listLinkFood = const [],
    this.isFilledAllInfo = false,
    this.listIdLinkFoodSellected = const [],
    this.imageId,
    this.isShowClearTopping = false,
    this.isShowClearCategory = false,
  });

  MenuDishesState copyWith({
    bool? isLoading,
    bool? isCompleteSuccess,
    String? isCompleteError,
    bool? isShowClearNameFood,
    bool? isShowClearPrice,
    List<ItemLinkFood>? listCategoryStore,
    ItemLinkFood? categoryStoreSellect,
    TimeSellType? typeTime,
    String? errorTimeSellect,
    bool? isFilledSellectTime,
    List<GrAddToppingResponse>? listLinkFood,
    bool? isFilledAllInfo,
    String? imageId,
    List<ProductAddTopping>? listIdLinkFoodSellected,
    bool? isShowClearTopping,
    bool? isShowClearCategory,
  }) {
    return MenuDishesState(
      isLoading: isLoading ?? false,
      isCompleteSuccess: isCompleteSuccess ?? false,
      isCompleteError: isCompleteError,
      isShowClearNameFood: isShowClearNameFood ?? this.isShowClearNameFood,
      isShowClearPrice: isShowClearPrice ?? this.isShowClearPrice,
      listCategoryStore: listCategoryStore ?? this.listCategoryStore,
      categoryStoreSellect: categoryStoreSellect ?? this.categoryStoreSellect,
      typeTime: typeTime ?? this.typeTime,
      errorTimeSellect: errorTimeSellect,
      isFilledSellectTime: isFilledSellectTime ?? this.isFilledSellectTime,
      listLinkFood: listLinkFood ?? this.listLinkFood,
      isFilledAllInfo: isFilledAllInfo ?? this.isFilledAllInfo,
      imageId: imageId ?? this.imageId,
      listIdLinkFoodSellected:
          listIdLinkFoodSellected ?? this.listIdLinkFoodSellected,
      isShowClearTopping: isShowClearTopping ?? this.isShowClearTopping,
      isShowClearCategory: isShowClearCategory ?? this.isShowClearCategory,
    );
  }

  bool isButtonNextEnable() {
    return isFilledAllInfo && imageId != null;
  }

  bool isButtonSaveTimeEnable() {
    return isFilledSellectTime;
  }

  @override
  List<Object?> get props => [
        isLoading,
        isCompleteSuccess,
        isCompleteError,
        isShowClearNameFood,
        isShowClearPrice,
        listCategoryStore,
        categoryStoreSellect,
        typeTime,
        errorTimeSellect,
        isFilledSellectTime,
        listLinkFood,
        isFilledAllInfo,
        listIdLinkFoodSellected,
        isShowClearTopping,
        imageId,
        isShowClearCategory,
      ];
}
