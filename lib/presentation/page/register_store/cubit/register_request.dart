class Representative {
  String? type;
  String? name;
  String? businessName;
  String? phone;
  String? otherPhone;
  String? email;
  String? taxCode;
  String? address;
  String? personalTaxCode;
  String? identityCard;
  String? identityCardPlace;
  String? identityCardDate;
  String? identityCardFrontImageId;
  String? identityCardBackImageId;
  String? businessLicenseImageId;
  String? relatedImageId;

  Representative({
    this.type,
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
    String? type,
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

  factory Representative.fromJson(Map<String, dynamic> json) {
    return Representative(
      type: json['type'],
      name: json['name'],
      businessName: json['businessName'],
      phone: json['phone'],
      otherPhone: json['otherPhone'],
      email: json['email'],
      taxCode: json['taxCode'],
      address: json['address'],
      personalTaxCode: json['personalTaxCode'],
      identityCard: json['identityCard'],
      identityCardPlace: json['identityCardPlace'],
      identityCardDate: json['identityCardDate'],
      identityCardFrontImageId: json['identityCardFrontImageId'],
      identityCardBackImageId: json['identityCardBackImageId'],
      businessLicenseImageId: json['businessLicenseImageId'],
      relatedImageId: json['relatedImageId'],
    );
  }
}
