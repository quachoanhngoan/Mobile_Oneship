class BankM {
  int? id;
  String? name;
  String? code;
  String? sortName;
  String? swiftCode;
  String? logoUrl;

  BankM(
      {this.id,
      this.name,
      this.code,
      this.sortName,
      this.swiftCode,
      this.logoUrl});

  BankM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    sortName = json['sortName'];
    swiftCode = json['swiftCode'];
    logoUrl = json['logoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['sortName'] = sortName;
    data['swiftCode'] = swiftCode;
    data['logoUrl'] = logoUrl;
    return data;
  }
}

class BranchBankM {
  int? id;
  String? name;
  int? bankId;

  BranchBankM({this.id, this.name, this.bankId});

  BranchBankM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bankId = json['bankId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['bankId'] = bankId;
    return data;
  }
}
