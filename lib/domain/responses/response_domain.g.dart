// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDomain _$ResponseDomainFromJson(Map<String, dynamic> json) =>
    ResponseDomain(
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$ResponseDomainToJson(ResponseDomain instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
    };
