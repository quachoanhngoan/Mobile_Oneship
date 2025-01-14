import 'dart:convert';

import 'package:oneship_merchant_app/presentation/data/model/register_store/district_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/group_service_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/provinces_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/store_request_model.dart';

class CreateStoreResponse {
  final int? merchantId;
  final bool? isDraft;
  final bool? isAlcohol;
  final int? businessAreaId;
  final int? serviceTypeId;
  final Representative? representative;
  final List<Bank>? banks;
  final String? approvalStatus;
  final String? storeCode;
  final String? name;
  final String? specialDish;
  final String? streetName;
  final String? phoneNumber;
  final int? serviceGroupId;
  final int? provinceId;
  final int? districtId;
  final int? wardId;
  final String? address;
  // final String? approvedById;
  // final String? approvedAt;
  // final String? createdById;
  final String? storeAvatarId;
  final String? storeCoverId;
  final String? storeFrontId;
  final String? storeMenuId;
  final num? parkingFee;
  final String? rejectReason;
  final int? id;
  final bool? isPause;
  final bool? isSpecialWorkingTime;
  final String? status;

  final DistrictModel? district;
  final ProvinceModel? province;
  final DistrictModel? ward;
  final ProvinceModel? businessArea;
  final GroupServiceModel? serviceType;
  final List<WorkingTime> workingTimes;
  CreateStoreResponse({
    this.merchantId,
    this.isDraft,
    this.isAlcohol,
    this.businessAreaId,
    this.serviceTypeId,
    this.representative,
    this.banks,
    this.approvalStatus,
    this.storeCode,
    this.name,
    this.specialDish,
    this.streetName,
    this.phoneNumber,
    this.serviceGroupId,
    this.provinceId,
    this.districtId,
    this.wardId,
    this.address,
    // this.approvedById,
    // this.approvedAt,
    // this.createdById,
    this.storeAvatarId,
    this.storeCoverId,
    this.storeFrontId,
    this.storeMenuId,
    this.parkingFee,
    this.rejectReason,
    this.id,
    this.isPause,
    this.isSpecialWorkingTime,
    this.status,
    this.district,
    this.province,
    this.ward,
    this.businessArea,
    this.serviceType,
    this.workingTimes = const [],
  });

  factory CreateStoreResponse.fromRawJson(String str) =>
      CreateStoreResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateStoreResponse.fromJson(Map<String, dynamic> json) =>
      CreateStoreResponse(
          merchantId: json["merchantId"],
          isDraft: json["isDraft"],
          isAlcohol: json["isAlcohol"],
          businessAreaId: json["businessAreaId"],
          serviceTypeId: json["serviceTypeId"],
          representative: json["representative"] == null
              ? null
              : Representative.fromJson(json["representative"]),
          banks: json["banks"] == null
              ? []
              : List<Bank>.from(json["banks"]!.map((x) => Bank.fromJson(x))),
          approvalStatus: json["approvalStatus"],
          storeCode: json["storeCode"],
          name: json["name"],
          specialDish: json["specialDish"],
          streetName: json["streetName"],
          phoneNumber: json["phoneNumber"],
          serviceGroupId: json["serviceGroupId"],
          provinceId: json["provinceId"],
          districtId: json["districtId"],
          wardId: json["wardId"],
          address: json["address"],
          // approvedById: json["approvedById"],
          // approvedAt: json["approvedAt"],
          // createdById: json["createdById"],
          storeAvatarId: json["storeAvatarId"],
          storeCoverId: json["storeCoverId"],
          storeFrontId: json["storeFrontId"],
          storeMenuId: json["storeMenuId"],
          parkingFee: json["parkingFee"],
          rejectReason: json["rejectReason"],
          id: json["id"],
          isPause: json["isPause"],
          isSpecialWorkingTime: json["isSpecialWorkingTime"],
          status: json["status"],
          district: json["district"] == null
              ? null
              : DistrictModel.fromJson(json["district"]),
          province: json["province"] == null
              ? null
              : ProvinceModel.fromJson(json["province"]),
          ward: json["ward"] == null
              ? null
              : DistrictModel.fromJson(json["ward"]),
          businessArea: json["businessArea"] == null
              ? null
              : ProvinceModel.fromJson(json["businessArea"]),
          workingTimes: json["workingTimes"] == null
              ? []
              : List<WorkingTime>.from(
                  json["workingTimes"].map((x) => WorkingTime.fromJson(x))),
          serviceType: json["serviceType"] == null
              ? null
              : GroupServiceModel.fromJson(json["serviceType"]));

