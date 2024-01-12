class Order {
  int? orderId;
  int? userId;
  String? selectedItems;
  String? deliverySystem;
  String? paymentSystem;
  String? note;
  double? totalAmount;
  String? image;
  String? status;
  DateTime? dateTime;
  String? shipmentAddress;
  String? phoneNumber;

  Order({
    this.orderId,
    this.userId,
    this.selectedItems,
    this.deliverySystem,
    this.paymentSystem,
    this.note,
    this.totalAmount,
    this.image,
    this.status,
    this.shipmentAddress,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson(String imageSelectedBase64) => {
        "order_id": orderId.toString(),
        "user_id": userId.toString(),
        "selectedItems": selectedItems,
        "deliverySystem": deliverySystem,
        "paymentSystem": paymentSystem,
        "note": note,
        "totalAmount": totalAmount!.toStringAsFixed(2),
        "image": image,
        "status": status,
        "shipmentAddress": shipmentAddress,
        "phoneNumber": phoneNumber,
        "imageFile": imageSelectedBase64,
      };
}
