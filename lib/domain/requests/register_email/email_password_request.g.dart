// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordEmailRequest _$PasswordEmailRequestFromJson(
        Map<String, dynamic> json) =>
    PasswordEmailRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$PasswordEmailRequestToJson(
        PasswordEmailRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'otp': instance.otp,
    };
