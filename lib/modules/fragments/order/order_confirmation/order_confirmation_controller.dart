import 'dart:typed_data';

import 'package:clothes_app/data/network/api/cart_api/cart_api.dart';
import 'package:clothes_app/modules/fragments/order/oder_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class OrderConfirmationController extends GetxController {
  final CartApi cartApi = CartApi();
  final OrderController orderController = Get.find();

  //order confirmation
  final RxList<int> _imageSelectedByte = <int>[].obs;
  Uint8List get imageSelectedByte => Uint8List.fromList(_imageSelectedByte);

  RxString imageSelectedName = "".obs;

  final ImagePicker picker = ImagePicker();

  // @override
  // void onInit() async {
  //   super.onInit();
  // }

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
}
