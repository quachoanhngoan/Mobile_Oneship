import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_request.dart';

class StoreRequestModel {
  bool? isDraft;
  bool? isAlcohol;
  int? businessAreaId;
  int? serviceTypeId;
  String? name;
  int? parkingFee;
  String? specialDish;
  String? streetName;
  int? serviceGroupId;
  int? wardId;
  String? address;
  String? phoneNumber;
  String? storeAvatarId;
  String? storeCoverId;
  String? storeFrontId;
  String? storeMenuId;
  List<WorkingTime>? workingTimes;
  Representative? representative;
  List<BankRegister>? banks;

  StoreRequestModel({
    this.isDraft,
    this.isAlcohol,
    this.businessAreaId,
    this.serviceTypeId,
    this.name,
    this.parkingFee,
    this.specialDish,
    this.streetName,
    this.serviceGroupId,
    this.wardId,
    this.address,
    this.phoneNumber,
    this.storeAvatarId,
    this.storeCoverId,
    this.storeFrontId,
    this.storeMenuId,
    this.workingTimes,
    this.representative,
    this.banks,
  });

  StoreRequestModel copyWith({
    bool? isDraft,
    bool? isAlcohol,
    int? businessAreaId,
    int? serviceTypeId,
    String? name,
    int? parkingFee,
    String? specialDish,
    String? streetName,
    int? serviceGroupId,
    int? wardId,
    String? address,
    String? phoneNumber,
    String? storeAvatarId,
    String? storeCoverId,
    String? storeFrontId,
    String? storeMenuId,
    List<WorkingTime>? workingTimes,
    Representative? representative,
    List<BankRegister>? banks,
  }) {
    return StoreRequestModel(
      isDraft: isDraft ?? this.isDraft,
      isAlcohol: isAlcohol ?? this.isAlcohol,
      businessAreaId: businessAreaId ?? this.businessAreaId,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      name: name ?? this.name,
      parkingFee: parkingFee ?? this.parkingFee,
      specialDish: specialDish ?? this.specialDish,
      streetName: streetName ?? this.streetName,
      serviceGroupId: serviceGroupId ?? this.serviceGroupId,
      wardId: wardId ?? this.wardId,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      storeAvatarId: storeAvatarId ?? this.storeAvatarId,
      storeCoverId: storeCoverId ?? this.storeCoverId,
      storeFrontId: storeFrontId ?? this.storeFrontId,
      storeMenuId: storeMenuId ?? this.storeMenuId,
      workingTimes: workingTimes ?? this.workingTimes,
      representative: representative ?? this.representative,
      banks: banks ?? this.banks,
    );
  }

  factory StoreRequestModel.fromJson(Map<String, dynamic> json) {
    return StoreRequestModel(
      isDraft: json['isDraft'],
      isAlcohol: json['isAlcohol'],
      businessAreaId: json['businessAreaId'],
      serviceTypeId: json['serviceTypeId'],
      name: json['name'],
      parkingFee: json['parkingFee'],
      specialDish: json['specialDish'],
      streetName: json['streetName'],
      serviceGroupId: json['serviceGroupId'],
      wardId: json['wardId'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      storeAvatarId: json['storeAvatarId'],
      storeCoverId: json['storeCoverId'],
      storeFrontId: json['storeFrontId'],
      storeMenuId: json['storeMenuId'],
      workingTimes: (json['workingTimes'] as List<dynamic>?)
          ?.map((e) => WorkingTime.fromJson(e))
          .toList(),
      representative: json['representative'] != null
          ? Representative.fromJson(json['representative'])
          : null,
      banks: (json['banks'] as List<dynamic>?)
          ?.map((e) => BankRegister.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDraft': isDraft,
      'isAlcohol': isAlcohol,
      'businessAreaId': businessAreaId,
      'serviceTypeId': serviceTypeId,
      'name': name,
      'parkingFee': parkingFee,
      'specialDish': specialDish,
      'streetName': streetName,
      'serviceGroupId': serviceGroupId,
      'wardId': wardId,
      'address': address,
      'phoneNumber': phoneNumber,
      'storeAvatarId': storeAvatarId,
      'storeCoverId': storeCoverId,
      'storeFrontId': storeFrontId,
      'storeMenuId': storeMenuId,
      'workingTimes': workingTimes?.map((e) => e.toJson()).toList(),
      'representative': representative?.toJson(),
      'banks': banks?.map((e) => e.toJson()).toList(),
    };
  }

  Map<String, dynamic> removeNullValues(Map<String, dynamic> json) {
  return json..removeWhere((key, value) => value == null);
}
}

class WorkingTime {
  int? dayOfWeek;
  int? openTime;
  int? closeTime;

  WorkingTime({this.dayOfWeek, this.openTime, this.closeTime});

  WorkingTime copyWith({
    int? dayOfWeek,
    int? openTime,
    int? closeTime,
  }) {
    return WorkingTime(
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }

  factory WorkingTime.fromJson(Map<String, dynamic> json) {
    return WorkingTime(
      dayOfWeek: json['dayOfWeek'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }
}

class BankRegister {
  String? bankId;
  String? bankBranchId;
  String? bankAccountNumber;
  String? bankAccountName;

  BankRegister({
    this.bankId,
    this.bankBranchId,
    this.bankAccountNumber,
    this.bankAccountName,
  });

  BankRegister copyWith({
    String? bankId,
    String? bankBranchId,
    String? bankAccountNumber,
    String? bankAccountName,
  }) {
    return BankRegister(
      bankId: bankId ?? this.bankId,
      bankBranchId: bankBranchId ?? this.bankBranchId,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankAccountName: bankAccountName ?? this.bankAccountName,
    );
  }

  factory BankRegister.fromJson(Map<String, dynamic> json) {
    return BankRegister(
      bankId: json['bankId'],
      bankBranchId: json['bankBranchId'],
      bankAccountNumber: json['bankAccountNumber'],
      bankAccountName: json['bankAccountName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bankId': bankId,
      'bankBranchId': bankBranchId,
      'bankAccountNumber': bankAccountNumber,
      'bankAccountName': bankAccountName,
    };
  }
}
