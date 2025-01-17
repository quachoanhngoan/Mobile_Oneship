import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_request.dart';

class StoreRequestModel {
  bool? isDraft;
  bool? isAlcohol;
  int? businessAreaId;
  int? serviceTypeId;
  String? name;
  num? parkingFee;
  String? specialDish;
  String? streetName;
  int? serviceGroupId;
  int? wardId;
  String? address;
  String? phoneNumber;
  String? storeAvatarId;
  String? storeCoverId;
  String? storeFrontId;
  bool? isPause;
  bool? isSpecialWorkingTime;
  String? storeMenuId;
  List<WorkingTime>? workingTimes;
  List<SpecialWorkingTime>? specialWorkingTimes;
  Representative? representative;
  List<BankRequest>? banks;

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
    this.isPause,
    this.isSpecialWorkingTime,
    this.specialWorkingTimes,
  });

  StoreRequestModel copyWith({
    bool? isDraft,
    bool? isAlcohol,
    int? businessAreaId,
    int? serviceTypeId,
    String? name,
    num? parkingFee,
    String? specialDish,
    String? streetName,
    int? serviceGroupId,
    int? wardId,
    String? address,
    String? phoneNumber,
    String? storeAvatarId,
    String? storeCoverId,
    String? storeFrontId,
    bool? isPause,
    bool? isSpecialWorkingTime,
    String? storeMenuId,
    List<WorkingTime>? workingTimes,
    List<SpecialWorkingTime>? specialWorkingTimes,
    Representative? representative,
    List<BankRequest>? banks,
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
      isPause: isPause ?? this.isPause,
      isSpecialWorkingTime: isSpecialWorkingTime ?? this.isSpecialWorkingTime,
      storeMenuId: storeMenuId ?? this.storeMenuId,
      workingTimes: workingTimes ?? this.workingTimes,
      specialWorkingTimes: specialWorkingTimes ?? this.specialWorkingTimes,
      representative: representative ?? this.representative,
      banks: banks ?? this.banks,
    );
  }

  factory StoreRequestModel.fromJson(Map<String, dynamic> json) {
    return StoreRequestModel(
      isDraft: json['isDraft'],
      isAlcohol: json['isAlcohol'],
      isPause: json['isPause'],
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
          ?.map((e) => BankRequest.fromJson(e))
          .toList(),
      isSpecialWorkingTime: json['isSpecialWorkingTime'],
      specialWorkingTimes: (json['specialWorkingTimes'] as List<dynamic>?)
          ?.map((e) => SpecialWorkingTime.fromJson(e))
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
      'representative': representative?.removeNullValues(),
      'banks': banks?.map((e) => e.removeNullValues()).toList(),
      'isPause': isPause,
      'isSpecialWorkingTime': isSpecialWorkingTime,
      'specialWorkingTimes':
          specialWorkingTimes?.map((e) => e.toMap()).toList(),
    };
  }

  Map<String, dynamic> removeNullValues() {
    return toJson()..removeWhere((key, value) => value == null);
  }
}

class SpecialWorkingTime {
  String? date;
  int? startTime;
  int? endTime;
  String? startTimeStr;
  String? endTimeStr;
  late TextEditingController openTimeController;
  late TextEditingController closeTimeController;
  late TextEditingController dateController;
  SpecialWorkingTime({
    this.date,
    this.startTime,
    this.endTime,
    this.startTimeStr,
    this.endTimeStr,
  }) {
    {
      //open time 360 => 6:00
      //close time 362 => 6:02
      if (startTime != null && startTime! >= 0) {
        startTimeStr = "${(startTime! / 60).floor()}:${startTime! % 60}";
        //add 0 if minute < 10
        startTimeStr = startTimeStr!.split(":")[1].length == 1
            ? "${startTimeStr!.split(":")[0]}:0${startTimeStr!.split(":")[1]}"
            : startTimeStr;
        //add 0 if hour < 10
        startTimeStr = startTimeStr!.split(":")[0].length == 1
            ? "0$startTimeStr"
            : startTimeStr;
        openTimeController = TextEditingController(text: startTimeStr);
      } else {
        openTimeController = TextEditingController();
      }
      if (endTime != null && endTime! >= 0) {
        endTimeStr = "${(endTime! / 60).floor()}:${endTime! % 60}";
        //add 0 if minute < 10
        endTimeStr = endTimeStr!.split(":")[1].length == 1
            ? "${endTimeStr!.split(":")[0]}:0${endTimeStr!.split(":")[1]}"
            : endTimeStr;
        //add 0 if hour < 10
        endTimeStr =
            endTimeStr!.split(":")[0].length == 1 ? "0$endTimeStr" : endTimeStr;

        closeTimeController = TextEditingController(text: endTimeStr);
      } else {
        closeTimeController = TextEditingController();
      }
      if (date != null && date!.isNotEmpty) {
        final dateStr = DateFormat('dd/MM/yyyy').format(DateTime.parse(date!));
        dateController = TextEditingController(text: dateStr);
      } else {
        dateController = TextEditingController();
      }
    }
  }

  SpecialWorkingTime copyWith({
    String? date,
    int? startTime,
    int? endTime,
    String? startTimeStr,
    String? endTimeStr,
  }) {
    return SpecialWorkingTime(
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startTimeStr: startTimeStr ?? this.startTimeStr,
      endTimeStr: endTimeStr ?? this.endTimeStr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory SpecialWorkingTime.fromMap(Map<String, dynamic> map) {
    return SpecialWorkingTime(
      date: map['date'],
      startTime: map['startTime']?.toInt(),
      endTime: map['endTime']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecialWorkingTime.fromJson(String source) =>
      SpecialWorkingTime.fromMap(json.decode(source));
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

// }

// class BankRegister {
//   String? bankId;
//   String? bankBranchId;
//   String? bankAccountNumber;
//   String? bankAccountName;

//   BankRegister({
//     this.bankId,
//     this.bankBranchId,
//     this.bankAccountNumber,
//     this.bankAccountName,
//   });

//   BankRegister copyWith({
//     String? bankId,
//     String? bankBranchId,
//     String? bankAccountNumber,
//     String? bankAccountName,
//   }) {
//     return BankRegister(
//       bankId: bankId ?? this.bankId,
//       bankBranchId: bankBranchId ?? this.bankBranchId,
//       bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
//       bankAccountName: bankAccountName ?? this.bankAccountName,
//     );
//   }

//   factory BankRegister.fromJson(Map<String, dynamic> json) {
//     return BankRegister(
//       bankId: json['bankId'],
//       bankBranchId: json['bankBranchId'],
//       bankAccountNumber: json['bankAccountNumber'],
//       bankAccountName: json['bankAccountName'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'bankId': bankId,
//       'bankBranchId': bankBranchId,
//       'bankAccountNumber': bankAccountNumber,
//       'bankAccountName': bankAccountName,
//     };
//   }
// }
// //
}
