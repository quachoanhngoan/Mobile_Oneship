import 'package:json_annotation/json_annotation.dart';

part 'register_res_domain.g.dart';

@JsonSerializable()
class DataDomain {
  final String? phone;
  final String? lastLogin;
  final String? deviceToken;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final int? storeId;
  final int id;
  final String? createdAt;
  final String? deletedAt;
  final String? updatedAt;
  final String? status;
  final String? role;
  final String? accessToken;
  final String? refreshToken;

  DataDomain({
    this.phone,
    this.lastLogin,
    this.deviceToken,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.storeId,
    required this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.status,
    this.role,
    this.accessToken,
    this.refreshToken,
  });

  factory DataDomain.fromJson(Map<String, dynamic> json) =>
      _$DataDomainFromJson(json);

  Map<String, dynamic> toJson() => _$DataDomainToJson(this);

  factory DataDomain.fromMap(Map<String, dynamic> map) {
    return DataDomain(
      phone: map['phone'],
      lastLogin: map['lastLogin'],
      deviceToken: map['deviceToken'],
      name: map['name'],
      email: map['email'],
      emailVerifiedAt: map['emailVerifiedAt'],
      storeId: map['storeId'],
      id: map['id'],
      createdAt: map['createdAt'],
      deletedAt: map['deletedAt'],
      updatedAt: map['updatedAt'],
      status: map['status'],
      role: map['role'],
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
    );
  }
}
