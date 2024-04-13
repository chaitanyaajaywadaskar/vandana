import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/cart_controller.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_no_data_found.dart';

import '../../../Constant/static_decoration.dart';
import '../../../Custom_Widgets/custom_dotted_line.dart';
import '../../../Custom_Widgets/custom_textfield.dart';
import '../Home_Section/Tifin_Section/tifin_billing_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Cart",
            style: TextStyle(color: ColorConstant.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.orangeAccent,
      ),
      body: GetBuilder<CartController>(
          init: CartController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: screenHorizontalPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (controller.getCartItemsListModel.cartItemList != null)
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller
                                .getCartItemsListModel.cartItemList?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: contentVerticalPadding,
                                child: Container(
                                  padding: contentPadding,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorConstant.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 30,
                                        backgroundImage: NetworkImage(
                                            "${controller.getCartItemsListModel.cartItemList?[index].productImage}"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: contentWidthPadding),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.40,
                                              child: Text(
                                                controller
                                                        .getCartItemsListModel
                                                        .cartItemList?[index]
                                                        .productName ??
                                                    '',
                                                style: TextStyleConstant
                                                    .semiBold18(
                                                        color: ColorConstant
                                                            .orange),
                                              ),
                                            ),
                                            Text(
                                              "Price: ₹${controller.getCartItemsListModel.cartItemList?[index].price ?? ''}",
                                              style:
                                                  TextStyleConstant.semiBold14(
                                                      color:
                                                          ColorConstant.orange),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      incDecIconButton(
                                          onTap: () =>
                                              controller.manageCartItems(
                                                  index: index, isAdd: false),
                                          icon: Icons.remove),
                                      Text(
                                          "${controller.getCartItemsListModel.cartItemList?[index].quantity}",
                                          style:
                                              TextStyleConstant.semiBold18()),
                                      incDecIconButton(
                                          onTap: () =>
                                              controller.manageCartItems(
                                                  index: index, isAdd: true),
                                          icon: Icons.add),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : const CustomNoDataFound(),
                    height10,
                    Text(
                      "Packaging",
                      style: TextStyleConstant.regular22(
                          color: ColorConstant.orange),
                    ),
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          controller.ifRegularSelected();
                          controller.packagingName.value = controller
                                  .getPackagingListModel
                                  .value
                                  .packagingList?[0]
                                  .packagingName ??
                              "";

                          controller.packagingPrice.value = controller
                                      .packEcoFriendly.value ==
                                  true
                              ? "${int.parse(controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * int.parse(controller.totalQuantityInCart.value)}"
                              : "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * int.parse(controller.totalQuantityInCart.value)}";
                        },
                        child: CustomRadioButton(
                            buttonName:
                                "${controller.getPackagingListModel.value.packagingList?[0].packagingName ?? ""}  \u{20B9}${controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? ""}",
                            isSelected: controller.packRegular),
                      );
                    }),
                    height10,
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          controller.isEcoFriendly();
                          controller.packagingName.value = controller
                                  .getPackagingListModel
                                  .value
                                  .packagingList?[1]
                                  .packagingName ??
                              "";

                          controller.packagingPrice.value = controller
                                      .packEcoFriendly.value ==
                                  true
                              ? "${int.parse(controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * int.parse(controller.totalQuantityInCart.value)}"
                              : "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * int.parse(controller.totalQuantityInCart.value)}";
                        },
                        child: CustomRadioButton(
                            buttonName:
                                "${controller.getPackagingListModel.value.packagingList?[1].packagingName ?? ""}  \u{20B9}${controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? ""}",
                            isSelected: controller.packEcoFriendly),
                      );
                    }),
                    height10,
                    const HorizontalDottedLine(),
                    height20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (controller.discountInCart.value == '0')
                          InkWell(
                            onTap: () {
                              Get.dialog(AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomTextField(
                                          controller: controller.coupon,
                                          fillColor:
                                              Colors.grey.withOpacity(0.4),
                                          hintText: 'Enter a coupon code',
                                          suffixIcon: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  controller.postCoupon();
                                                },
                                                child: Text(
                                                  'Apply',
                                                  style: TextStyleConstant
                                                      .semiBold14(
                                                          color: Colors.green),
                                                ),
                                              ),
                                            ],
                                          ),
                                          enable: true),
                                    ],
                                  ),
                                ),
                              ));
                            },
                            child: Text(
                              "Have any coupon?",
                              style: TextStyleConstant.regular18(
                                  color: Colors.green),
                            ),
                          ),
                        Text(
                          "Total Item: ${controller.getCartItemsListModel.cartItemList?.length ?? '0'}",
                          style: TextStyleConstant.regular18(
                              color: ColorConstant.orange),
                        ),
                        Obx(() {
                          return Text(
                            "Dilivery: ${controller.getDeliveryChargesModel.value.dcList?[0]?.deliveryChargesAmt ?? '0'}",
                            style: TextStyleConstant.regular18().copyWith(
                                color: ColorConstant.appMainColor,
                                fontWeight: FontWeight.w400),
                          );
                        }),
                        Obx(
                          () => Text(
                            "Packaging: ${controller.packagingPrice.value}",
                            style: TextStyleConstant.regular18().copyWith(
                                color: ColorConstant.appMainColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Obx(() {
                          return Text(
                            "Discount: ${controller.discountInCart.value}",
                            style: TextStyleConstant.regular18(
                                color: ColorConstant.orange),
                          );
                        }),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.500,
                              bottom: Get.height * 0.010,
                              top: Get.height * 0.020),
                          child: const HorizontalDottedLine(),
                        ),
                        Obx(() {
                          return Text(
                            "Sub Total: ${controller.totalPriceInCart.value}",
                            style: TextStyleConstant.regular18(
                                color: ColorConstant.orange),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: screenPadding,
        child: CustomButton(
          title: "Place Order",
          onTap: () async {
            CartController controller = Get.find();

            final payload = [];
            controller.getCartItemsListModel.cartItemList?.forEach((element) {
              String tax = (int.parse(element.tax ?? '0') / 2).toString();

              payload.add({
                '\"cartId\"': '\"${element.id}\"',
                '\"category_name\"': '\"${element.categoryName}\"',
                '\"subcategory_name\"': '\"${element.subcategoryName}\"',
                '\"product_name\"': '\"${element.productName}\"',
                '\"product_code\"': '\"${element.productCode}\"',
                '\"quantity\"': '\"${element.quantity}\"',
                '\"price\"': '\"${element.price}\"',
                '\"amount\"':
                    '\"${double.parse('${element.quantity == 'null' ? 0 : element.quantity ?? 0}') * double.parse('${element.price == 'null' ? 0 : element.price ?? 0}')}\"',
                '\"tax\"': '\"${tax != '0.0' ? tax : ''}\"',
                '\"tax_sgst\"': '\"${tax != '0.0' ? tax : ''}\"',
                '\"tax_igst\"': '\"\"',
                '\"total\"':
                    '\"${double.parse('${element.quantity == 'null' ? 0 : element.quantity ?? 0}') * double.parse('${element.price == 'null' ? 0 : element.price ?? 0}')}\"',
                '\"unit\"': '\"${element.unit}\"',
              });
            });
            controller.postOrder(orderItems: payload);
          },
        ),
      ),
    );
  }

  Widget incDecIconButton(
      {required Function()? onTap, required IconData icon}) {
    return IconButton(
        onPressed: onTap, icon: Icon(icon, color: ColorConstant.orange));
  }
}
