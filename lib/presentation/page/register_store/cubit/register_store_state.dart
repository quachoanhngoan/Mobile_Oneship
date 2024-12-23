part of 'register_store_cubit.dart';

enum ERegisterPageType {
  termsAndConditions,
  //loại hình dịch vụ
  typeOfService,
  //khu vực phục vụ
  locationService,
  //thời gian phục vụ
  //thông tin quán
  storeInformation,

  //thông tin người đại diện
  representativeInformation,
  //thông tin ngân hàng
  bankInformation,
  //hình ảnh quán
  storeImages,
  //xem lại thông tin
  reviewInformation;

  String get title {
    switch (this) {
      case ERegisterPageType.termsAndConditions:
        return 'Điều khoản và điều kiện';
      case ERegisterPageType.typeOfService:
        return 'Loại hình dịch vụ';
      case ERegisterPageType.locationService:
        return 'Khu vực kinh doanh';
      case ERegisterPageType.storeInformation:
        return 'Thông tin quán';
      case ERegisterPageType.representativeInformation:
        return 'Thông tin người đại diện';
      case ERegisterPageType.bankInformation:
        return 'Thông tin ngân hàng';
      case ERegisterPageType.storeImages:
        return 'Hình ảnh quán';
      case ERegisterPageType.reviewInformation:
        return 'Thông tin tổng quan';
      default:
        return '';
    }
  }
}

class RegisterStoreState {
  final EState status;
  final List<StoreModel> stores;
  final ERegisterPageType currentPage;
  final bool isAcceptTermsAndConditions;
  RegisterStoreState({
    this.status = EState.initial,
    this.stores = const [],
    this.currentPage = ERegisterPageType.termsAndConditions,
    this.isAcceptTermsAndConditions = false,
  });

  RegisterStoreState copyWith({
    EState? status,
    List<StoreModel>? stores,
    ERegisterPageType? currentPage,
    bool? isAcceptTermsAndConditions,
  }) {
    return RegisterStoreState(
      status: status ?? this.status,
      stores: stores ?? this.stores,
      currentPage: currentPage ?? this.currentPage,
      isAcceptTermsAndConditions:
          isAcceptTermsAndConditions ?? this.isAcceptTermsAndConditions,
    );
  }

  bool isButtonNextEnable() {
    switch (currentPage) {
      case ERegisterPageType.termsAndConditions:
        return isAcceptTermsAndConditions;
      case ERegisterPageType.typeOfService:
        return true;
      case ERegisterPageType.locationService:
        return true;
      case ERegisterPageType.storeInformation:
        return true;
      case ERegisterPageType.representativeInformation:
        return true;
      case ERegisterPageType.bankInformation:
        return true;
      case ERegisterPageType.storeImages:
        return true;
      case ERegisterPageType.reviewInformation:
        return true;
      default:
        return false;
    }
  }
}
