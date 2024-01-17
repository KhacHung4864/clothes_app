import 'dart:convert';
import 'dart:typed_data';

import 'package:clothes_app/data/model/order_model.dart';
import 'package:clothes_app/data/network/api/cart_api/cart_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/modules/cart/cart_controller.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:clothes_app/modules/fragments/order/order_now/oder_now_controller.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class OrderConfirmationController extends GetxController {
  final CartApi cartApi = CartApi();
  final OrderNowController orderController = Get.find();
  final CartController cartController = Get.find();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();
  RxList<int> selectedCartIDs = <int>[].obs;

  //order confirmation
  final RxList<int> _imageSelectedByte = <int>[].obs;
  Uint8List get imageSelectedByte => Uint8List.fromList(_imageSelectedByte);

  RxString imageSelectedName = "".obs;

  final ImagePicker picker = ImagePicker();

  @override
  void onInit() async {
    for (var item in orderController.selectedCartListItemsInfo) {
      selectedCartIDs.add(item.cartId!);
    }
    super.onInit();
  }

  setSelectedImage(Uint8List selectedImage) {
    _imageSelectedByte.value = selectedImage;
  }

  setSelectedImageName(String selectedImageName) {
    imageSelectedName.value = selectedImageName;
  }

  chooseImageFromGallery() async {
    final pickedImageXFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImageXFile != null) {
      final bytesOfImage = await pickedImageXFile.readAsBytes();

      setSelectedImage(bytesOfImage);
      setSelectedImageName(path.basename(pickedImageXFile.path));
    }
  }

  saveNewOrderInfo() async {
    String selectedItemsString = orderController.selectedCartListItemsInfo.map((eachSelectedItem) => jsonEncode(eachSelectedItem)).toList().join("||");
    OrderData order = OrderData(
      userId: int.parse(dashboardFragmentsController.currentUser.value!.userId!),
      selectedItems: selectedItemsString,
      deliverySystem: orderController.deliverySystem.value,
      paymentSystem: orderController.paymentSystem.value,
      note: orderController.noteToSellerController.text.trim(),
      totalAmount: orderController.totalAmount.value,
      image: "${DateTime.now().millisecondsSinceEpoch}-${imageSelectedName.value}",
      status: 0.obs,
      shipmentAddress: orderController.shipmentAddressController.text.trim(),
      phoneNumber: orderController.phoneNumberController.text.trim(),
    );
    try {
      final response = await cartApi.callAddNewOrder(data: order.toJson((base64Encode(imageSelectedByte))));

      if (response.statusCode == 200) {
        for (var eachSelectedItemCartID in selectedCartIDs) {
          cartController.deleteSelectedItemsFromUserCartList(eachSelectedItemCartID);
        }
        showError('Your new order has been placed Success');
        Get.offAllNamed(Routes.dashBoardFragment);
      } else {
        showError('Error');
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    }
  }
}
