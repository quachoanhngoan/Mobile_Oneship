class SearchResponse {
  String? type;
  List<String>? query;
  List<Features>? features;
  String? attribution;

  SearchResponse({this.type, this.query, this.features, this.attribution});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    query = json['query'].cast<String>();
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    attribution = json['attribution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['query'] = query;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    data['attribution'] = attribution;
    return data;
  }
}

class Features {
  String? id;
  String? type;
  List<String>? placeType;
  // int? relevance;
  Properties? properties;
  String? text;
  String? placeName;
  List<double>? bbox;
  List<double>? center;
  Geometry? geometry;
  List<Context>? context;
  String? matchingText;
  String? matchingPlaceName;

  Features(
      {this.id,
      this.type,
      this.placeType,
      // this.relevance,
      this.properties,
      this.text,
      this.placeName,
      this.bbox,
      this.center,
      this.geometry,
      this.context,
      this.matchingText,
      this.matchingPlaceName});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    placeType = json['place_type'].cast<String>();
    // relevance = json['relevance'];
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
    text = json['text'];
    placeName = json['place_name'];
    // bbox = json['bbox'].cast<double>();
    center = json['center'].cast<double>();
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    if (json['context'] != null) {
      context = <Context>[];
      json['context'].forEach((v) {
        context!.add(Context.fromJson(v));
      });
    }
    matchingText = json['matching_text'];
    matchingPlaceName = json['matching_place_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['place_type'] = placeType;
    // data['relevance'] = relevance;
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    data['text'] = text;
    data['place_name'] = placeName;
    data['bbox'] = bbox;
    data['center'] = center;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    if (context != null) {
      data['context'] = context!.map((v) => v.toJson()).toList();
    }
    data['matching_text'] = matchingText;
    data['matching_place_name'] = matchingPlaceName;
    return data;
  }
}

class Properties {
  String? mapboxId;
  String? wikidata;

  Properties({this.mapboxId, this.wikidata});

  Properties.fromJson(Map<String, dynamic> json) {
    mapboxId = json['mapbox_id'];
    wikidata = json['wikidata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mapbox_id'] = mapboxId;
    data['wikidata'] = wikidata;
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class Context {
  String? id;
  String? mapboxId;
  String? wikidata;
  String? text;
  String? shortCode;

  Context({this.id, this.mapboxId, this.wikidata, this.text, this.shortCode});

  Context.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mapboxId = json['mapbox_id'];
    wikidata = json['wikidata'];
    text = json['text'];
    shortCode = json['short_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mapbox_id'] = mapboxId;
    data['wikidata'] = wikidata;
    data['text'] = text;
    data['short_code'] = shortCode;
    return data;
  }
}
