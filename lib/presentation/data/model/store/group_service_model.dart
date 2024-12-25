class GroupServiceModel {
  int? id;
  String? createdAt;
  String? deletedAt;
  String? updatedAt;
  String? code;
  String? name;
  String? description;
  String? status;

  GroupServiceModel({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.code,
    this.name,
    this.description,
    this.status,
  });

  GroupServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
    updatedAt = json['updatedAt'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
      'code': code,
      'name': name,
      'description': description,
      'status': status,
    };
  }
}
