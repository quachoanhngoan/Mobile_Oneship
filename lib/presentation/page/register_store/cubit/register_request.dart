import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:oneship_merchant_app/extensions/number_extention.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';

class Infomation {
  final String? nameStore;
  final String? provinces;
  final int? idProvince;

  final String? phoneNumber;
  final int? groupServiceID;
  final String? groupServiceName;
  final int? district;
  final String? districtName;
  final int? ward;
  final String? wardName;

  final String? homeAndStreet;
  final String? specialDish;
  final String? parkingFee;
  final String? streetName;
  const Infomation({
    this.nameStore,
    this.provinces,
    this.idProvince,
    this.phoneNumber,
    this.groupServiceID,
    this.groupServiceName,
    this.district,
    this.districtName,
    this.ward,
    this.wardName,
    this.homeAndStreet,
    this.specialDish,
    this.parkingFee,
    this.streetName,
  });

  Infomation copyWith({
    String? nameStore,
    String? provinces,
    int? idProvince,
    String? phoneNumber,
    int? groupServiceID,
    String? groupServiceName,
    int? district,
    String? districtName,
    int? ward,
    String? wardName,
    String? homeAndStreet,
    String? specialDish,
    String? parkingFee,
    String? streetName,
  }) {
    return Infomation(
      nameStore: nameStore ?? this.nameStore,
      provinces: provinces ?? this.provinces,
      idProvince: idProvince ?? this.idProvince,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      groupServiceID: groupServiceID ?? this.groupServiceID,
      groupServiceName: groupServiceName ?? this.groupServiceName,
      district: district ?? this.district,
      districtName: districtName ?? this.districtName,
      ward: ward ?? this.ward,
      wardName: wardName ?? this.wardName,
      homeAndStreet: homeAndStreet ?? this.homeAndStreet,
      specialDish: specialDish ?? this.specialDish,
      parkingFee: parkingFee ?? this.parkingFee,
      streetName: streetName ?? this.streetName,
    );
  }

  bool isValid() {
    return nameStore.isNotNullOrEmpty &&
        // provinces.isNotNullOrEmpty &&
        // specialDish.isNotNullOrEmpty &&
        phoneNumber.isNotNullOrEmpty &&
        !groupServiceID.isNullOrZero &&
        !district.isNullOrZero &&
        !ward.isNullOrZero &&
        homeAndStreet.isNotNullOrEmpty;
  }

  num? parkingFeeToNum() {
    if (parkingFee.isNullOrEmpty) return null;
    return num.tryParse(parkingFee ?? '0');
  }

  String getParkingFee() {
    if (parkingFee.isNullOrEmpty) return '';

    final format = NumberFormat.currency(locale: 'vi', symbol: 'đ');
    final parkingFeeF = format.format(parkingFeeToNum() ?? 0);
    return parkingFeeF;
  }

  String formatPhone() {
    if (phoneNumber.isNullOrEmpty) return '';
    return phoneNumber!.replaceAll(RegExp(r'[^0-9]'), '');
  }
}

class Representative {
  final ERepresentativeInformation? type;
  final String? name;
  final String? businessName;
  final String? phone;
  final String? otherPhone;
  final String? email;
  final String? taxCode;
  final String? address;
  // final String? personalTaxCode;
  final String? identityCard;
  final String? identityCardPlace;
  final String? identityCardDate;
  final String? identityCardFrontImageId;
  final String? identityCardBackImageId;
  final String? businessLicenseImageId;
  final String? relatedImageId;

  const Representative({
    this.type = ERepresentativeInformation.individual,
    this.name,
    this.businessName,
    this.phone,
    this.otherPhone,
    this.email,
    this.taxCode,
    this.address,
    // this.personalTaxCode,
    this.identityCard,
    this.identityCardPlace,
    this.identityCardDate,
    this.identityCardFrontImageId,
    this.identityCardBackImageId,
    this.businessLicenseImageId,
    this.relatedImageId,
  });

  Map<String, dynamic> removeNullValues() {
    return toJson()..removeWhere((key, value) => value == null);
  }

  String formatDate() {
    if (identityCardDate.isNullOrEmpty) return '';
    final date = DateTime.parse(identityCardDate!);
    final format = DateFormat('dd/MM/yyyy');
    return format.format(date);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type?.value;
    data['name'] = name;
    data['businessName'] = businessName;
    data['phone'] = phone;
    data['otherPhone'] = otherPhone;
    data['email'] = email;
    data['taxCode'] = taxCode;
    data['address'] = address;
    // data['personalTaxCode'] = personalTaxCode;
    data['identityCard'] = identityCard;
    data['identityCardPlace'] = identityCardPlace;
    data['identityCardDate'] = identityCardDate;
    data['identityCardFrontImageId'] = identityCardFrontImageId;
    data['identityCardBackImageId'] = identityCardBackImageId;
    data['businessLicenseImageId'] = businessLicenseImageId;
    data['relatedImageId'] = relatedImageId;
    return data;
  }

  Representative copyWith({
    ERepresentativeInformation? type,
    String? name,
    String? businessName,
    String? phone,
    String? otherPhone,
    String? email,
    String? taxCode,
    String? address,
    // String? personalTaxCode,
    String? identityCard,
    String? identityCardPlace,
    String? identityCardDate,
    String? identityCardFrontImageId,
    String? identityCardBackImageId,
    String? businessLicenseImageId,
    String? relatedImageId,
  }) {
    return Representative(
      type: type ?? this.type,
      name: name ?? this.name,
      businessName: businessName ?? this.businessName,
      phone: phone ?? this.phone,
      otherPhone: otherPhone ?? this.otherPhone,
      email: email ?? this.email,
      taxCode: taxCode ?? this.taxCode,
      address: address ?? this.address,
      // personalTaxCode: personalTaxCode ?? this.personalTaxCode,
      identityCard: identityCard ?? this.identityCard,
      identityCardPlace: identityCardPlace ?? this.identityCardPlace,
      identityCardDate: identityCardDate ?? this.identityCardDate,
      identityCardFrontImageId:
          identityCardFrontImageId ?? this.identityCardFrontImageId,
      identityCardBackImageId:
          identityCardBackImageId ?? this.identityCardBackImageId,
      businessLicenseImageId:
          businessLicenseImageId ?? this.businessLicenseImageId,
      relatedImageId: relatedImageId ?? this.relatedImageId,
    );
  }

