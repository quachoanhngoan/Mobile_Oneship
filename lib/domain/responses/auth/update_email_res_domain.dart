import 'package:json_annotation/json_annotation.dart';

part 'update_email_res_domain.g.dart';

@JsonSerializable()
class UpdateEmailResDomain {
  final int id;
  final String? createdAt;
  final String? deletedAt;
  final String? updatedAt;
  final String? name;
  final String? avatarId;
  final String? phone;
  final String? email;
  final String? emailVerifiedAt;
  final int? storeId;
  final String? deviceToken;
  final String? lastLogin;
  final String? status;
  final String? role;
  final String? password;

  UpdateEmailResDomain({
    required this.id,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
    this.name,
    this.avatarId,
    required this.phone,
    required this.email,
    this.emailVerifiedAt,
    this.storeId,
    required this.deviceToken,
    required this.lastLogin,
    required this.status,
    required this.role,
    this.password,
  });

  factory UpdateEmailResDomain.fromJson(Map<String, dynamic> json) {
    return UpdateEmailResDomain(
      id: json['id'] != null ? json['id'] as int : 0,
      createdAt: json['createdAt'] as String? ?? '',
      deletedAt: json['deletedAt'] as String?,
      updatedAt: json['updatedAt'] as String? ?? '',
      name: json['name'] as String?,
      avatarId: json['avatarId'] as String?,
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      storeId: json['storeId'] as int?,
      deviceToken: json['deviceToken'] as String? ?? '',
      lastLogin: json['lastLogin'] as String? ?? '',
      status: json['status'] as String? ?? '',
      role: json['role'] as String? ?? '',
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
      'name': name,
      'avatarId': avatarId,
      'phone': phone,
      'email': email,
      'emailVerifiedAt': emailVerifiedAt,
      'storeId': storeId,
      'deviceToken': deviceToken,
      'lastLogin': lastLogin,
      'status': status,
      'role': role,
      'password': password,
    };
  }
}
