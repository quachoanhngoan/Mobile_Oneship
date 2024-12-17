// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterPhoneRequest _$RegisterPhoneRequestFromJson(
        Map<String, dynamic> json) =>
    RegisterPhoneRequest(
      idToken: json['idToken'] as String?,
      password: json['password'] as String,
      deviceToken: json['deviceToken'] as String?,
    );

Map<String, dynamic> _$RegisterPhoneRequestToJson(
        RegisterPhoneRequest instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'password': instance.password,
      'deviceToken': instance.deviceToken,
    };
