class CancelModel {
  final int id;
  final String name;

  const CancelModel({
    required this.id,
    required this.name,
  });

  factory CancelModel.fromJson(Map<String, dynamic> json) {
    return CancelModel(
      id: json['id'],
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => 'CancelModel(id: $id, name: $name)';
}
