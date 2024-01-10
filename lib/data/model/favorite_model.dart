// ignore_for_file: no_leading_underscores_for_local_identifiers

class FavoriteModel {
  String? status;
  String? message;
  List<FavoriteData>? data;

  FavoriteModel({this.status, this.message, this.data});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => FavoriteData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class FavoriteData {
  String? favoriteId;
  String? userId;
  String? itemId;
  String? name;
  String? rating;
  String? tags;
  String? price;
  String? sizes;
  String? colors;
  String? description;
  String? image;

  FavoriteData({this.favoriteId, this.userId, this.itemId, this.name, this.rating, this.tags, this.price, this.sizes, this.colors, this.description, this.image});

  FavoriteData.fromJson(Map<String, dynamic> json) {
    favoriteId = json["favorite_id"];
    userId = json["user_id"];
    itemId = json["item_id"];
    name = json["name"];
    rating = json["rating"];
    tags = json["tags"];
    price = json["price"];
    sizes = json["sizes"];
    colors = json["colors"];
    description = json["description"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["favorite_id"] = favoriteId;
    _data["user_id"] = userId;
    _data["item_id"] = itemId;
    _data["name"] = name;
    _data["rating"] = rating;
    _data["tags"] = tags;
    _data["price"] = price;
    _data["sizes"] = sizes;
    _data["colors"] = colors;
    _data["description"] = description;
    _data["image"] = image;
    return _data;
  }
}
