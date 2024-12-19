class StoresResponse {
  List<StoreModel>? items;
  int? total;

  StoresResponse({this.items, this.total});

  StoresResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <StoreModel>[];
      json['items'].forEach((v) {
        items!.add(new StoreModel.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class StoreModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? merchantId;
  String? storeCode;
  String? name;
  // Null? specialDish;
  String? streetName;
  String? phoneNumber;
  int? serviceTypeId;
  bool? isAlcohol;
  int? serviceGroupId;
  int? businessAreaId;
  int? provinceId;
  int? districtId;
  bool? isPause;
  bool? isSpecialWorkingTime;
  int? wardId;
  String? address;
  String? status;
  String? approvalStatus;
  String? approvedAt;
  String? storeAvatarId;
  String? storeCoverId;
  String? storeFrontId;
  String? storeMenuId;
  num? parkingFee;
  String? rejectReason;

  StoreModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.merchantId,
      this.storeCode,
      this.name,
      this.streetName,
      this.phoneNumber,
      this.serviceTypeId,
      this.isAlcohol,
      this.serviceGroupId,
      this.businessAreaId,
      this.provinceId,
      this.districtId,
      this.isPause,
      this.isSpecialWorkingTime,
      this.wardId,
      this.address,
      this.status,
      this.approvalStatus,
      this.approvedAt,
      this.storeAvatarId,
      this.storeCoverId,
      this.storeFrontId,
      this.storeMenuId,
      this.parkingFee,
      this.rejectReason});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    merchantId = json['merchantId'];
    storeCode = json['storeCode'];
    name = json['name'];
    streetName = json['streetName'];
    phoneNumber = json['phoneNumber'];
    serviceTypeId = json['serviceTypeId'];
    isAlcohol = json['isAlcohol'];
    serviceGroupId = json['serviceGroupId'];
    businessAreaId = json['businessAreaId'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    isPause = json['isPause'];
    isSpecialWorkingTime = json['isSpecialWorkingTime'];
    wardId = json['wardId'];
    address = json['address'];
    status = json['status'];
    approvalStatus = json['approvalStatus'];
    approvedAt = json['approvedAt'];
    storeAvatarId = json['storeAvatarId'];
    storeCoverId = json['storeCoverId'];
    storeFrontId = json['storeFrontId'];
    storeMenuId = json['storeMenuId'];
    parkingFee = json['parkingFee'];
    rejectReason = json['rejectReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['merchantId'] = merchantId;
    data['storeCode'] = storeCode;
    data['name'] = name;
    data['streetName'] = streetName;
    data['phoneNumber'] = phoneNumber;
    data['serviceTypeId'] = serviceTypeId;
    data['isAlcohol'] = isAlcohol;
    data['serviceGroupId'] = serviceGroupId;
    data['businessAreaId'] = businessAreaId;
    data['provinceId'] = provinceId;
    data['districtId'] = districtId;
    data['isPause'] = isPause;
    data['isSpecialWorkingTime'] = isSpecialWorkingTime;
    data['wardId'] = wardId;
    data['address'] = address;
    data['status'] = status;
    data['approvalStatus'] = approvalStatus;
    data['approvedAt'] = approvedAt;
    data['storeAvatarId'] = storeAvatarId;
    data['storeCoverId'] = storeCoverId;
    data['storeFrontId'] = storeFrontId;
    data['storeMenuId'] = storeMenuId;
    data['parkingFee'] = parkingFee;
    data['rejectReason'] = rejectReason;
    return data;
  }
}
