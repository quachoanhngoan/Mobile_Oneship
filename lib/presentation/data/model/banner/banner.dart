class BannerM {
  int? id;
  String? name;
  String? type;
  String? displayType;
  String? position;
  List<Files>? files;
  String? displayTypeLabel;
  String? typeLabel;

  BannerM(
      {this.id,
      this.name,
      this.type,
      this.displayType,
      this.position,
      this.files,
      this.displayTypeLabel,
      this.typeLabel});

  BannerM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    displayType = json['displayType'];
    position = json['position'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    displayTypeLabel = json['displayTypeLabel'];
    typeLabel = json['typeLabel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['displayType'] = displayType;
    data['position'] = position;
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    data['displayTypeLabel'] = displayTypeLabel;
    data['typeLabel'] = typeLabel;
    return data;
  }
}

class Files {
  int? id;
  // String? createdAt;
  // Null? deletedAt;
  // String? updatedAt;
  int? bannerId;
  String? fileId;
  int? sort;
  String? title;
  String? description;
  String? link;
  // Null? videoThumbnailId;
  String? linkType;
  bool? isActive;

  Files(
      {this.id,
      // this.createdAt,
      // this.deletedAt,
      // this.updatedAt,
      this.bannerId,
      this.fileId,
      this.sort,
      this.title,
      this.description,
      this.link,
      // this.videoThumbnailId,
      this.linkType,
      this.isActive});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // createdAt = json['createdAt'];
    // deletedAt = json['deletedAt'];
    // updatedAt = json['updatedAt'];
    bannerId = json['bannerId'];
    fileId = json['fileId'];
    sort = json['sort'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    // videoThumbnailId = json['videoThumbnailId'];
    linkType = json['linkType'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // data['createdAt'] = createdAt;
    // data['deletedAt'] = deletedAt;
    // data['updatedAt'] = updatedAt;
    data['bannerId'] = bannerId;
    data['fileId'] = fileId;
    data['sort'] = sort;
    data['title'] = title;
    data['description'] = description;
    data['link'] = link;
    // data['videoThumbnailId'] = videoThumbnailId;
    data['linkType'] = linkType;
    data['isActive'] = isActive;
    return data;
  }
}