  Map<String, dynamic> toJson() => {
        "merchantId": merchantId,
        "isDraft": isDraft,
        "isAlcohol": isAlcohol,
        "businessAreaId": businessAreaId,
        "serviceTypeId": serviceTypeId,
        "representative": representative?.toJson(),
        "banks": banks == null
            ? []
            : List<dynamic>.from(banks!.map((x) => x.toJson())),
        "approvalStatus": approvalStatus,
        "storeCode": storeCode,
        "name": name,
        "specialDish": specialDish,
        "streetName": streetName,
        "phoneNumber": phoneNumber,
        "serviceGroupId": serviceGroupId,
        "provinceId": provinceId,
        "districtId": districtId,
        "wardId": wardId,
        "address": address,
        // "approvedById": approvedById,
        // "approvedAt": approvedAt,
        // "createdById": createdById,
        "storeAvatarId": storeAvatarId,
        "storeCoverId": storeCoverId,
        "storeFrontId": storeFrontId,
        "storeMenuId": storeMenuId,
        "parkingFee": parkingFee,
        "rejectReason": rejectReason,
        "id": id,
        "isPause": isPause,
        "isSpecialWorkingTime": isSpecialWorkingTime,
        "status": status,
      };
}

class Bank {
  final int? storeId;
  final int? bankId;
  final int? bankBranchId;
  final String? bankAccountNumber;
  final String? bankAccountName;
  final int? id;

  Bank({
    this.storeId,
    this.bankId,
    this.bankBranchId,
    this.bankAccountNumber,
    this.bankAccountName,
    this.id,
  });

  factory Bank.fromRawJson(String str) => Bank.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        storeId: json["storeId"],
        bankId: json["bankId"],
        bankBranchId: json["bankBranchId"],
        bankAccountNumber: json["bankAccountNumber"],
        bankAccountName: json["bankAccountName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "storeId": storeId,
        "bankId": bankId,
        "bankBranchId": bankBranchId,
        "bankAccountNumber": bankAccountNumber,
        "bankAccountName": bankAccountName,
        "id": id,
      };
}

class Representative {
  final String? type;
  final int? storeId;
  final dynamic name;
  final dynamic businessName;
  final dynamic phone;
  final dynamic orderPhone;
  final dynamic email;
  final dynamic address;
  final dynamic taxCode;
  final dynamic personalTaxCode;
  final dynamic identityCard;
  final dynamic identityCardDate;
  final dynamic identityCardPlace;
  final dynamic identityCardFrontImageId;
  final dynamic identityCardBackImageId;
  final dynamic businessLicenseImageId;
  final dynamic taxLicenseImageId;
  final dynamic relatedImageId;
  final int? id;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final DateTime? updatedAt;

  Representative({
    this.type,
    this.storeId,
    this.name,
    this.businessName,
    this.phone,
    this.orderPhone,
    this.email,
    this.address,
    this.taxCode,
    this.personalTaxCode,
    this.identityCard,
    this.identityCardDate,
    this.identityCardPlace,
    this.identityCardFrontImageId,
    this.identityCardBackImageId,
    this.businessLicenseImageId,
    this.taxLicenseImageId,
    this.relatedImageId,
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
  });

  factory Representative.fromRawJson(String str) =>
      Representative.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Representative.fromJson(Map<String, dynamic> json) => Representative(
        type: json["type"],
        storeId: json["storeId"],
        name: json["name"],
        businessName: json["businessName"],
        phone: json["phone"],
        orderPhone: json["orderPhone"],
        email: json["email"],
        address: json["address"],
        taxCode: json["taxCode"],
        personalTaxCode: json["personalTaxCode"],
        identityCard: json["identityCard"],
        identityCardDate: json["identityCardDate"],
        identityCardPlace: json["identityCardPlace"],
        identityCardFrontImageId: json["identityCardFrontImageId"],
        identityCardBackImageId: json["identityCardBackImageId"],
        businessLicenseImageId: json["businessLicenseImageId"],
        taxLicenseImageId: json["taxLicenseImageId"],
        relatedImageId: json["relatedImageId"],
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "storeId": storeId,
        "name": name,
        "businessName": businessName,
        "phone": phone,
        "orderPhone": orderPhone,
        "email": email,
        "address": address,
        "taxCode": taxCode,
        "personalTaxCode": personalTaxCode,
        "identityCard": identityCard,
        "identityCardDate": identityCardDate,
        "identityCardPlace": identityCardPlace,
        "identityCardFrontImageId": identityCardFrontImageId,
        "identityCardBackImageId": identityCardBackImageId,
        "businessLicenseImageId": businessLicenseImageId,
        "taxLicenseImageId": taxLicenseImageId,
        "relatedImageId": relatedImageId,
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
