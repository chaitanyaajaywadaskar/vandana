import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/controllers/home_controller.dart';

import 'package:get/get.dart';

import '../../Constant/static_decoration.dart';
import '../../Custom_Widgets/custom_dotted_line.dart';

class FoodDetailListScreen extends StatefulWidget {
  FoodDetailListScreen(
      {super.key,
      required this.fromType,
      required this.subcategoryName,
      required this.categoryName});
  int fromType;
  String subcategoryName;
  String categoryName;
  @override
  State<FoodDetailListScreen> createState() => _FoodDetailListScreenState();
}

class _FoodDetailListScreenState extends State<FoodDetailListScreen> {
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    homeController.getTiffinDetailBySubCategory(
        widget.categoryName, widget.subcategoryName);
        homeController.getSabjiList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEF3EB),
      body: SafeArea(
          child: Stack(
        children: [
          Image.asset(
            "assets/images/upbg.png",
            height: 100,
          ),
          Positioned(
              right: -50,
              top: Get.height * 0.75,
              child: Transform.rotate(
                  angle: 90 * pi / 180,
                  child: Image.asset(
                    "assets/images/rotet.png",
                    height: 100,
                  ))),
          Obx(
            () => ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
              itemCount:
                  homeController.getItemListModel.value.productList?.length ??
                      0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Get.to(() => BillingScreen(
                    //   tiffinCount:  homeController.getItemListModel.value.productList?[index].tiffinCount ?? "",
                    //   weekendPrice: homeController.getItemListModel.value.productList?[index].satSundayPrice ?? "",
                    //   itemName: homeController.getItemListModel.value.productList?[index].productName,
                    //   getSabjiList: homeController.getSabjiDataModel.value.sabjiList,
                    //       fromType: widget.fromType,
                    //       mainImage: homeController.getItemListModel.value
                    //           .productList?[index].productImage1,
                    //       mrp: homeController
                    //           .getItemListModel.value.productList?[index].mrp,
                    //       Price: homeController
                    //           .getItemListModel.value.productList?[index].price,
                    //       itemDescription: homeController.getItemListModel.value
                    //           .productList?[index].description,
                    //     ),
                    //     );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(homeController
                                          .getItemListModel
                                          .value
                                          .productList?[index]
                                          .productImage1 ??
                                      ""),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          width15,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeController.getItemListModel.value
                                        .productList?[index].productName ??
                                    "",
                                style: TextStyleConstant.bold22().copyWith(
                                    color: ColorConstant.appMainColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              customHeight(20),
                            Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      homeController
                                                  .subCategoryDataModel
                                                  .value
                                                  .subcategoryList![index]
                                                  .count <=
                                              0
                                          ? null
                                          : homeController
                                              .subCategoryDataModel
                                              .value
                                              .subcategoryList![index]
                                              .count--;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: ColorConstant.appMainColor),
                                      child: const Icon(
                                        Icons.remove,
                                        color: primaryWhite,
                                      ),
                                    ),
                                  ),
                                  width05,
                                   Text(
                                     "${ homeController.subCategoryDataModel.value
                                          .subcategoryList?[index].count ?? ""}"
                                       ,
                                      style: TextStyleConstant.bold16()
                                          .copyWith(color: ColorConstant.appMainColor),
                                    ),
                                  
                                  width05,
                                  GestureDetector(
                                    onTap: () {
                                      homeController.subCategoryDataModel.value
                                          .subcategoryList![index].count++;
                                      setState(() {});
                                      print(
                                          "chech data ==> ${homeController.subCategoryDataModel.value.subcategoryList![index].count}");
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: ColorConstant.appMainColor),
                                      child: const Icon(
                                        Icons.add,
                                        color: primaryWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                  
                    
                      height10,
                      const HorizontalDottedLine(),
                      height10,
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: homeController.subCategoryDataModel.value
                              .subcategoryList?.first.count   ==
                          0 ||  homeController.subCategoryDataModel.value
                              .subcategoryList?.first.count == null
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.all(20),
                          height: 50,
                          width: Get.width,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: primaryWhite,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${homeController.subCategoryDataModel.value.subcategoryList!.first.count.toString()} Item |",
                                    style: TextStyleConstant.bold16()
                                        .copyWith(color: ColorConstant.appMainColor),
                                  ),
                                  Text(
                                    "  \u{20B9} ${homeController.subCategoryDataModel.value.subcategoryList!.first.count * 140}",
                                    style: TextStyleConstant.bold16()
                                        .copyWith(color: ColorConstant.appMainColor),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Get.to(()=> CartScreen());
                                },
                                child: Text(
                                  "View Cart",
                                  style: TextStyleConstant.bold16()
                                      .copyWith(color: ColorConstant.appMainColor),
                                ),
                              )
                            ],
                          ),
                        ),
                )
        ],
      )),
    );
 
  }
}
