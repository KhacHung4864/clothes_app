// ignore_for_file: no_leading_underscores_for_local_identifiers

class ClothesModel {
  String? status;
  String? message;
  List<ClothItem>? data;

  ClothesModel({this.status, this.message, this.data});

  ClothesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => ClothItem.fromJson(e)).toList();
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

class ClothItem {
  int? itemId;
  String? name;
  double? rating;
  List<String>? tags;
  double? price;
  List<String>? sizes;
  List<String>? colors;
  String? description;
  String? image;

  ClothItem({this.itemId, this.name, this.rating, this.tags, this.price, this.sizes, this.colors, this.description, this.image});

  ClothItem.fromJson(Map<String, dynamic> json) {
    itemId = int.parse(json["item_id"]);
    name = json["name"];
    rating = double.parse(json["rating"]);
    tags = json["tags"].toString().split(", ");
    price = double.parse(json["price"]);
    sizes = json["sizes"].toString().split(", ");
    colors = json["colors"].toString().split(", ");
    description = json["description"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["item_id"] = itemId;
    _data["name"] = name;
    _data["rating"] = rating;
    _data["tags"] = tags.toString();
    _data["price"] = price;
    _data["sizes"] = sizes.toString();
    _data["colors"] = colors.toString();
    _data["description"] = description;
    _data["image"] = image;
    return _data;
  }
}
