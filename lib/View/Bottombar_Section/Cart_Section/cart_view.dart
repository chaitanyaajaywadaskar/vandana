import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/cart_controller.dart';
import 'package:vandana/Controllers/login_controller.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_no_data_found.dart';

import '../../../Constant/static_decoration.dart';
import '../../../Custom_Widgets/custom_dotted_line.dart';
import '../../../Custom_Widgets/custom_no_data_with_icon.dart';
import '../../../Custom_Widgets/custom_textfield.dart';
import '../../../Custom_Widgets/custom_toast.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final controller = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    controller.initialFunctioun();
  }

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
      backgroundColor: ColorConstant.white,
      body: Obx(() {
        return controller
                    .getCartItemsListModel.value.cartItemList?.isNotEmpty ==
                true
            ? SingleChildScrollView(
                child: Padding(
                  padding: screenHorizontalPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller
                            .getCartItemsListModel.value.cartItemList?.length,
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
                                        "${controller.getCartItemsListModel.value.cartItemList?[index].productImage}"),
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
                                          width: Get.width * 0.37,
                                          child: Text(
                                            controller
                                                    .getCartItemsListModel
                                                    .value
                                                    .cartItemList?[index]
                                                    .productName ??
                                                '',
                                            style: TextStyleConstant.semiBold18(
                                                color: ColorConstant.orange),
                                          ),
                                        ),
                                        Text(
                                          "Price: ₹${controller.getCartItemsListModel.value.cartItemList?[index].price ?? ''}",
                                          style: TextStyleConstant.semiBold14(
                                              color: ColorConstant.orange),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  incDecIconButton(
                                      onTap: () => controller.manageCartItems(
                                          index: index, isAdd: false),
                                      icon: Icons.remove),
                                  Text(
                                      "${controller.getCartItemsListModel.value.cartItemList?[index].quantity}",
                                      style: TextStyleConstant.semiBold18()),
                                  incDecIconButton(
                                      onTap: () => controller.manageCartItems(
                                          index: index, isAdd: true),
                                      icon: Icons.add),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      height10,
                      if (controller.getCartItemsListModel.value.cartItemList
                              ?.isNotEmpty ==
                          true)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HorizontalDottedLine(),
                            height10,
                            Text(
                              "Packaging",
                              style: TextStyleConstant.regular22(
                                  color: ColorConstant.orange),
                            ),
                            height10,
                            Obx(
                              () => controller.getPackagingListModel.value
                                              .packagingList !=
                                          null &&
                                      controller.getPackagingListModel.value
                                              .packagingList?.isNotEmpty ==
                                          true
                                  ? ListView.builder(
                                      itemBuilder: (context, index) =>
                                          NewRadioButton(
                                        buttonName:
                                            "${controller.getPackagingListModel.value.packagingList?[index].packagingName ?? ""}  \u{20B9}${controller.getPackagingListModel.value.packagingList?[index].packagingPrice ?? ""}",
                                        isSelected:
                                            controller.packagingName.value ==
                                                controller
                                                    .getPackagingListModel
                                                    .value
                                                    .packagingList?[index]
                                                    .packagingName
                                                    .toString(),
                                        onTap: () {
                                          controller.singlePackagingCost.value =
                                              '${int.parse(controller.getPackagingListModel.value.packagingList?[index].packagingPrice ?? "0")}';

                                          controller.packagingName.value =
                                              controller
                                                      .getPackagingListModel
                                                      .value
                                                      .packagingList?[index]
                                                      .packagingName ??
                                                  "";
                                          controller.packagingPrice.value =
                                              "${int.parse(controller.getPackagingListModel.value.packagingList?[index].packagingPrice ?? "0") * int.parse(controller.totalQuantityInCart.value)}";
                                          controller.calculateTotal(controller
                                              .totalPriceInCart.value);
                                          setState(() {});
                                        },
                                      ),
                                      itemCount: controller
                                          .getPackagingListModel
                                          .value
                                          .packagingList
                                          ?.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                    )
                                  : const CircularProgressIndicator(),
                            ),

                            // Obx(() {
                            //   return GestureDetector(
                            //     onTap: () {
                            //       controller.ifRegularSelected();
                            //       controller.packagingName.value = controller
                            //               .getPackagingListModel
                            //               .value
                            //               .packagingList?[0]
                            //               .packagingName ??
                            //           "";

                            //       controller.packagingPrice.value = controller
                            //                   .packEcoFriendly.value ==
                            //               true
                            //           ? "${int.parse(controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * int.parse(controller.totalQuantityInCart.value)}"
                            //           : "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * int.parse(controller.totalQuantityInCart.value)}";
                            //     },
                            //     child: CustomRadioButton(
                            //         buttonName:
                            //             "${controller.getPackagingListModel.value.packagingList?[0].packagingName ?? ""}  \u{20B9}${controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? ""}",
                            //         isSelected: controller.packRegular),
                            //   );
                            // }),
                            // height10,
                            // Obx(() {
                            //   return GestureDetector(
                            //     onTap: () {
                            //       controller.isEcoFriendly();
                            //       controller.packagingName.value = controller
                            //               .getPackagingListModel
                            //               .value
                            //               .packagingList?[1]
                            //               .packagingName ??
                            //           "";

                            //       controller.packagingPrice.value = controller
                            //                   .packEcoFriendly.value ==
                            //               true
                            //           ? "${int.parse(controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * int.parse(controller.totalQuantityInCart.value)}"
                            //           : "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * int.parse(controller.totalQuantityInCart.value)}";
                            //     },
                            //     child: CustomRadioButton(
                            //         buttonName:
                            //             "${controller.getPackagingListModel.value.packagingList?[1].packagingName ?? ""}  \u{20B9}${controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? ""}",
                            //         isSelected: controller.packEcoFriendly),
                            //   );
                            // }),
                            height10,
                            const HorizontalDottedLine(),
                          ],
                        ),
                      if (controller.getCartItemsListModel.value.cartItemList
                              ?.isNotEmpty ==
                          true)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            height20,
                            Text(
                              'Add More Food Item',
                              style: TextStyleConstant.bold16(),
                            ),
                            height20,
                            Obx(() {
                              if (controller.isAddOnCartLoading.value) {
                                return const CircularProgressIndicator(
                                  color: Colors.orange,
                                );
                              }
                              return SizedBox(
                                height: 205,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.getAddOnItemModel.value
                                      .addonItemList?.length,
                                  itemBuilder: (context, index) {
                                    var data = controller.getAddOnItemModel
                                        .value.addonItemList?[index];
                                    return Padding(
                                      padding: contentVerticalPadding,
                                      child: Container(
                                        padding: contentPadding,
                                        width: 150,
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorConstant.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              maxRadius: 30,
                                              backgroundImage: NetworkImage(
                                                  "${data?.productImage1}"),
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
                                                    width: Get.width * 0.37,
                                                    child: Text(
                                                      data?.productName ?? '',
                                                      style: TextStyleConstant
                                                          .semiBold18(
                                                              color:
                                                                  ColorConstant
                                                                      .orange),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Price: ₹${data?.price ?? ''}",
                                                    style: TextStyleConstant
                                                        .semiBold14(
                                                            color: ColorConstant
                                                                .orange),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            data?.itemAddStatus == "true"
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            Get.height * 0.020),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        incDecIconButton(
                                                            onTap: () => controller
                                                                .manageCartItemsForAddOn(
                                                                    index:
                                                                        index,
                                                                    isAdd:
                                                                        false),
                                                            icon: Icons.remove),
                                                        Text(
                                                            "${data?.itemAddQuantity}",
                                                            style: TextStyleConstant
                                                                .semiBold18()),
                                                        incDecIconButton(
                                                            onTap: () => controller
                                                                .manageCartItemsForAddOn(
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
                                                        controller
                                                            .postToCart(
                                                                index: index)
                                                            .then((value) {
                                                          controller
                                                              .getCartItemsList()
                                                              .then((value) => controller
                                                                  .calculateTotal(
                                                                      controller
                                                                          .totalPriceInCart
                                                                          .value));
                                                          controller
                                                              .getAddOnItemList();
                                                        });
                                                      },
                                                      title: "Add to Cart",
                                                      width: Get.width * 0.300,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      height20,
                      if (controller.getCartItemsListModel.value.cartItemList
                              ?.isNotEmpty ==
                          true)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Total Item: ${controller.getCartItemsListModel.value.cartItemList?.length ?? '0'}",
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
                            Text(
                              "Tax: 5%",
                              style: TextStyleConstant.regular18(
                                  color: ColorConstant.orange),
                            ),
                            if (controller.discountInCart.value == '0')
                              InkWell(
                                onTap: () {
                                  Get.dialog(AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    content: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                                              color:
                                                                  Colors.green),
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.500,
                                  bottom: Get.height * 0.010,
                                  top: Get.height * 0.020),
                              child: const HorizontalDottedLine(),
                            ),
                            Obx(() {
                              return Text(
                                "Sub Total: ${controller.totalCount.value}",
                                style: TextStyleConstant.regular18(
                                    color: ColorConstant.orange),
                              );
                            }),
                          ],
                        )
                    ],
                  ),
                ),
              )
            : const CustomNoDataFoundWithJson();
      }),
      bottomNavigationBar: Obx(() {
        return controller
                    .getCartItemsListModel.value.cartItemList?.isNotEmpty ==
                true
            ? Padding(
                padding: screenPadding,
                child: CustomButton(
                  title: "Place Order",
                  onTap: () async {
                    CartController controller = Get.find();
                    if (controller.getCartItemsListModel.value.cartItemList
                            ?.isNotEmpty ==
                        true) {
                      final payload = [];
                      controller.getCartItemsListModel.value.cartItemList
                          ?.forEach((element) {
                        String tax =
                            (int.parse(element.tax ?? '0') / 2).toString();

                        payload.add({
                          '\"cartId\"': '\"${element.id}\"',
                          '\"category_name\"': '\"${element.categoryName}\"',
                          '\"subcategory_name\"':
                              '\"${element.subcategoryName}\"',
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
                    } else {
                      customToast(message: "No item in cart!");
                    }
                  },
                ),
              )
            : Visibility(visible: false, child: Container());
      }),
    );
  }

  Widget incDecIconButton(
      {required Function()? onTap, required IconData icon}) {
    return IconButton(
        onPressed: onTap, icon: Icon(icon, color: ColorConstant.orange));
  }
}

class NewRadioButton extends StatelessWidget {
  const NewRadioButton(
      {super.key,
      required this.buttonName,
      required this.isSelected,
      required this.onTap});

  final String buttonName;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorConstant.orange),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? ColorConstant.orange
                      : ColorConstant.orangeAccent,
                ),
              ),
            ),
            width10,
            Text(
              buttonName,
              style: TextStyleConstant.regular16(
                  color: ColorConstant.orangeAccent),
            )
          ],
        ),
      ),
    );
  }
}
