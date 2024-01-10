import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/data/model/favorite_model.dart';
import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/fragments/favorites/favorites_controller.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 8, 8),
            child: Text(
              "My Favorite List:",
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          controller.isLoading.value
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
                  child: Text(
                    controller.favoriteList.isEmpty ? "No favorite item found" : "Order these best clothes for yourself now.",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),

          const SizedBox(height: 24),

          //displaying favoriteList
          Expanded(
            child: favoriteListItemDesignWidget(context),
          )
        ],
      ),
    );
  }

  favoriteListItemDesignWidget(context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.initData();
      },
      child: ListView.builder(
        itemCount: controller.favoriteList.length,
        itemBuilder: (context, index) {
          FavoriteData eachFavoriteItemRecord = controller.favoriteList[index];
          return controller.isLoading.value
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () async {
                    for (var element in controller.homeController.listAllClothItems) {
                      if (element.itemId == int.parse(eachFavoriteItemRecord.itemId!)) {
                        Get.toNamed(Routes.itemDetails, arguments: element);
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == controller.favoriteList.length - 1 ? 16 : 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 6,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        //name + price
                        //tags
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //name and price
                                Row(
                                  children: [
                                    //name
                                    Expanded(
                                      child: Text(
                                        eachFavoriteItemRecord.name!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    //price
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, right: 12),
                                      child: Text(
                                        "\$ ${eachFavoriteItemRecord.price}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.purpleAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

                                //tags
                                Text(
                                  "Tags: \n${eachFavoriteItemRecord.tags.toString().replaceAll("[", "").replaceAll("]", "")}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //image clothes
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: FadeInImage(
                            height: 130,
                            width: 130,
                            fit: BoxFit.cover,
                            placeholder: Assets.images.placeHolder.provider(),
                            image: NetworkImage(eachFavoriteItemRecord.image ?? ''),
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
                      ],
                    ),
                  ),
                );
        },
      ),
    );

    // return FutureBuilder(
    //     future: controller.getCurrentUserFavoriteList(),
    //     builder: (context, AsyncSnapshot<List<FavoriteData>>  controller.favoriteList) {
    //       if ( controller.favoriteList.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if ( controller.favoriteList.data == null) {
    //         return const Center(
    //           child: Text(
    //             "No favorite item found",
    //             style: TextStyle(
    //               color: Colors.grey,
    //             ),
    //           ),
    //         );
    //       }
    //       if ( controller.favoriteList.data!.isNotEmpty) {

    //       } else {
    //         return const Center(
    //           child: Text("Empty, No Data."),
    //         );
    //       }
    //     });
  }
}
