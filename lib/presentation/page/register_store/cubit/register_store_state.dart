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
  final int typeService;
  final bool isAlcohol;
  final List<ProvinceModel> listProvinces;
  final List<BankM> banks;
  final List<BranchBankM> branchBanks;
  final ProvinceModel? locationBusSellected;
  final Representative? representative;
  // final String? errorNameStore;
  final String? errorPhoneContact;
  final String? errorGroupService;
  final String? errorProvinces;
  final String? errorDistrict;
  final String? errorWard;
  final String? errorStreetNumber;
  final bool showHintNameStore;
  final BankRequest? bankRequest;
  RegisterStoreState({
    this.showHintNameStore = false,
    this.status = EState.initial,
    this.stores = const [],
    this.banks = const [],
    this.currentPage = ERegisterPageType.termsAndConditions,
    this.isAcceptTermsAndConditions = false,
    this.isAlcohol = false,
    this.typeService = 1,
    this.listProvinces = const [],
    this.branchBanks = const [],
    this.locationBusSellected,
    this.errorDistrict,
    this.errorGroupService,
    // this.errorNameStore,
    this.errorPhoneContact,
    this.errorProvinces,
    this.errorStreetNumber,
    this.errorWard,
    this.representative = const Representative(),
    this.bankRequest = const BankRequest(),
  });

  RegisterStoreState copyWith({
    EState? status,
    List<StoreModel>? stores,
    List<BankM>? banks,
    List<BranchBankM>? branchBanks,
    ERegisterPageType? currentPage,
    bool? isAcceptTermsAndConditions,
    int? typeService,
    bool? isAlcohol,
    List<ProvinceModel>? listProvinces,
    ProvinceModel? locationBusSellected,
    bool? showHintNameStore,
    String? errorPhoneContact,
    String? errorGroupService,
    String? errorProvinces,
    String? errorDistrict,
    String? errorWard,
    String? errorStreetNumber,
    Representative? representative,
    BankRequest? bankRequest,
  }) {
    return RegisterStoreState(
      representative: representative ?? this.representative,
      status: status ?? this.status,
      stores: stores ?? this.stores,
      banks: banks ?? this.banks,
      branchBanks: branchBanks ?? this.branchBanks,
      currentPage: currentPage ?? this.currentPage,
      isAcceptTermsAndConditions:
          isAcceptTermsAndConditions ?? this.isAcceptTermsAndConditions,
      typeService: typeService ?? this.typeService,
      isAlcohol: isAlcohol ?? this.isAlcohol,
      listProvinces: listProvinces ?? this.listProvinces,
      locationBusSellected: locationBusSellected ?? this.locationBusSellected,
      showHintNameStore: showHintNameStore ?? this.showHintNameStore,
      errorPhoneContact: errorPhoneContact ?? this.errorPhoneContact,
      bankRequest: bankRequest ?? this.bankRequest,
    );
  }

  bool isButtonNextEnable() {
    switch (currentPage) {
      case ERegisterPageType.termsAndConditions:
        return isAcceptTermsAndConditions;
      case ERegisterPageType.typeOfService:
        return true;
      case ERegisterPageType.locationService:
        return locationBusSellected != null;
      case ERegisterPageType.storeInformation:
        return true;
      case ERegisterPageType.representativeInformation:
        return representative != null && representative!.isValid();
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

enum ERepresentativeInformation {
  individual,
  businessHousehold,
  business,
  ;

  String get name {
    switch (this) {
      case ERepresentativeInformation.individual:
        return 'Cá nhân';
      case ERepresentativeInformation.business:
        return 'Doanh nghiệp';
      case ERepresentativeInformation.businessHousehold:
        return 'Hộ kinh doanh';
      default:
        return '';
    }
  }

  String get value {
    switch (this) {
      case ERepresentativeInformation.individual:
        return 'individual';
      case ERepresentativeInformation.business:
        return 'business';
      case ERepresentativeInformation.businessHousehold:
        return 'business_household';
      default:
        return '';
    }
  }
}
