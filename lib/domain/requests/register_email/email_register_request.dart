import 'package:json_annotation/json_annotation.dart';

part 'email_register_request.g.dart';

@JsonSerializable()
class RegisterEmailRequest {
  final String email;

  RegisterEmailRequest({required this.email});

  factory RegisterEmailRequest.fromJson(Map<String, dynamic> json) => _$RegisterEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterEmailRequestToJson(this);
}