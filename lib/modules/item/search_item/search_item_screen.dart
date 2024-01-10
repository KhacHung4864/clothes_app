import 'package:clothes_app/data/model/clothes_model.dart';
import 'package:clothes_app/modules/item/search_item/search_item_controller.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView<SearchItemController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: showSearchBarWidget(),
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.purpleAccent,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.isLoading.value
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
                    child: Text(
                      controller.searchList.isEmpty ? "No item found" : "Search Results: ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.getSearchItems();
                },
                child: searchItemDesignWidget(context),
              ),
            ),
          ],
        )));
  }

  Widget showSearchBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller.searchController,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () {
              controller.getSearchItems();
            },
            icon: const Icon(
              Icons.search,
              color: Colors.purpleAccent,
            ),
          ),
          hintText: "Search best clothes here...",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              controller.searchController.clear();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.purpleAccent,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.purple,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.purpleAccent,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
    );
  }

  searchItemDesignWidget(context) {
    return ListView.builder(
      itemCount: controller.searchList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        ClothItem eachClothItemRecord = controller.searchList[index];

        return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.itemDetails, arguments: eachClothItemRecord);
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(
              16,
              index == 0 ? 16 : 8,
              16,
              index == controller.searchList.length - 1 ? 16 : 8,
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
                                eachClothItemRecord.name!,
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
                                "\$ ${eachClothItemRecord.price}",
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
                          "Tags: \n${eachClothItemRecord.tags.toString().replaceAll("[", "").replaceAll("]", "")}",
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
                    placeholder: const AssetImage("images/place_holder.png"),
                    image: NetworkImage(
                      eachClothItemRecord.image!,
                    ),
                    imageErrorBuilder: (context, error, stackTraceError) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
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
    );
  }
}
