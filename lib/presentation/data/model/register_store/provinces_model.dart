class ProvinceResponse {
  List<ProvinceModel>? provinces;

  ProvinceResponse({this.provinces});

  ProvinceResponse.fromJson(List<dynamic> jsonList) {
    provinces = jsonList.map((json) => ProvinceModel.fromJson(json)).toList();
  }

  List<Map<String, dynamic>> toJson() {
    return provinces?.map((province) => province.toJson()).toList() ?? [];
  }
}

class ProvinceModel {
  int? id;
  String? name;
  String? shortName;

  ProvinceModel({this.id, this.name, this.shortName});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
    };
  }
}
