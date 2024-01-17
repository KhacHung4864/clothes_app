// ignore_for_file: no_leading_underscores_for_local_identifiers

class CartModel {
  String? status;
  String? message;
  List<CartData>? data;

  CartModel({this.status, this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => CartData.fromJson(e)).toList();
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

class CartData {
  int? cartId;
  int? userId;
  int? itemId;
  int? quantity;
  String? color;
  String? size;
  String? name;
  double? rating;
  List<String>? tags;
  double? price;
  List<String>? sizes;
  List<String>? colors;
  String? description;
  String? image;

  CartData({
    this.cartId,
    this.userId,
    this.itemId,
    this.quantity,
    this.color,
    this.size,
    this.name,
    this.rating,
    this.tags,
    this.price,
    this.sizes,
    this.colors,
    this.description,
    this.image,
  });

  CartData.fromJson(Map<String, dynamic> json) {
    cartId = int.parse(json["cart_id"]);
    userId = int.parse(json["user_id"]);
    itemId = int.parse(json["item_id"]);
    quantity = int.parse(json["quantity"]);
    color = json["color"];
    size = json["size"];
    name = json["name"];
    rating = double.parse(json["rating"]);
    tags = json["tags"].toString().split(', ');
    price = double.parse(json["price"]);
    sizes = json["sizes"].toString().split(', ');
    colors = json["colors"].toString().split(', ');
    description = json["description"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_id"] = userId;
    _data["item_id"] = itemId;
    _data["quantity"] = quantity;
    _data["color"] = color;
    _data["size"] = size;
    _data["image"] = image;
    _data["name"] = name;
    _data["price"] = price;
    return _data;
  }
}
