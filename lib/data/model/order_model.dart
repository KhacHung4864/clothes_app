// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class OrderModel {
  String? status;
  String? message;
  List<OrderData>? data;

  OrderModel({this.status, this.message, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => OrderData.fromJson(e)).toList();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> _data = <String, dynamic>{};
  //   _data["status"] = status;
  //   _data["message"] = message;
  //   if (data != null) {
  //     _data["data"] = data?.map((e) => e.toJson()).toList();
  //   }
  //   return _data;
  // }
}

class OrderData {
  int? orderId;
  int? userId;
  String? selectedItems;
  String? deliverySystem;
  String? paymentSystem;
  String? note;
  double? totalAmount;
  String? image;
  Rx<int>? status = 0.obs;
  DateTime? dateTime;
  String? shipmentAddress;
  String? phoneNumber;

  OrderData(
      {this.orderId,
      this.userId,
      this.selectedItems,
      this.deliverySystem,
      this.paymentSystem,
      this.note,
      this.totalAmount,
      this.image,
      this.status,
      this.dateTime,
      this.shipmentAddress,
      this.phoneNumber});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = int.parse(json["order_id"]);
    userId = int.parse(json["user_id"]);
    selectedItems = json["selectedItems"];
    deliverySystem = json["deliverySystem"];
    paymentSystem = json["paymentSystem"];
    note = json["note"];
    totalAmount = double.parse(json["totalAmount"]);
    image = json["image"];
    status?.value = int.parse(json["status"]);
    dateTime = DateTime.parse(json["dateTime"]);
    shipmentAddress = json["shipmentAddress"];
    phoneNumber = json["phoneNumber"];
  }

  Map<String, dynamic> toJson(String imageSelectedBase64) {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["order_id"] = orderId;
    _data["user_id"] = userId;
    _data["selectedItems"] = selectedItems;
    _data["deliverySystem"] = deliverySystem;
    _data["paymentSystem"] = paymentSystem;
    _data["note"] = note;
    _data["totalAmount"] = totalAmount!.toStringAsFixed(2);
    _data["image"] = image;
    _data["status"] = status.toString();
    _data["dateTime"] = dateTime;
    _data["shipmentAddress"] = shipmentAddress;
    _data["phoneNumber"] = phoneNumber;
    _data["imageFile"] = imageSelectedBase64;
    return _data;
  }
}
