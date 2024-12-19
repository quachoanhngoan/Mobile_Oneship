// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpRequest _$OtpRequestFromJson(Map<String, dynamic> json) => OtpRequest(
      otp: json['otp'] as String?,
      email: json['email'] as String,
    );

Map<String, dynamic> _$OtpRequestToJson(OtpRequest instance) =>
    <String, dynamic>{
      'otp': instance.otp,
      'email': instance.email,
    };
