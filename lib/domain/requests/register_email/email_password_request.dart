import 'package:json_annotation/json_annotation.dart';

part 'email_password_request.g.dart';

@JsonSerializable()
class PasswordEmailRequest {
  final String email;
  final String password;
  final String? otp;

  PasswordEmailRequest({
    required this.email,
    required this.password,
    this.otp,
  });

  // Chuyển đổi giữa JSON và Object
  factory PasswordEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$PasswordEmailRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordEmailRequestToJson(this);
}
