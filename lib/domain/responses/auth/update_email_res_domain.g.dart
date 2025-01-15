// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_email_res_domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEmailResDomain _$UpdateEmailResDomainFromJson(
        Map<String, dynamic> json) =>
    UpdateEmailResDomain(
      id: (json['id'] as num).toInt(),
      createdAt: json['createdAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      name: json['name'] as String?,
      avatarId: (json['avatarId'] as String?),
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      storeId: (json['storeId'] as num?)?.toInt(),
      deviceToken: json['deviceToken'] as String?,
      lastLogin: json['lastLogin'] as String?,
      status: json['status'] as String?,
      role: json['role'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UpdateEmailResDomainToJson(
        UpdateEmailResDomain instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'deletedAt': instance.deletedAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'avatarId': instance.avatarId,
      'phone': instance.phone,
      'email': instance.email,
      'emailVerifiedAt': instance.emailVerifiedAt,
      'storeId': instance.storeId,
      'deviceToken': instance.deviceToken,
      'lastLogin': instance.lastLogin,
      'status': instance.status,
      'role': instance.role,
      'password': instance.password,
    };
