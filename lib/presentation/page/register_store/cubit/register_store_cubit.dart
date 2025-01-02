import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/core/helper/validate.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/district_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/store_request_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/bank.model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';
import 'package:oneship_merchant_app/presentation/data/validations/user_validation.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

import '../../../data/model/register_store/group_service_model.dart';
import '../../../data/model/register_store/provinces_model.dart';
import 'register_request.dart';

part 'register_store_state.dart';

class RegisterStoreCubit extends Cubit<RegisterStoreState> {
  final StoreRepository repository;
  RegisterStoreCubit(this.repository) : super(const RegisterStoreState()) {
    _getAllBanks();
    _getAllLocationBussiness();
    _getAllGroupService();
  }

  final pageController = PageController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController selectBankController = TextEditingController();
  final TextEditingController selectBankBranchController =
      TextEditingController();
  final TextEditingController nameStoreController = TextEditingController();
  final TextEditingController specialDishController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController phoneContactController = TextEditingController();
  final TextEditingController groupServiceController = TextEditingController();
  final TextEditingController providerController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController parkingFeeController = TextEditingController();
  final TextEditingController wardController = TextEditingController();

  int? idStore;
  setStatusState(EState value) {
    emit(state.copyWith(status: value));
  }

  getAll() async {
    setStatusState(EState.loading);
    final response = await execute(
      () => repository.getAll(),
      isShowFailDialog: true,
    );
    response.when(success: (data) {
      setStatusState(EState.success);
      emit(state.copyWith(stores: data.items ?? []));
    }, failure: (error) {
      setStatusState(EState.failure);
    });
  }

  getStoreById(int id, bool isRegistered) async {
    setStatusState(EState.loading);
    await _getAllBanks();
    await _getAllLocationBussiness();
    await _getAllGroupService();
    final response = await execute(
      () => repository.getStoreById(id),
      isShowFailDialog: true,
    );
    response.when(success: (data) async {
      ///step 1
      if (data.provinceId != null) {
        await changeProvices(data.provinceId!);
      }
      if (data.districtId != null) {
        await changeDistrict(data.districtId!);
      }

      setAcceptTermsAndConditions(true);
      emit(state.copyWith(
        isAlcohol: data.isAlcohol,
      ));
      //step 2

      if (data.businessArea != null) {
        sellectLocationBussiness(data.businessArea!);
      }
      typeServiceSellect(data.serviceTypeId ?? 1);
      if (data.banks != null && data.banks!.isNotEmpty) {
        setBankRequest(BankRequest(
          bankId: data.banks!.first.bankId,
          bankAccountName: data.banks!.first.bankAccountName,
          bankAccountNumber: data.banks!.first.bankAccountNumber,
          bankBranchId: data.banks!.first.bankBranchId,
        ));

        if (data.banks!.first.bankId != null) {
          _getBranchBanks(data.banks!.first.bankId!);
          final bank = state.banks.firstWhere(
              (element) => element.id == data.banks!.first.bankId,
              orElse: () => BankM());
          selectBankController.text = bank.name ?? "";
        }
        // _getBranchBanks(data.banks!.first.bankId!);
      }

      if (data.serviceGroupId != null) {
        final groupService = state.listGroupService.firstWhere(
            (element) => element.id == data.serviceGroupId,
            orElse: () => GroupServiceModel());
        // setNameService(groupService.name ?? "");
        // print("groupService.name ${groupService.name}");
        groupServiceController.text = groupService.name ?? "";
      }
      final name = data.serviceTypeId == 1
          ? "Giao đồ ăn (cửa hàng ăn uống)"
          : data.serviceTypeId == 2
              ? "Giao hàng siêu thị/ bách hoá"
              : "Giao đồ ăn (cửa hàng ăn uống)";
      setNameService(name);
      if (data.representative != null) {
        setRepresentative(state.representative?.copyWith(
          type: ERepresentativeInformation.fromString(
              data.representative!.type ?? "individual"),
          name: data.representative!.name,
          phone: data.representative!.phone,
          otherPhone: data.representative!.orderPhone,
          email: data.representative!.email,
          taxCode: data.representative!.taxCode,
          address: data.representative!.address,
          // personalTaxCode: data.representative!.personalTaxCode,
          businessName: data.representative!.businessName,
          businessLicenseImageId: data.representative!.businessLicenseImageId,
          identityCard: data.representative!.identityCard,
          identityCardBackImageId: data.representative!.identityCardBackImageId,
          identityCardFrontImageId:
              data.representative!.identityCardFrontImageId,
          identityCardDate: data.representative!.identityCardDate,
          identityCardPlace: data.representative!.identityCardPlace,
          relatedImageId: data.representative!.relatedImageId,
        ));
        dateController.text = data.representative!.identityCardDate ?? "";
      }
      // if (data.address != null) {

      setInfomatinoStore(Infomation(
        nameStore: data.name,
        phoneNumber: data.phoneNumber,
        groupServiceID: data.serviceGroupId,
        homeAndStreet: data.address,
        ward: data.wardId,
        wardName: data.ward?.name,
        provinces: data.province?.name,
        idProvince: data.province?.id,
        districtName: data.district?.name,
        district: data.districtId,
        streetName: data.streetName,
        specialDish: data.specialDish,
        parkingFee: data.parkingFee.toString(),
      ));
      providerController.text = data.province?.name ?? "";
      nameStoreController.text = data.name ?? "";
      phoneContactController.text = data.phoneNumber ?? "";
      specialDishController.text = data.specialDish ?? "";
      streetNameController.text = data.streetName ?? "";
      parkingFeeController.text = data.parkingFee?.toString() ?? "";

      wardController.text = data.ward?.name?.toString() ?? "";
      districtController.text = data.district?.name?.toString() ?? "";
      streetAddressController.text = data.address ?? "";

      setStoreAvatarId(data.storeAvatarId);
      setStoreCoverId(data.storeCoverId);
      setStoreFrontId(data.storeFrontId);
      setStoreMenuId(data.storeMenuId);

      setStatusState(EState.success);
    }, failure: (error) {
      setStatusState(EState.failure);
    });
  }

