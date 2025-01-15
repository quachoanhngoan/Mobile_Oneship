import 'dart:convert';

class RequestUpdateAddress {
  final String? address;
  final String? building;
  final String? gate;
  final double? lat;
  final double? lng;
  final String? type;
  final String? note;

  const RequestUpdateAddress({
    this.address,
    this.building,
    this.gate,
    this.lat,
    this.lng,
    this.type,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'building': building,
      'gate': gate,
      'lat': lat,
      'lng': lng,
      'type': type,
      'note': note,
    };
  }

  Map<String, dynamic> removeNullValues() {
    return toMap()..removeWhere((key, value) => value == null);
  }

  factory RequestUpdateAddress.fromMap(Map<String, dynamic> map) {
    return RequestUpdateAddress(
      address: map['address'],
      building: map['building'],
      gate: map['gate'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      type: map['type'],
    );
  }

  String toJson() => json.encode(removeNullValues());

  factory RequestUpdateAddress.fromJson(String source) =>
      RequestUpdateAddress.fromMap(json.decode(source));

  RequestUpdateAddress copyWith({
    String? address,
    String? building,
    String? gate,
    double? lat,
    double? lng,
    String? type,
    String? note,
  }) {
    return RequestUpdateAddress(
      address: address ?? this.address,
      building: building ?? this.building,
      gate: gate ?? this.gate,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      type: type ?? this.type,
      note: note ?? this.note,
    );
  }
}
