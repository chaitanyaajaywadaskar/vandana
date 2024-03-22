import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/food_billing_controller.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';
import 'package:vandana/View/Bottombar_Section/bottombar_view.dart';

class FoodBillingView extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productDescription;
  final String mrp;
  final String price;
  final String cartId;
  final String categoryName;
  final String subCategoryName;
  final String productCode;
  final String tax;
  final String taxsGst;
  final String taxjGst;
  final String total;
  final String unit;

  const FoodBillingView(
      {super.key,
      required this.productImage,
      required this.productName,
      required this.productDescription,
      required this.mrp,
      required this.price,
      required this.cartId,
      required this.categoryName,
      required this.subCategoryName,
      required this.productCode,
      required this.tax,
      required this.taxsGst,
      required this.taxjGst,
      required this.total,
      required this.unit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGround,
      appBar: CustomAppBar(
        title: "Food Billing",
        action: [
          IconButton(
              onPressed: () {
                Get.to(() => const BottomBarView(index: 1));
              },
              icon: const Icon(Icons.shopping_cart, color: ColorConstant.white))
        ],
      ),
      body: GetBuilder<FoodBillingController>(
          init: FoodBillingController(),
          builder: (controller) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  width: Get.width,
                  height: Get.height * 0.500,
                  child: Image.network(
                    productImage,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productName,
                          style: TextStyleConstant.semiBold26(
                              color: ColorConstant.orange)),
                      Padding(
                        padding: EdgeInsets.only(bottom: Get.height * 0.050),
                        child: Text(productDescription,
                            style: TextStyleConstant.semiBold18(
                                color: ColorConstant.orangeAccent)),
                      ),
                      priceWidget(controller: controller),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget priceWidget({required FoodBillingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Food Price: $mrp",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Text(
          "Discount: ${int.parse(mrp) - int.parse(price)}",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Text(
          "Delivery: 0",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Get.width * 0.500,
              bottom: Get.height * 0.010,
              top: Get.height * 0.020),
          child: const HorizontalDottedLine(),
        ),
        Text(
          "Sub Total: $price",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Get.width * 0.500,
              top: Get.height * 0.010,
              bottom: Get.height * 0.020),
          child: const HorizontalDottedLine(),
        ),
        CustomButton(
          title: "Place Order",
          width: Get.width * 0.400,
          onTap: () {
            controller.postOrder(
                cartId: cartId,
                categoryName: categoryName,
                subCategoryName: subCategoryName,
                productName: productName,
                productCode: productCode,
                price: price,
                amount: mrp,
                tax: tax,
                taxsGst: taxsGst,
                taxjGst: taxjGst,
                total: price,
                unit: unit);
          },
        ),
      ],
    );
  }
}
