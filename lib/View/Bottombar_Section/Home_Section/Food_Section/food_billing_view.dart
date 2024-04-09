import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/food_billing_controller.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';
import 'package:vandana/View/Bottombar_Section/bottombar_view.dart';

import '../../../../Constant/static_decoration.dart';
import '../../../../Controllers/profile_controller.dart';
import '../../../../Custom_Widgets/custom_textfield.dart';
import '../../../Authentication_Section/address_view.dart';
import '../Tifin_Section/tifin_billing_view.dart';

class FoodBillingView extends StatefulWidget {
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
  State<FoodBillingView> createState() => _FoodBillingViewState();
}

class _FoodBillingViewState extends State<FoodBillingView> {
  final controller = Get.put(FoodBillingController());
  @override
  void initState() {
    controller.initialFunctioun(tifinPrice: widget.price);
    super.initState();
  }

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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height * 0.500,
            child: Image.network(
              widget.productImage,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: screenPadding,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.productName,
                              style: TextStyleConstant.semiBold22(
                                  color: ColorConstant.orange)),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: Get.height * 0.050),
                            child: Text(widget.productDescription,
                                style: TextStyleConstant.semiBold18(
                                    color: ColorConstant.orangeAccent)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text.rich(TextSpan(
                              text: 'MRP ',
                              style: TextStyleConstant.semiBold26(
                                  color: ColorConstant.redColor),
                              children: [
                                TextSpan(
                                    text: widget.mrp,
                                    style: TextStyleConstant.semiBold26(
                                            color: ColorConstant.redColor)
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough))
                              ])),
                          Text.rich(TextSpan(
                              text: 'Price ',
                              style: TextStyleConstant.semiBold26(
                                  color: ColorConstant.greenColor),
                              children: [
                                TextSpan(
                                  text: widget.price,
                                )
                              ])),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height10,
                    Text(
                      "Packaging",
                      style: TextStyleConstant.regular22(
                          color: ColorConstant.orange),
                    ),
                    height10,
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
                        },
                        child: CustomRadioButton(
                            buttonName:
                                "${controller.getPackagingListModel.value.packagingList?[1].packagingName ?? ""}  \u{20B9}${controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? ""}",
                            isSelected: controller.packEcoFriendly),
                      );
                    }),
                  ],
                ),
                height10,
                priceWidget(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget priceWidget({required FoodBillingController controller}) {
    final profileController = Get.put(ProfileController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: AlertDialog(
                      backgroundColor: ColorConstant.backGround,
                      title: Row(
                        children: [
                          IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.arrow_back)),
                          const Text("Select Address"),
                        ],
                      ),
                      content: SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => const AddressView(
                                      isEditAddress: false,
                                    ));
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  Text("Add Address"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: Get.height * 0.65,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: profileController
                                    .getAddressListModel.addressList?.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      onTap: () async {
                                        profileController
                                                .addressController.text =
                                            "${profileController.getAddressListModel.addressList?[index].address}";
                                        await profileController
                                            .setAddressDetail(index: index);

                                        profileController.update();
                                        Get.back();
                                      },
                                      leading: IconButton(
                                          onPressed: () {
                                            Get.to(() => AddressView(
                                                  isEditAddress: true,
                                                  state: profileController
                                                      .getAddressListModel
                                                      .addressList?[index]
                                                      .state,
                                                  pinCode: profileController
                                                      .getAddressListModel
                                                      .addressList?[index]
                                                      .pincode,
                                                  latLng: profileController
                                                      .getAddressListModel
                                                      .addressList?[index]
                                                      .latLong,
                                                  city: profileController
                                                      .getAddressListModel
                                                      .addressList?[index]
                                                      .city,
                                                  addressType: profileController
                                                      .getAddressListModel
                                                      .addressList?[index]
                                                      .addressType,
                                                  addressId: profileController
                                                      .getAddressListModel
                                                      .addressList?[index]
                                                      .id,
                                                  address: profileController
                                                      .getAddressListModel
                                                      .addressList?[index]
                                                      .address,
                                                ));
                                          },
                                          icon: const Icon(Icons.edit)),
                                      title: Text(
                                          "${profileController.getAddressListModel.addressList?[index].address}"),
                                      trailing: IconButton(
                                          onPressed: () {
                                            profileController.removeAddress(
                                                addressId:
                                                    "${profileController.getAddressListModel.addressList?[index].id}");
                                          },
                                          icon: const Icon(Icons.remove)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Card(
                surfaceTintColor: CupertinoColors.white,
                child: ListTile(
                    leading: Text(
                  'Select Address',
                  style: TextStyleConstant.semiBold14(),
                )))),
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
                          fillColor: Colors.grey.withOpacity(0.4),
                          hintText: 'Enter a coupon code',
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  controller.postCoupon();
                                },
                                child: Text(
                                  'Apply',
                                  style: TextStyleConstant.semiBold14(
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
              style: TextStyleConstant.regular18(color: Colors.green),
            ),
          ),
        Text(
          "Food Price: ${widget.mrp}",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Text(
          "Discount: ${int.parse(widget.mrp) - int.parse(widget.price)}",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Text(
          "Coupon: ${controller.discountInCart.value}",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Text(
          "Coupon: ${controller.discountInCart.value}",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Text(
          "Delivery: 0",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Obx(
          () => Text(
            "Packaging: ${controller.packEcoFriendly.value == true ? "${int.parse(controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * 22}" : "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * 22}"}",
            style: TextStyleConstant.regular18().copyWith(
                color: ColorConstant.appMainColor, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Get.width * 0.500,
              bottom: Get.height * 0.010,
              top: Get.height * 0.020),
          child: const HorizontalDottedLine(),
        ),
        Text(
          "Sub Total: ${controller.totalPriceInCart}",
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
                cartId: widget.cartId,
                categoryName: widget.categoryName,
                subCategoryName: widget.subCategoryName,
                productName: widget.productName,
                productCode: widget.productCode,
                price: widget.price,
                amount: widget.mrp,
                tax: widget.tax,
                taxsGst: widget.taxsGst,
                taxjGst: widget.taxjGst,
                total: widget.price,
                unit: widget.unit);
          },
        ),
      ],
    );
  }
}
