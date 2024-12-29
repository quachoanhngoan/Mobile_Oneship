import 'package:equatable/equatable.dart';

class ToppingCustomState extends Equatable {
  final bool isFilledInfo;
  final String title;
  final int indexOptionTopping;
  final String? errorNameTopping;
  // final String? errorPriceTopping;
  final bool isToppingClearButton;
  final bool isPriceClearButton;

  const ToppingCustomState(
      {this.isFilledInfo = false,
      this.title = "Thêm nhóm topping",
      this.indexOptionTopping = 0,
      this.errorNameTopping,
      // this.errorPriceTopping,
      this.isToppingClearButton = false,
      this.isPriceClearButton = false});

  @override
  List<Object?> get props => [
        title,
        isFilledInfo,
        indexOptionTopping,
        errorNameTopping,
        isToppingClearButton,
        isPriceClearButton,
      ];

  ToppingCustomState copyWith({
    String? title,
    bool? isFilledInfo,
    int? indexOptionTopping,
    String? errorNameTopping,
    // String? errorPriceTopping,
    bool? isToppingClearButton,
    bool? isPriceClearButton,
  }) {
    return ToppingCustomState(
      title: title ?? this.title,
      isFilledInfo: isFilledInfo ?? this.isFilledInfo,
      indexOptionTopping: indexOptionTopping ?? this.indexOptionTopping,
      errorNameTopping: errorNameTopping ?? this.errorNameTopping,
      // errorPriceTopping: errorPriceTopping ?? this.errorPriceTopping,
      isToppingClearButton: isToppingClearButton ?? this.isToppingClearButton,
      isPriceClearButton: isPriceClearButton ?? this.isPriceClearButton,
    );
  }

  bool isButtonNextEnable() {
    return isFilledInfo;
  }
}
