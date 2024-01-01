import 'package:clothes_app/configs/app_fonts.dart';
import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/data/model/clothes_model.dart';
import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/fragments/home/home_controller.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            //search bar widget
            showSearchBarWidget(),

            SizedBox(height: 24.h),

            //trending-popular items
            Text(
              'Trending',
              style: AppFont.t.s(24).bold.purpleAccent,
            ),

            _trendingClothItemsWidget(),

            SizedBox(height: 24.h),

            //all new collection items
            Text(
              'New Collection',
              style: AppFont.t.s(24).bold.purpleAccent,
            ),

            _allClothItemsWidget()
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<ClothItem>> _trendingClothItemsWidget() {
    return FutureBuilder(
      future: controller.getTrendingClothItems(),
      builder: (context, AsyncSnapshot<List<ClothItem>> dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (dataSnapShot.data == null) {
          return Center(
            child: Text('No Trending item found', style: AppFont.t),
          );
        }
        if (dataSnapShot.data!.isNotEmpty) {
          return SizedBox(
            height: 260.h,
            child: ListView.builder(
              itemCount: dataSnapShot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _trendingClothesItem(index, dataSnapShot);
              },
            ),
          );
        }
        return Center(
          child: Text('Empty, No Data.', style: AppFont.t),
        );
      },
    );
  }

  FutureBuilder<List<ClothItem>> _allClothItemsWidget() {
    return FutureBuilder(
      future: controller.getAllClothItems(),
      builder: (context, AsyncSnapshot<List<ClothItem>> dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (dataSnapShot.data == null) {
          return Center(
            child: Text('No Trending item found', style: AppFont.t),
          );
        }
        if (dataSnapShot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: dataSnapShot.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _allClothesItem(index, dataSnapShot);
            },
          );
        }
        return Center(
          child: Text('Empty, No Data.', style: AppFont.t),
        );
      },
    );
  }

  Widget _allClothesItem(int index, AsyncSnapshot<List<ClothItem>> dataSnapShot) {
    ClothItem clothItem = dataSnapShot.data![index];
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.itemDetails, arguments: clothItem);
      },
      child: Container(
        width: 200.w,
        margin: EdgeInsets.fromLTRB(
          0,
          index == 0 ? 16 : 8,
          0,
          index == dataSnapShot.data!.length - 1 ? 16 : 8,
        ),
        decoration: BoxDecoration(
          color: Palette.black,
          borderRadius: BorderRadius.circular(20.sp),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 6,
              color: Palette.white,
            ),
          ],
        ),
        child: Row(children: [
          //name and price
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name and price
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          clothItem.name ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppFont.t.s(18).bold.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                        child: Text(
                          '\$${clothItem.price!}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppFont.t.s(18).bold.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Tags \n${clothItem.tags!.toString().replaceAll('[', '').replaceAll(']', '')}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFont.t.s(12).bold.grey,
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp),
            ),
            child: FadeInImage(
              height: 130.h,
              width: 130.w,
              fit: BoxFit.cover,
              placeholder: Assets.images.placeHolder.provider(),
              image: NetworkImage(clothItem.image ?? ''),
              imageErrorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: Palette.white,
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget _trendingClothesItem(int index, AsyncSnapshot<List<ClothItem>> dataSnapShot) {
    ClothItem clothItem = dataSnapShot.data![index];
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.itemDetails, arguments: clothItem);
      },
      child: Container(
        width: 200.w,
        margin: EdgeInsets.fromLTRB(
          index == 0 ? 16 : 8,
          10,
          index == dataSnapShot.data!.length - 1 ? 16 : 8,
          10,
        ),
        decoration: BoxDecoration(
          color: Palette.black,
          borderRadius: BorderRadius.circular(20.sp),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 6,
              color: Palette.grey,
            ),
          ],
        ),
        child: Column(
          children: [
            //item image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.sp),
                topRight: Radius.circular(22.sp),
              ),
              child: FadeInImage(
                height: 150.h,
                width: 200.w,
                fit: BoxFit.cover,
                placeholder: Assets.images.placeHolder.provider(),
                image: NetworkImage(clothItem.image ?? ''),
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Palette.white,
                    ),
                  );
                },
              ),
            ),

            //item name & price
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      clothItem.name ?? '',
                      style: AppFont.t.grey.s(16).bold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '\$${clothItem.price!}',
                    style: AppFont.t.purpleAccent.s(18).bold,
                  )
                ],
              ),
            ),
            SizedBox(height: 8.h),
            // item rating
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RatingBar.builder(
                    initialRating: clothItem.rating!,
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
                  SizedBox(width: 8.h),
                  Text(
                    '(${clothItem.rating!})',
                    style: AppFont.t.grey,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showSearchBarWidget() {
    return TextField(
      style: AppFont.t.white,
      controller: controller.searchController,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Palette.purpleAccent,
          ),
        ),
        hintText: 'Search best clothes here...',
        hintStyle: AppFont.t.grey.s(12),
        suffixIcon: IconButton(
          onPressed: () {
            Get.toNamed(Routes.cart);
          },
          icon: const Icon(
            Icons.shopping_cart,
            color: Palette.purpleAccent,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.w,
            color: Palette.purpleAccent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.w,
            color: Palette.purple,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.w,
            color: Palette.purpleAccent,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
      ),
    );
  }
}
