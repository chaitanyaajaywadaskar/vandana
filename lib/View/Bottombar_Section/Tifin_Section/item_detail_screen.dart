import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';

import '../../../Constant/static_decoration.dart';
import '../../../Controllers/home_controller.dart';
import '../../../Custom_Widgets/custom_dotted_line.dart';
import '../billing_screen.dart';

class TypeDetailScreen extends StatefulWidget {
  TypeDetailScreen(
      {super.key,
      required this.fromType,
      required this.subcategoryName,
      required this.categoryName});
  int fromType;
  String subcategoryName;
  String categoryName;
  @override
  State<TypeDetailScreen> createState() => _TypeDetailScreenState();
}

class _TypeDetailScreenState extends State<TypeDetailScreen> {
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
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
          Container(
            child: Positioned(
                right: -50,
                top: Get.height * 0.75,
                child: Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Image.asset(
                      "assets/images/rotet.png",
                      height: 100,
                    ))),
          ),
          Obx(
            () => ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
              itemCount:
                  homeController.getItemListModel.value.productList?.length ??
                      0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => BillingScreen(
                      tiffinCount:  homeController.getItemListModel.value.productList?[index].tiffinCount ?? "",
                      weekendPrice: homeController.getItemListModel.value.productList?[index].satSundayPrice ?? "",
                      itemName: homeController.getItemListModel.value.productList?[index].productName,
                      getSabjiList: homeController.getSabjiDataModel.value.sabjiList,
                          fromType: widget.fromType,
                          mainImage: homeController.getItemListModel.value
                              .productList?[index].productImage1,
                          mrp: homeController
                              .getItemListModel.value.productList?[index].mrp,
                          Price: homeController
                              .getItemListModel.value.productList?[index].price,
                          itemDescription: homeController.getItemListModel.value
                              .productList?[index].description,
                        ));
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
                                style: TextStyleConstant.semiBold22().copyWith(
                                    color: ColorConstant.appMainColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              height05,
                              SizedBox(
                                width: Get.width * 0.5,
                                child: Text(
                                  homeController.getItemListModel.value
                                          .productList?[index].description ??
                                      "",
                                  style: TextStyleConstant.semiBold18().copyWith(
                                      color:ColorConstant.appMainColorLite,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      height20,
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: ColorConstant.appMainColor)),
                            child: Text(
                              "Total Count: ${ homeController.getItemListModel.value
                                    .productList?[index].tiffinCount}",
                              style: TextStyleConstant.semiBold18().copyWith(
                                  color: ColorConstant.appMainColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          customWidth(50),
                          Text(
                            homeController.getItemListModel.value
                                    .productList?[index].price ??
                                "",
                            style: TextStyleConstant.semiBold22()
                                .copyWith(fontSize: 30, color: ColorConstant.appMainColor),
                          ),
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
        ],
      )),
    );
 
  }
}
