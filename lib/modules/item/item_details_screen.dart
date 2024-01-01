import 'package:clothes_app/configs/app_fonts.dart';
import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/item/item_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ItemDetailScreen extends GetView<ItemDetailController> {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        //item_image
        FadeInImage(
          height: 0.5.sh,
          width: 1.sw,
          fit: BoxFit.contain,
          placeholder: Assets.images.placeHolder.provider(),
          image: NetworkImage(controller.clothItem.image ?? ''),
          imageErrorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Palette.white,
              ),
            );
          },
        ),

        //item information
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 0.6.sh,
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Palette.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                topRight: Radius.circular(30.sp),
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, -3),
                  blurRadius: 6,
                  color: Palette.purpleAccent,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 18.h),
                  //item image
                  Center(
                    child: Container(
                      height: 8.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                        color: Palette.purpleAccent,
                        borderRadius: BorderRadius.circular(30.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  //item name
                  Text(
                    controller.clothItem.name ?? '',
                    style: AppFont.t.purpleAccent.s(24).bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //rating + tag + price
                      _detailInfor(),

                      //quantity item counter
                      _quantityItemCounter(),
                    ],
                  ),

                  //size
                  Text(
                    'Size',
                    style: AppFont.t.purpleAccent.s(18).bold,
                  ),
                  SizedBox(height: 8.h),
                  _choseSize(),
                  SizedBox(height: 20.h),

                  //color
                  Text(
                    'Color',
                    style: AppFont.t.purpleAccent.s(18).bold,
                  ),
                  SizedBox(height: 8.h),
                  _choseColor(),
                  SizedBox(height: 20.h),

                  //description
                  Text(
                    'Description',
                    style: AppFont.t.purpleAccent.s(18).bold,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    controller.clothItem.description ?? '',
                    textAlign: TextAlign.justify,
                    style: AppFont.t.grey,
                  ),
                  SizedBox(height: 30.h),

                  //add to cart button
                  _btnAddToCart(),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  Material _btnAddToCart() {
    return Material(
      elevation: 4.sp,
      color: Palette.purpleAccent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          controller.addItemToCart(
            int.parse(controller.dashboardFragmentsController.currentUser.value!.userId!),
            controller.clothItem.itemId!,
            controller.quantityItem.value,
            controller.clothItem.colors![controller.colorItem.value].replaceAll('[', '').replaceAll(']', ''),
            controller.clothItem.sizes![controller.sizeItem.value].replaceAll('[', '').replaceAll(']', ''),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          height: 50.h,
          child: Text(
            'Add to card',
            style: AppFont.t.s(20).white,
          ),
        ),
      ),
    );
  }

  Expanded _detailInfor() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //rating + rating number
          _rating(),
          SizedBox(height: 16.h),

          //tag
          Text(
            controller.clothItem.tags!.toString().replaceAll('[', '').replaceAll(']', ''),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppFont.t.s(16).bold.grey,
          ),
          SizedBox(height: 16.h),

          //price
          Text(
            '\$${controller.clothItem.price!}',
            style: AppFont.t.purpleAccent.s(24).bold,
          )
        ],
      ),
    );
  }

  Wrap _choseColor() {
    return Wrap(
      runSpacing: 8.sp,
      spacing: 8.sp,
      children: List.generate(
        controller.clothItem.colors!.length,
        (index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                controller.colorItem.value = index;
              },
              child: Container(
                height: 35.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: controller.colorItem.value == index ? Palette.purpleAccent.withOpacity(0.4) : Palette.black,
                  border: Border.all(width: 2.w, color: controller.colorItem.value == index ? Colors.transparent : Palette.grey),
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.clothItem.colors![index].replaceAll('[', '').replaceAll(']', ''),
                  style: AppFont.t.s(16).grey.w700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Wrap _choseSize() {
    return Wrap(
      runSpacing: 8.sp,
      spacing: 8.sp,
      children: List.generate(
        controller.clothItem.colors!.length,
        (index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                controller.sizeItem.value = index;
              },
              child: Container(
                height: 35.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: controller.sizeItem.value == index ? Palette.purpleAccent.withOpacity(0.4) : Palette.black,
                  border: Border.all(width: 2.w, color: controller.sizeItem.value == index ? Colors.transparent : Palette.grey),
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.clothItem.sizes![index].replaceAll('[', '').replaceAll(']', ''),
                  style: AppFont.t.s(16).grey.w700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Obx _quantityItemCounter() {
    return Obx(
      () => Column(
        children: [
          // +quantity
          IconButton(
            onPressed: () {
              controller.quantityItem.value = controller.quantityItem.value + 1;
            },
            icon: const Icon(
              Icons.add_circle_outline,
              color: Palette.white,
            ),
          ),
          Text(
            controller.quantityItem.value.toString(),
            style: AppFont.t.purpleAccent.s(20).bold,
          ),
          // -quantity
          IconButton(
            onPressed: () {
              if (controller.quantityItem.value > 1) {
                controller.quantityItem.value = controller.quantityItem.value - 1;
              } else {
                Fluttertoast.cancel();
                Fluttertoast.showToast(msg: 'Quantity must be 1 or greater than 1');
              }
            },
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Palette.white,
            ),
          ),
        ],
      ),
    );
  }

  Row _rating() {
    return Row(
      children: [
        //rating bar
        RatingBar.builder(
          initialRating: controller.clothItem.rating!,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, index) => const Icon(Icons.star, color: Palette.amber),
          onRatingUpdate: (value) {},
          ignoreGestures: true,
          unratedColor: Palette.grey,
          itemSize: 20.sp,
        ),
        //rating number
        SizedBox(width: 8.h),
        Text(
          '(${controller.clothItem.rating!})',
          style: AppFont.t.grey,
        )
      ],
    );
  }
}
