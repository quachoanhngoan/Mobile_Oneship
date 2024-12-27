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
  final EState registerStatus;
  final List<StoreModel> stores;
  final ERegisterPageType currentPage;
  final bool isAcceptTermsAndConditions;
  final int typeService;
  final String? nameService;
  final bool isAlcohol;
  final List<ProvinceModel> listProvinces;
  final List<BankM> banks;
  final List<BranchBankM> branchBanks;
  final ProvinceModel? locationBusSellected;
  final Representative? representative;
  final String? errorPhoneContact;
  final List<GroupServiceModel> listGroupService;
  final String? errorProvinces;
  final String? errorDistrict;
  final String? errorWard;
  final String? errorStreetNumber;
  final bool showHintNameStore;
  final BankRequest? bankRequest;
  final Infomation? infomation;
  final List<DistrictModel> listDistrict;
  final List<DistrictModel> listWard;
  final bool isNextEnable;
  final String? storeAvatarId;
  final String? storeCoverId;
  final String? storeFrontId;
  final String? storeMenuId;

  const RegisterStoreState({
    this.showHintNameStore = true,
    this.status = EState.initial,
    this.registerStatus = EState.initial,
    this.stores = const [],
    this.banks = const [],
    this.currentPage = ERegisterPageType.termsAndConditions,
    this.isAcceptTermsAndConditions = false,
    this.isAlcohol = false,
    this.nameService = "Giao đồ ăn (cửa hàng ăn uống)",
    this.typeService = 1,
    this.listProvinces = const [],
    this.locationBusSellected,
    this.errorDistrict,
    this.listGroupService = const [],
    this.errorPhoneContact,
    this.errorProvinces,
    this.errorStreetNumber,
    this.errorWard,
    this.representative = const Representative(),
    this.infomation = const Infomation(),
    this.bankRequest = const BankRequest(),
    this.branchBanks = const [],
    this.listDistrict = const [],
    this.listWard = const [],
    this.isNextEnable = false,
    this.storeAvatarId,
    this.storeCoverId,
    this.storeFrontId,
    this.storeMenuId,
  });

  RegisterStoreState copyWith({
    EState? status,
    EState? registerStatus,
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
    List<GroupServiceModel>? listGroupService,
    List<DistrictModel>? listDistrict,
    String? errorProvinces,
    String? errorDistrict,
    String? errorWard,
    String? errorStreetNumber,
    Representative? representative,
    Infomation? infomation,
    BankRequest? bankRequest,
    List<DistrictModel>? listWard,
    bool? isNextEnable,
    bool? isInit,
    String? storeAvatarId,
    String? storeCoverId,
    String? storeFrontId,
    String? storeMenuId,
    String? nameService,
  }) {
    return RegisterStoreState(
      representative: representative ?? this.representative,
      status: status ?? this.status,
      registerStatus: registerStatus ?? this.registerStatus,
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
      listGroupService: listGroupService ?? this.listGroupService,
      errorProvinces: errorProvinces,
      errorDistrict: errorDistrict,
      errorWard: errorWard,
      errorStreetNumber: errorStreetNumber,
      listDistrict: listDistrict ?? this.listDistrict,
      infomation: infomation ?? this.infomation,
      listWard: listWard ?? this.listWard,
      isNextEnable: isNextEnable ?? false,
      storeAvatarId: storeAvatarId ?? this.storeAvatarId,
      storeCoverId: storeCoverId ?? this.storeCoverId,
      storeFrontId: storeFrontId ?? this.storeFrontId,
      storeMenuId: storeMenuId ?? this.storeMenuId,
      nameService: nameService ?? this.nameService,
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
        return infomation != null && infomation!.isValid();
      case ERegisterPageType.representativeInformation:
        return representative != null && representative!.isValid();
      case ERegisterPageType.bankInformation:
        return bankRequest != null && bankRequest!.isValid();
      case ERegisterPageType.storeImages:
        return storeAvatarId != null &&
            storeCoverId != null &&
            storeFrontId != null &&
            storeMenuId != null;
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

  static ERepresentativeInformation fromString(String value) {
    switch (value) {
      case 'individual':
        return ERepresentativeInformation.individual;
      case 'business':
        return ERepresentativeInformation.business;
      case 'business_household':
        return ERepresentativeInformation.businessHousehold;
      default:
        return ERepresentativeInformation.individual;
    }
  }
}
