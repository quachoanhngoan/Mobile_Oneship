import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserM {
  final int? id;
  final String? phone;
  final String? email;
  final String? status;
  // final DateTime? lastLogin;
  final String? deviceToken;
  final dynamic storeId;
  final dynamic name;
  // final dynamic emailVerifiedAt;
  // final DateTime? updatedAt;
  final List<dynamic>? stores;
  final String? accessToken;
  final String? refreshToken;

  UserM({
    this.id,
    this.phone,
    this.email,
    this.status,
    // this.lastLogin,
    this.deviceToken,
    this.storeId,
    this.name,
    // this.emailVerifiedAt,
    // this.updatedAt,
    this.stores,
    this.accessToken,
    this.refreshToken,
  });

  UserM copyWith({
    int? id,
    String? phone,
    String? email,
    String? status,
    // DateTime? lastLogin,
    String? deviceToken,
    dynamic? storeId,
    dynamic? name,
    // dynamic? emailVerifiedAt,
    DateTime? updatedAt,
    List<dynamic>? stores,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserM(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      status: status ?? this.status,
      // lastLogin: lastLogin ?? this.lastLogin,
      deviceToken: deviceToken ?? this.deviceToken,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      // emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      // updatedAt: updatedAt ?? this.updatedAt,
      stores: stores ?? this.stores,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'status': status,
      // 'lastLogin': lastLogin?.millisecondsSinceEpoch,
      'deviceToken': deviceToken,
      'storeId': storeId,
      'name': name,
      // 'emailVerifiedAt': emailVerifiedAt,
      // 'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'stores': stores,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory UserM.fromMap(Map<String, dynamic> map) {
    return UserM(
      id: map['id']?.toInt(),
      phone: map['phone'],
      email: map['email'],
      status: map['status'],
      // lastLogin: map['lastLogin'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(map['lastLogin'])
      //     : null,
      deviceToken: map['deviceToken'],
      storeId: map['storeId'],
      name: map['name'],
      // emailVerifiedAt: map['emailVerifiedAt'],
      // updatedAt: map['updatedAt'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
      //     : null,
      stores: List<dynamic>.from(map['stores']),
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserM.fromJson(String source) => UserM.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserM(id: $id, phone: $phone, email: $email, status: $status, , deviceToken: $deviceToken, storeId: $storeId, name: $name,  stores: $stores, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserM &&
        other.id == id &&
        other.phone == phone &&
        other.email == email &&
        other.status == status &&
        other.deviceToken == deviceToken &&
        other.storeId == storeId &&
        other.name == name &&
        // other.emailVerifiedAt == emailVerifiedAt &&
        // other.updatedAt == updatedAt &&
        listEquals(other.stores, stores) &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        status.hashCode ^
        deviceToken.hashCode ^
        storeId.hashCode ^
        name.hashCode ^
        // emailVerifiedAt.hashCode ^
        // updatedAt.hashCode ^
        stores.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode;
  }
}
