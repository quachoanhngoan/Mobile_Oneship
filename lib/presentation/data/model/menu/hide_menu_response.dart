class HideMenuResponse {
  final List<dynamic>? generatedMaps;
  final List<dynamic>? raw;
  final int? affected;

  HideMenuResponse({
    this.generatedMaps,
    this.raw,
    this.affected,
  });

  factory HideMenuResponse.fromJson(Map<String, dynamic> json) {
    return HideMenuResponse(
      generatedMaps: json['generatedMaps'] ?? [],
      raw: json['raw'] ?? [],
      affected: json['affected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'generatedMaps': generatedMaps,
      'raw': raw,
      'affected': affected,
    };
  }
}
