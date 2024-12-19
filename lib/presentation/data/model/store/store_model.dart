mixin EStoreApprovalStatus {
  static const String draft = 'draft';
  static const String pending = 'pending';
  static const String approved = 'approved';
  static const String rejected = 'rejected';
}
mixin EStoreStatus {
  static const String active = 'active';
  static const String inactive = 'inactive';
}

class StoresResponse {
  List<StoreModel>? items;
  int? total;

  StoresResponse({this.items, this.total});

  StoresResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <StoreModel>[];
      json['items'].forEach((v) {
        items!.add(StoreModel.fromJson(v));
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
  String? name;
  String? address;
  String? status;
  String? approvalStatus;
  String? storeAvatarId;
  String? rejectReason;
  Province? province;
  District? district;
  District? ward;

  StoreModel(
      {this.id,
      this.createdAt,
      this.name,
      this.address,
      this.status,
      this.approvalStatus,
      this.storeAvatarId,
      this.province,
      this.district,
      this.rejectReason,
      this.ward});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    name = json['name'];
    address = json['address'];
    status = json['status'];
    approvalStatus = json['approvalStatus'];
    storeAvatarId = json['storeAvatarId'];
    rejectReason = json['rejectReason'];
    province =
        json['province'] != null ? Province.fromJson(json['province']) : null;
    district =
        json['district'] != null ? District.fromJson(json['district']) : null;
    ward = json['ward'] != null ? District.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['address'] = address;
    data['status'] = status;
    data['rejectReason'] = rejectReason;
    data['approvalStatus'] = approvalStatus;
    data['storeAvatarId'] = storeAvatarId;
    if (province != null) {
      data['province'] = province!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (ward != null) {
      data['ward'] = ward!.toJson();
    }
    return data;
  }

  String getButtonType() {
    if (approvalStatus == EStoreApprovalStatus.pending) {
      return EStoreButtonType.pendingAndViewButton;
    } else if (approvalStatus == EStoreApprovalStatus.rejected) {
      return EStoreButtonType.rejectAndContinueButton;
    } else if (approvalStatus == EStoreApprovalStatus.draft) {
      return EStoreButtonType.continueButton;
    }
    return EStoreButtonType.none;
  }

  String getButtonText() {
    if (approvalStatus == EStoreApprovalStatus.pending) {
      return 'Xem chi tiết';
    } else if (approvalStatus == EStoreApprovalStatus.rejected) {
      return 'Chỉnh sửa đăng ký';
    } else if (approvalStatus == EStoreApprovalStatus.draft) {
      return 'Tiếp tục đăng ký';
    } else {
      return 'Tiếp tục';
    }
  }

  String getAddress() {
    return '${address ?? ''}, ${ward?.name ?? ''}, ${district?.name ?? ''}, ${province?.name ?? ''}';
  }
}

class Province {
  int? id;
  String? name;
  String? shortName;

  Province({this.id, this.name, this.shortName});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shortName'] = shortName;
    return data;
  }
}

class District {
  int? id;
  String? name;

  District({this.id, this.name});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

mixin EStoreButtonType {
  static const String pendingAndViewButton = 'pendingAndViewButton';
  static const String continueButton = 'continueButton';
  static const String rejectAndContinueButton = 'rejectAndContinueButton';
  static const String none = 'none';
}
