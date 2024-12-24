import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';

class Representative {
  final ERepresentativeInformation? type;
  final String? name;
  final String? businessName;
  final String? phone;
  final String? otherPhone;
  final String? email;
  final String? taxCode;
  final String? address;
  final String? personalTaxCode;
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
    this.personalTaxCode,
    this.identityCard,
    this.identityCardPlace,
    this.identityCardDate,
    this.identityCardFrontImageId,
    this.identityCardBackImageId,
    this.businessLicenseImageId,
    this.relatedImageId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['businessName'] = businessName;
    data['phone'] = phone;
    data['otherPhone'] = otherPhone;
    data['email'] = email;
    data['taxCode'] = taxCode;
    data['address'] = address;
    data['personalTaxCode'] = personalTaxCode;
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
    String? personalTaxCode,
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
      personalTaxCode: personalTaxCode ?? this.personalTaxCode,
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
      return name != null &&
          phone != null &&
          // email != null &&
          // taxCode != null &&
          // address != null &&
          personalTaxCode != null &&
          identityCard != null &&
          identityCardPlace != null &&
          identityCardDate != null &&
          identityCardFrontImageId != null &&
          identityCardBackImageId != null;
    }
    if (type == ERepresentativeInformation.businessHousehold) {
      return name != null &&
          businessName != null &&
          phone != null &&
          // email != null &&
          taxCode != null &&
          address != null &&
          // personalTaxCode != null &&
          // identityCard != null &&
          // identityCardPlace != null &&
          // identityCardDate != null &&
          // identityCardFrontImageId != null &&
          // identityCardBackImageId != null &&
          businessLicenseImageId != null;
    }
    return name != null &&
        businessName != null &&
        phone != null &&
        // email != null &&
        taxCode != null &&
        address != null &&
        // personalTaxCode != null &&
        // identityCard != null &&
        // identityCardPlace != null &&
        // identityCardDate != null &&
        // identityCardFrontImageId != null &&
        // identityCardBackImageId != null &&
        businessLicenseImageId != null;
  }
}

class BankRequest {
  final String? bankId;
  final String? bankName;
  final String? bankBranchId;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankId'] = bankId;
    data['bankBranchId'] = bankBranchId;
    data['bankAccountNumber'] = bankAccountNumber;
    data['bankAccountName'] = bankAccountName;
    return data;
  }

  BankRequest copyWith({
    String? bankId,
    String? bankBranchId,
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
}
