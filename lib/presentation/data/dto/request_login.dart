import 'dart:convert';

class RequestLoginDto {
  final String? username;
  final String? password;
  final String? deviceToken;

  RequestLoginDto({
    this.username,
    this.password,
    this.deviceToken,
  });

  factory RequestLoginDto.fromRawJson(String str) =>
      RequestLoginDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestLoginDto.fromJson(Map<String, dynamic> json) =>
      RequestLoginDto(
        username: json["username"],
        password: json["password"],
        deviceToken: json["deviceToken"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "deviceToken": deviceToken,
      };
}

class RequestLoginSms {
  final String? idToken;
  final String? deviceToken;
  RequestLoginSms({
    this.idToken,
    this.deviceToken,
  });

  factory RequestLoginSms.fromRawJson(String str) =>
      RequestLoginSms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestLoginSms.fromJson(Map<String, dynamic> json) =>
      RequestLoginSms(
        idToken: json["idToken"],
        deviceToken: json["deviceToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
        "deviceToken": deviceToken,
      };
}
