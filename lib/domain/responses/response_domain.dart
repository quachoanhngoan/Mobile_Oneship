import 'package:json_annotation/json_annotation.dart';

part 'response_domain.g.dart';

@JsonSerializable()
class ResponseDomain {
  final String message;
  final int statusCode;

  ResponseDomain({
    required this.message,
    required this.statusCode,
  });

  factory ResponseDomain.fromJson(Map<String, dynamic> json) =>
      _$ResponseDomainFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDomainToJson(this);

  factory ResponseDomain.fromMap(Map<String, dynamic> map) {
    return ResponseDomain(
        statusCode: map['statusCode'], message: map['message']);
  }
}
