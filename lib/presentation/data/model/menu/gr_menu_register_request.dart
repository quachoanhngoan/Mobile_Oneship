class GrMenuRegisterRequest {
  final String name;
  final int parentId;

  GrMenuRegisterRequest({
    required this.name,
    required this.parentId,
  });

  factory GrMenuRegisterRequest.fromJson(Map<String, dynamic> json) {
    return GrMenuRegisterRequest(
      name: json['name'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'parentId': parentId,
    };
  }
}
