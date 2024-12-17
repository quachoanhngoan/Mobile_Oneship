// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_res_domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDomain _$DataDomainFromJson(Map<String, dynamic> json) => DataDomain(
      phone: json['phone'] as String?,
      lastLogin: json['lastLogin'] as String?,
      deviceToken: json['deviceToken'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      storeId: (json['storeId'] as num?)?.toInt(),
      id: (json['id'] as num).toInt(),
      createdAt: json['createdAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      status: json['status'] as String?,
      role: json['role'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$DataDomainToJson(DataDomain instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'lastLogin': instance.lastLogin,
      'deviceToken': instance.deviceToken,
      'name': instance.name,
      'email': instance.email,
      'emailVerifiedAt': instance.emailVerifiedAt,
      'storeId': instance.storeId,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'deletedAt': instance.deletedAt,
      'updatedAt': instance.updatedAt,
      'status': instance.status,
      'role': instance.role,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
