import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/food_detail_list_controller.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';
import 'package:vandana/Custom_Widgets/custom_no_data_found.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/food_billing_view.dart';
import 'package:vandana/View/Bottombar_Section/bottombar_view.dart';
import 'package:badges/badges.dart' as badges;

class FoodDetailListView extends StatefulWidget {
  final String categoryName;
  final String subCategoryName;

  const FoodDetailListView(
      {super.key, required this.categoryName, required this.subCategoryName});

  @override
  State<FoodDetailListView> createState() => _FoodDetailListViewState();
}

class _FoodDetailListViewState extends State<FoodDetailListView> {
  FoodDetailListController controller = Get.put(FoodDetailListController());
  bool isInCart = false;
  @override
  void initState() {
    super.initState();
    controller.categoryName.value = widget.categoryName;
    controller.subCategoryName.value = widget.subCategoryName;
    controller.initialFunctioun();
    if (widget.categoryName == 'Food') {
      controller.getFoodDetail().whenComplete(() => setState(() {}));
    }
    //  else if (widget.categoryName == "Thali With Chapati") {
    //   controller.getThaliChapatiList().whenComplete(() => setState(() {}));
    // }
    else {
      controller.getThaliChapatiList().whenComplete(() => setState(() {}));
    }
    // controller.getTodaysSabjiList().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // print('asddsd${controller.probabilityList}');
    return Scaffold(
      backgroundColor: ColorConstant.backGround,
      appBar: CustomAppBar(
        title: "Select Meal",
        action: [
          // IconButton(
          //     onPressed: () {
          //       Get.to(() => const BottomBarView(index: 1));
          //     },
          //     icon: const Icon(Icons.shopping_cart, color: ColorConstant.white))
          badges.Badge(
            showBadge: isInCart,
            badgeContent: Text(
              '',
              style: TextStyleConstant.regular16(color: ColorConstant.orange),
            ),
            position: badges.BadgePosition.custom(end: 8, top: -5),
            badgeStyle: badges.BadgeStyle(badgeColor: ColorConstant.lightGrey),
            child: IconButton(
                onPressed: () {
                  Get.to(() => const BottomBarView(index: 1));
                },
                icon: const Icon(Icons.shopping_cart,
                    color: ColorConstant.white)),
          )
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            ImagePathConstant.homeUpperBg,
            height: Get.height * 0.116,
          ),
          Obx(() {
            return widget.categoryName == 'Food'
                ? (controller.getFoodDetailListModel.value.productList != null)
                    ? ListView.builder(
                        itemCount: controller
                            .getFoodDetailListModel.value.productList?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => FoodBillingView(
                                    productImage:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.productImage1}",
                                    productName:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.productName}",
                                    productDescription:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.description}",
                                    mrp:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.mrp}",
                                    price:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.price}",
                                    categoryName:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.categoryName}",
                                    subCategoryName:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.subcategoryName}",
                                    cartId: "1",
                                    productCode:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.productCode}",
                                    tax:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.tax}",
                                    total:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.price}",
                                    unit: "nos",
                                    taxjGst:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.tax}",
                                    taxsGst:
                                        "${controller.getFoodDetailListModel.value.productList?[index]?.tax}",
                                  ));
                            },
                            child: Padding(
                              padding: screenPadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: Get.width * 0.030),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: Get.height * 0.172,
                                              width: Get.width * 0.364,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${controller.getFoodDetailListModel.value.productList?[index]?.productImage1}"),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            controller
                                                        .getFoodDetailListModel
                                                        .value
                                                        .productList?[index]?.itemAddStatus ==
                                                    "true"
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            Get.height * 0.020),
                                                    child: Row(
                                                      children: [
                                                        incDecIconButton(
                                                            onTap: () => controller
                                                                .manageCartItems(
                                                                    index:
                                                                        index,
                                                                    isAdd:
                                                                        false),
                                                            icon: Icons.remove),
                                                        Text(
                                                            "${controller.getFoodDetailListModel.value.productList?[index]?.itemAddQuantity}",
                                                            style: TextStyleConstant
                                                                .semiBold18()),
                                                        incDecIconButton(
                                                            onTap: () => controller
                                                                .manageCartItems(
                                                                    index:
                                                                        index,
                                                                    isAdd:
                                                                        true),
                                                            icon: Icons.add),
                                                      ],
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            Get.height * 0.020),
                                                    child: CustomButton(
                                                      onTap: () {
                                                        setState(() {
                                                          isInCart = true;
                                                        });
                                                        controller.postToCart(
                                                            index: index);
                                                      },
                                                      title: "Add to Cart",
                                                      width: Get.width * 0.300,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${controller.getFoodDetailListModel.value.productList?[index]?.productName}",
                                              style:
                                                  TextStyleConstant.regular22(
                                                      color:
                                                          ColorConstant.orange),
                                            ),
                                            Text(
                                              "${controller.getFoodDetailListModel.value.productList?[index]?.description}",
                                              style:
                                                  TextStyleConstant.regular16(
                                                      color: ColorConstant
                                                          .orangeAccent),
                                            ),
                                            Text(
                                              "${controller.getFoodDetailListModel.value.productList?[index]?.price}/-",
                                              style: TextStyleConstant.bold36(
                                                  color: ColorConstant.orange),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Get.height * 0.024),
                                    child: const HorizontalDottedLine(),
                                  ),
                                  // height10,
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const CustomNoDataFound()
                : (controller.getThaliChapatiListModel.value.productList !=
                        null)
                    ? ListView.builder(
                        itemCount: controller
                            .getThaliChapatiListModel.value.productList?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => FoodBillingView(
                                    productImage:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.productImage1}",
                                    productName:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.productName}",
                                    productDescription:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.description}",
                                    mrp:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.mrp}",
                                    price:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.price}",
                                    categoryName:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.categoryName}",
                                    subCategoryName:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.subcategoryName}",
                                    cartId: "1",
                                    productCode:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.productCode}",
                                    tax:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.tax}",
                                    total: "1",
                                    unit: "nos",
                                    taxjGst:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.tax}",
                                    taxsGst:
                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.tax}",
                                  ));
                            },
                            child: Padding(
                              padding: screenPadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: Get.width * 0.030),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: Get.height * 0.172,
                                              width: Get.width * 0.364,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${controller.getThaliChapatiListModel.value.productList?[index]?.productImage1}"),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            controller
                                                        .getThaliChapatiListModel
                                                        .value
                                                        .productList?[index]
                                                        ?.itemAddStatus ==
                                                    "true"
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            Get.height * 0.020),
                                                    child: Row(
                                                      children: [
                                                        incDecIconButton(
                                                            onTap: () => controller
                                                                .manageThaliCartItems(
                                                                    index:
                                                                        index,
                                                                    isAdd:
                                                                        false),
                                                            icon: Icons.remove),
                                                        Text(
                                                            "${controller.getThaliChapatiListModel.value.productList?[index]?.itemAddQuantity}",
                                                            style: TextStyleConstant
                                                                .semiBold18()),
                                                        incDecIconButton(
                                                            onTap: () => controller
                                                                .manageThaliCartItems(
                                                                    index:
                                                                        index,
                                                                    isAdd:
                                                                        true),
                                                            icon: Icons.add),
                                                      ],
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            Get.height * 0.020),
                                                    child: CustomButton(
                                                      onTap: () {
                                                        setState(() {
                                                          isInCart = true;
                                                        });
                                                        controller
                                                            .postThaliToCart(
                                                                index: index);
                                                      },
                                                      title: "Add to Cart",
                                                      width: Get.width * 0.300,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.tiffinType.value,
                                              style:
                                                  TextStyleConstant.regular18(
                                                      color:
                                                          ColorConstant.orange),
                                            ),
                                            Text(
                                              "${controller.getThaliChapatiListModel.value.productList?[index]?.productName}",
                                              style:
                                                  TextStyleConstant.regular22(
                                                      color:
                                                          ColorConstant.orange),
                                            ),
                                            Text(
                                              "${controller.getThaliChapatiListModel.value.productList?[index]?.description}",
                                              style:
                                                  TextStyleConstant.regular16(
                                                      color: ColorConstant
                                                          .orangeAccent),
                                            ),
                                            Text(
                                              "${controller.getThaliChapatiListModel.value.productList?[index]?.price}/-",
                                              style: TextStyleConstant.bold36(
                                                  color: ColorConstant.orange),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Get.height * 0.024),
                                    child: const HorizontalDottedLine(),
                                  ),
                                  // height10,
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const CustomNoDataFound();
          })
        ],
      ),
    );
  }

  Widget incDecIconButton(
      {required Function()? onTap, required IconData icon}) {
    return IconButton(
        onPressed: onTap, icon: Icon(icon, color: ColorConstant.orange));
  }
}
