import 'package:json_annotation/json_annotation.dart';

part 'phone_register_request.g.dart';

@JsonSerializable()
class RegisterPhoneRequest {
  final String? idToken;
  final String password;
  final String? deviceToken;

  RegisterPhoneRequest({
    this.idToken,
    required this.password,
    this.deviceToken,
  });

  factory RegisterPhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterPhoneRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterPhoneRequestToJson(this);

  RegisterPhoneRequest copyWith({
    String? idToken,
    String? password,
    String? deviceToken,
  }) {
    return RegisterPhoneRequest(
      idToken: idToken ?? this.idToken,
      password: password ?? this.password,
      deviceToken: deviceToken ?? this.deviceToken,
    );
  }
}
