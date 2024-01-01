// ignore_for_file: no_leading_underscores_for_local_identifiers

class ImgurApiModel {
  Data? data;
  bool? success;
  int? status;

  ImgurApiModel({this.data, this.success, this.status});

  ImgurApiModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    success = json["success"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    _data["success"] = success;
    _data["status"] = status;
    return _data;
  }
}

class Data {
  String? id;
  String? title;
  dynamic description;
  int? datetime;
  String? type;
  bool? animated;
  int? width;
  int? height;
  int? size;
  int? views;
  int? bandwidth;
  dynamic vote;
  bool? favorite;
  dynamic nsfw;
  dynamic section;
  dynamic accountUrl;
  int? accountId;
  bool? isAd;
  bool? inMostViral;
  bool? hasSound;
  List<dynamic>? tags;
  int? adType;
  String? adUrl;
  String? edited;
  bool? inGallery;
  String? deletehash;
  String? name;
  String? link;

  Data(
      {this.id,
      this.title,
      this.description,
      this.datetime,
      this.type,
      this.animated,
      this.width,
      this.height,
      this.size,
      this.views,
      this.bandwidth,
      this.vote,
      this.favorite,
      this.nsfw,
      this.section,
      this.accountUrl,
      this.accountId,
      this.isAd,
      this.inMostViral,
      this.hasSound,
      this.tags,
      this.adType,
      this.adUrl,
      this.edited,
      this.inGallery,
      this.deletehash,
      this.name,
      this.link});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    datetime = json["datetime"];
    type = json["type"];
    animated = json["animated"];
    width = json["width"];
    height = json["height"];
    size = json["size"];
    views = json["views"];
    bandwidth = json["bandwidth"];
    vote = json["vote"];
    favorite = json["favorite"];
    nsfw = json["nsfw"];
    section = json["section"];
    accountUrl = json["account_url"];
    accountId = json["account_id"];
    isAd = json["is_ad"];
    inMostViral = json["in_most_viral"];
    hasSound = json["has_sound"];
    tags = json["tags"] ?? [];
    adType = json["ad_type"];
    adUrl = json["ad_url"];
    edited = json["edited"];
    inGallery = json["in_gallery"];
    deletehash = json["deletehash"];
    name = json["name"];
    link = json["link"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["datetime"] = datetime;
    _data["type"] = type;
    _data["animated"] = animated;
    _data["width"] = width;
    _data["height"] = height;
    _data["size"] = size;
    _data["views"] = views;
    _data["bandwidth"] = bandwidth;
    _data["vote"] = vote;
    _data["favorite"] = favorite;
    _data["nsfw"] = nsfw;
    _data["section"] = section;
    _data["account_url"] = accountUrl;
    _data["account_id"] = accountId;
    _data["is_ad"] = isAd;
    _data["in_most_viral"] = inMostViral;
    _data["has_sound"] = hasSound;
    if (tags != null) {
      _data["tags"] = tags;
    }
    _data["ad_type"] = adType;
    _data["ad_url"] = adUrl;
    _data["edited"] = edited;
    _data["in_gallery"] = inGallery;
    _data["deletehash"] = deletehash;
    _data["name"] = name;
    _data["link"] = link;
    return _data;
  }
}