  resetState() {
    emit(const RegisterStoreState());
  }

  setAcceptTermsAndConditions(bool value) {
    emit(state.copyWith(isAcceptTermsAndConditions: value));
  }

  setCurrentPage(ERegisterPageType page) {
    emit(state.copyWith(currentPage: page));
  }

  setNextPage() {
    if (state.currentPage == ERegisterPageType.reviewInformation) {
      dialogService.showAlertDialog(
        title: 'Thông báo',
        description: 'Đăng ký cửa hàng thành công',
        buttonTitle: 'Đóng',
        onPressed: () {
          Get.back();
          Get.back();
        },
      );
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    if (state.currentPage == ERegisterPageType.typeOfService) {
      _getAllLocationBussiness();
      _getAllGroupService();
    }
    if (state.currentPage == ERegisterPageType.bankInformation) {
      _getAllBanks();
    }
    setCurrentPage(ERegisterPageType.values[state.currentPage.index + 1]);
  }

  setPreviousPage() {
    if (state.currentPage.index == 0) {
      dialogService.showAlertDialog(
        title: 'Thông báo',
        description: 'Bạn có chắc chắn muốn thoát khỏi quá trình đăng ký?',
        buttonTitle: 'Thoát',
        onCancel: () => Get.back(),
        onPressed: () {
          Get.back();
          Get.back();
        },
        buttonCancelTitle: 'Hủy',
      );
      return;
    }
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setCurrentPage(ERegisterPageType.values[state.currentPage.index - 1]);
  }

  typeServiceSellect(int type) {
    emit(state.copyWith(typeService: type));
  }

  setNameService(String name) {
    emit(state.copyWith(nameService: name));
  }

  alcoholSellect(bool isAlcohol) {
    emit(state.copyWith(isAlcohol: isAlcohol));
  }

  Future _getAllLocationBussiness() async {
    if (state.listProvinces.isEmpty) {
      final listProvinces = await execute(
        () => (repository.getProvinces()),
        isShowFailDialog: true,
      );
      listProvinces.when(
        success: (data) {
          emit(state.copyWith(listProvinces: data?.provinces ?? []));
        },
      );
    }
  }

  Future _getAllBanks() async {
    if (state.banks.isEmpty) {
      final banks = await execute(
        () => repository.getBanks(),
        isShowFailDialog: true,
      );
      banks.when(
          success: (data) {
            emit(state.copyWith(banks: data ?? []));
          },
          failure: (error) {});
    }
  }

  Future _getBranchBanks(int bankId) async {
    final branchBanks = await execute(
      () => repository.getBanksBranch(bankId),
      isShowFailDialog: true,
    );
    branchBanks.when(
        success: (data) {
          emit(state.copyWith(branchBanks: data ?? []));
          if (data != null && data.isNotEmpty) {
            if (state.bankRequest?.bankBranchId != null) {
              final branch = data.firstWhere(
                  (element) => element.id == state.bankRequest?.bankBranchId);
              selectBankBranchController.text = branch.name ?? "";
              setBankRequest(state.bankRequest?.copyWith(
                bankBranchName: branch.name.toString(),
              ));
            }
          }
        },
        failure: (error) {});
  }

  sellectLocationBussiness(ProvinceModel provinces) {
    emit(state.copyWith(locationBusSellected: provinces));
  }

  setBankRequest(BankRequest? request) {
    if (request != null) {
      if (request.bankId != null &&
          request.bankId != state.bankRequest?.bankId) {
        emit(state.copyWith(
          bankRequest: request,
          branchBanks: [],
        ));
        _getBranchBanks(request.bankId!);
      } else {
        emit(state.copyWith(bankRequest: request));
      }
    }
  }

  nameStoreVerify(String? value) {
    emit(state.copyWith(showHintNameStore: !value.isNotNullOrEmpty));
  }

  setRepresentative(Representative? value) {
    emit(state.copyWith(representative: value));
  }

  validatePhone(String? phone) {
    if (phone.isNotNullOrEmpty) {
      final isPhone = injector.get<UserValidate>().phoneValid(phone!);
      if (isPhone) {
        emit(state.copyWith(errorPhoneContact: null));
      } else {
        emit(state.copyWith(errorPhoneContact: "Số điện thoại không đúng."));
      }
    } else {
      emit(state.copyWith(errorPhoneContact: null));
    }
  }

  Future _getAllGroupService() async {
    if (state.listGroupService.isEmpty) {
      final listGroupService = await repository.getGroupService();
      emit(state.copyWith(listGroupService: listGroupService));
    }
  }

  changeProvices(int provicesID) async {
    final listDistrict = await repository.listDistrict(provicesID);
    emit(state.copyWith(listDistrict: listDistrict));
  }

  changeDistrict(int districtID) async {
    final listWard = await repository.listWard(districtID);
    emit(state.copyWith(listWard: listWard));
  }

  // verifyContinueInfoStore(
  //     {String? nameStore,
  //     String? phoneNumber,
  //     String? groupService,
  //     String? provinces,
  //     String? district,
  //     String? ward,
  //     String? homeAndStreet}) {
  //   if (nameStore.isNotNullOrEmpty &&
  //       phoneNumber.isNotNullOrEmpty &&
  //       groupService.isNotNullOrEmpty &&
  //       provinces.isNotNullOrEmpty &&
  //       district.isNotNullOrEmpty &&
  //       ward.isNotNullOrEmpty &&
  //       homeAndStreet.isNotNullOrEmpty) {
  //     emit(state.copyWith(isNextEnable: true));
  //   } else {
  //     emit(state.copyWith(isNextEnable: false));
  //   }
  // }

  setRegisterStatus(EState request) {
    emit(state.copyWith(registerStatus: request));
  }

  setInfomatinoStore(Infomation? infomation) {
    emit(state.copyWith(infomation: infomation));
  }

  Future registerStorePress({
    bool? gotoNextPage = false,
  }) async {
    if (state.currentPage == ERegisterPageType.termsAndConditions ||
        state.currentPage == ERegisterPageType.typeOfService) {
      setNextPage();
      return;
    }
    if (state.currentPage == ERegisterPageType.storeInformation &&
        ValidateHelper.validatePhone(state.infomation?.phoneNumber ?? "") ==
            false) {
      dialogService.showAlertDialog(
        onPressed: () {
          Get.back();
        },
        title: 'Thông báo',
        description: "Số điện thoại không đúng.",
        buttonTitle: 'Đóng',
      );
      return;
    }

    if (state.currentPage == ERegisterPageType.representativeInformation) {
      if (state.representative?.phone.isNotNullOrEmpty == true &&
          ValidateHelper.validatePhone(state.representative?.phone ?? "") ==
              false) {
        dialogService.showAlertDialog(
          onPressed: () {
            Get.back();
          },
          title: 'Thông báo',
          description: "Số điện thoại không đúng.",
          buttonTitle: 'Đóng',
        );
        return;
      }

      if (state.representative?.otherPhone?.isNotNullOrEmpty == true &&
          ValidateHelper.validatePhone(
                  state.representative?.otherPhone ?? "") ==
              false) {
        dialogService.showAlertDialog(
          onPressed: () {
            Get.back();
          },
          title: 'Thông báo',
          description: "Số điện thoại khác không đúng.",
          buttonTitle: 'Đóng',
        );
        return;
      }
    }

    setRegisterStatus(EState.loading);
    final request = StoreRequestModel(
      isDraft: state.currentPage == ERegisterPageType.reviewInformation
          ? false
          : true,
      name: state.infomation?.nameStore,
      serviceGroupId: state.infomation?.groupServiceID,
      parkingFee: state.infomation?.parkingFeeToNum(),
      representative: state.representative,
      address: state.infomation?.homeAndStreet,
      phoneNumber: state.infomation?.phoneNumber,
      wardId: state.infomation?.ward,
      serviceTypeId: state.typeService,
      isAlcohol: state.isAlcohol,
      banks: state.bankRequest != null ? [state.bankRequest!] : null,
      businessAreaId: state.locationBusSellected?.id,
      streetName: state.infomation?.streetName,
      specialDish: state.infomation?.specialDish,
      storeAvatarId: state.storeAvatarId,
      storeCoverId: state.storeCoverId,
      storeFrontId: state.storeFrontId,
      storeMenuId: state.storeMenuId,
    );

    if (idStore == null) {
      final response = await execute(
        () => repository.registerStore(request),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        setRegisterStatus(EState.success);

        idStore = data?.id;

        // if (gotoNextPage == true) {
        setNextPage();
        // }
      }, failure: (error) {
        setRegisterStatus(EState.failure);
      });
      return;
    }
    if (idStore != null) {
      final response = await execute(
        () => repository.registerPatchStore(idStore!, request),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        setRegisterStatus(EState.success);
        idStore = data.id;
        // if (gotoNextPage == true) {
        setNextPage();
        // }
        // if (state.currentPage == ERegisterPageType.reviewInformation) {
        //   dialogService.showAlertDialog(
        //     title: 'Thông báo',
        //     description: 'Đăng ký cửa hàng thành công',
        //     buttonTitle: 'Đóng',
        //     onPressed: () {
        //       Get.back();
        //       Get.back();
        //     },
        //   );
        // }
      }, failure: (error) {
        setRegisterStatus(EState.failure);
      });
    }
  }

  setStoreAvatarId(String? value) {
    emit(state.copyWith(storeAvatarId: value));
  }

  setStoreCoverId(String? value) {
    emit(state.copyWith(storeCoverId: value));
  }

  setStoreFrontId(String? value) {
    emit(state.copyWith(storeFrontId: value));
  }

  setStoreMenuId(String? value) {
    emit(state.copyWith(storeMenuId: value));
  }

  setdistricts(List<DistrictModel> value) {
    emit(state.copyWith(listDistrict: value));
  }

  setWards(List<DistrictModel> value) {
    emit(state.copyWith(listWard: value));
  }
}