  bool isValid() {
    if (type == ERepresentativeInformation.individual) {
      return name.isNotNullOrEmpty &&
          phone.isNotNullOrEmpty &&
          // email != null &&
          // taxCode != null &&
          // address != null &&
          taxCode.isNotNullOrEmpty &&
          identityCard != null &&
          identityCardPlace != null &&
          identityCardDate != null &&
          identityCardFrontImageId != null &&
          identityCardBackImageId != null;
    }
    if (type == ERepresentativeInformation.businessHousehold) {
      return name.isNotNullOrEmpty &&
          businessName.isNotNullOrEmpty &&
          phone.isNotNullOrEmpty &&
          // email != null &&
          taxCode.isNotNullOrEmpty &&
          address.isNotNullOrEmpty &&
          // personalTaxCode != null &&
          // identityCard != null &&
          // identityCardPlace != null &&
          // identityCardDate != null &&
          // identityCardFrontImageId != null &&
          // identityCardBackImageId != null &&
          businessLicenseImageId != null;
    }
    return name.isNotNullOrEmpty &&
        businessName.isNotNullOrEmpty &&
        phone.isNotNullOrEmpty &&
        // email != null &&
        taxCode.isNotNullOrEmpty &&
        address.isNotNullOrEmpty &&
        // personalTaxCode != null &&
        // identityCard != null &&
        // identityCardPlace != null &&
        // identityCardDate != null &&
        // identityCardFrontImageId != null &&
        // identityCardBackImageId != null &&
        businessLicenseImageId != null;
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'businessName': businessName,
      'phone': phone,
      'otherPhone': otherPhone,
      'email': email,
      'taxCode': taxCode,
      'address': address,
      // 'personalTaxCode': personalTaxCode,
      'identityCard': identityCard,
      'identityCardPlace': identityCardPlace,
      'identityCardDate': identityCardDate,
      'identityCardFrontImageId': identityCardFrontImageId,
      'identityCardBackImageId': identityCardBackImageId,
      'businessLicenseImageId': businessLicenseImageId,
      'relatedImageId': relatedImageId,
    };
  }

  factory Representative.fromMap(Map<String, dynamic> map) {
    return Representative(
      type: map['type'] != null
          ? ERepresentativeInformation.fromString(map['type'])
          : null,
      name: map['name'],
      businessName: map['businessName'],
      phone: map['phone'],
      otherPhone: map['otherPhone'],
      email: map['email'],
      taxCode: map['taxCode'],
      address: map['address'],
      // personalTaxCode: map['personalTaxCode'],
      identityCard: map['identityCard'],
      identityCardPlace: map['identityCardPlace'],
      identityCardDate: map['identityCardDate'],
      identityCardFrontImageId: map['identityCardFrontImageId'],
      identityCardBackImageId: map['identityCardBackImageId'],
      businessLicenseImageId: map['businessLicenseImageId'],
      relatedImageId: map['relatedImageId'],
    );
  }

  factory Representative.fromJson(String source) =>
      Representative.fromMap(json.decode(source));
}

class BankRequest {
  final int? bankId;
  final String? bankName;
  final int? bankBranchId;
  final String? bankBranchName;
  final String? bankAccountNumber;
  final String? bankAccountName;

  const BankRequest({
    this.bankId,
    this.bankBranchId,
    this.bankBranchName,
    this.bankAccountNumber,
    this.bankAccountName,
    this.bankName,
  });

  BankRequest copyWith({
    int? bankId,
    int? bankBranchId,
    String? bankAccountNumber,
    String? bankAccountName,
    String? bankName,
    String? bankBranchName,
  }) {
    return BankRequest(
      bankId: bankId ?? this.bankId,
      bankBranchId: bankBranchId ?? this.bankBranchId,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankAccountName: bankAccountName ?? this.bankAccountName,
      bankName: bankName ?? this.bankName,
      bankBranchName: bankBranchName ?? this.bankBranchName,
    );
  }

  bool isValid() {
    return bankId != null &&
        bankBranchId != null &&
        bankAccountNumber.isNotNullOrEmpty &&
        bankAccountName.isNotNullOrEmpty;
  }

  Map<String, dynamic> toMap() {
    return {
      'bankId': bankId,
      'bankName': bankName,
      'bankBranchId': bankBranchId,
      'bankBranchName': bankBranchName,
      'bankAccountNumber': bankAccountNumber,
      'bankAccountName': bankAccountName,
    };
  }

  factory BankRequest.fromMap(Map<String, dynamic> map) {
    return BankRequest(
      bankId: map['bankId'],
      bankName: map['bankName'],
      bankBranchId: map['bankBranchId'],
      bankBranchName: map['bankBranchName'],
      bankAccountNumber: map['bankAccountNumber'],
      bankAccountName: map['bankAccountName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BankRequest.fromJson(String source) =>
      BankRequest.fromMap(json.decode(source));

  Map<String, dynamic> removeNullValues() {
    return toMap()..removeWhere((key, value) => value == null);
  }
}
