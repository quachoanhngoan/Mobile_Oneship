class AddressStoreM {
  int? id;
  int? storeId;
  String? address;
  String? building;
  String? gate;
  int? lat;
  int? lng;
  String? type;
  String? note;
  Store? store;

  AddressStoreM(
      {this.id,
      this.storeId,
      this.address,
      this.building,
      this.gate,
      this.lat,
      this.lng,
      this.type,
      this.note,
      this.store});

  AddressStoreM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['storeId'];
    address = json['address'];
    building = json['building'];
    gate = json['gate'];
    lat = json['lat'];
    lng = json['lng'];
    type = json['type'];
    note = json['note'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['building'] = building;

    data['gate'] = gate;
    data['lat'] = lat;
    data['lng'] = lng;
    data['type'] = type;
    data['note'] = note;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }

  String? getNameAddresss() {
    if (type == "receive") {
      return "Nhận hàng";
    }
    return "Gửi hàng";
  }
}

class Store {
  String? name;
  String? phoneNumber;

  Store({this.name, this.phoneNumber});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
