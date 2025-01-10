import 'dart:convert';

class ResponseLoginStoreModel {
  final String? accessToken;
  final String? refreshToken;
  ResponseLoginStoreModel({
    this.accessToken,
    this.refreshToken,
  });

  ResponseLoginStoreModel copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return ResponseLoginStoreModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory ResponseLoginStoreModel.fromMap(Map<String, dynamic> map) {
    return ResponseLoginStoreModel(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseLoginStoreModel.fromJson(String source) =>
      ResponseLoginStoreModel.fromMap(json.decode(source));
}
