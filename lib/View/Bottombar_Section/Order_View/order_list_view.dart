import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';

import '../../../Constant/static_decoration.dart';
import '../../../Controllers/order_controller.dart';
import '../../../Custom_Widgets/custom_textfield.dart';
import '../Cart_Section/cart_view.dart';

class OrderViewList extends StatefulWidget {
  const OrderViewList({super.key, required this.index});
  final int index;
  @override
  State<OrderViewList> createState() => _OrderViewListState();
}

class _OrderViewListState extends State<OrderViewList> {
  final orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    orderController.initialFunction();
  }

  _launchCaller(String number) async {
    var url = "tel:$number";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFEF3EB),
        appBar: const CustomAppBar(title: 'My Orders'),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  top: Get.height * -0.2,
                  left: Get.width * 0.38,
                  bottom: 200,
                  child: Image.asset(ImagePathConstant.rightShaeBg,
                      opacity: const AlwaysStoppedAnimation(0.5))),
              Image.asset(ImagePathConstant.homeUpperBg),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(ImagePathConstant.bottomCurve)),
              Padding(
                padding: EdgeInsets.only(
                    top: Get.height * 0.02,
                    left: screenWidthPadding,
                    right: screenWidthPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (orderController.getOrderListModel.value
                                    .orderList?[widget.index]?.itemList !=
                                null &&
                            orderController
                                    .getOrderListModel
                                    .value
                                    .orderList?[widget.index]
                                    ?.itemList
                                    ?.isNotEmpty ==
                                true) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: orderController.getOrderListModel.value
                                .orderList?[widget.index]?.itemList?.length,
                            itemBuilder: (context, index) {
                              var data = orderController.getOrderListModel.value
                                  .orderList?[widget.index]?.itemList?[index];
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
                                            "${data?.productImage}"),
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
                                                data?.prodName ?? '',
                                                style: TextStyleConstant
                                                    .semiBold18(
                                                        color: ColorConstant
                                                            .orange),
                                              ),
                                            ),
                                            Text(
                                              "Price: ₹${data?.price}",
                                              style:
                                                  TextStyleConstant.semiBold14(
                                                      color:
                                                          ColorConstant.orange),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Text("${data?.quantity}",
                                          style:
                                              TextStyleConstant.semiBold18()),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'No Data Available',
                              style: TextStyleConstant.bold20(
                                  color: ColorConstant.white),
                            ),
                          );
                        }
                      }),
                      const SizedBox(
                        height: 45,
                      ),
                      const HorizontalDottedLine(),
                      height10,
                      Text(
                        "Packaging",
                        style: TextStyleConstant.regular22(
                            color: ColorConstant.orange),
                      ),
                      height10,
                      Obx(() {
                        return NewRadioButton(
                          buttonName:
                              "${orderController.getOrderListModel.value.orderList?[widget.index]?.packagingType}",
                          isSelected: true,
                          onTap: () {},
                        );
                      }),
                      const HorizontalDottedLine(),
                      height20,
                      CustomTextField(
                          controller: TextEditingController(
                              text: orderController.getOrderListModel.value
                                      .orderList?[widget.index]?.couponCode ??
                                  ''),
                          fillColor: Colors.white,
                          hintText: 'coupon code',
                          isReadOnly: true,
                          suffixIcon: orderController
                                      .getOrderListModel
                                      .value
                                      .orderList?[widget.index]
                                      ?.couponCode
                                      ?.isNotEmpty ==
                                  true
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Applied',
                                        style: TextStyleConstant.semiBold14(
                                            color: Colors.green),
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                          enable: true),
                      const SizedBox(
                        height: 45,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() {
                            return Text(
                              "Total Item: ${orderController.getOrderListModel.value.orderList?[widget.index]?.itemList?.length ?? '0'}",
                              style: TextStyleConstant.regular18(
                                  color: ColorConstant.orange),
                            );
                          }),
                          Obx(() {
                            return Text(
                              "Dilivery: ${orderController.getOrderListModel.value.orderList?[widget.index]?.deliveryCharges}",
                              style: TextStyleConstant.regular18().copyWith(
                                  color: ColorConstant.appMainColor,
                                  fontWeight: FontWeight.w400),
                            );
                          }),
                          Text(
                            "Packaging: ${orderController.getOrderListModel.value.orderList?[widget.index]?.packagingPrice}",
                            style: TextStyleConstant.regular18().copyWith(
                                color: ColorConstant.appMainColor,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Discount: ${orderController.getOrderListModel.value.orderList?[widget.index]?.couponAmount ?? 0}",
                            style: TextStyleConstant.regular18(
                                color: ColorConstant.orange),
                          ),
                          Text(
                            "Tax: 5%",
                            style: TextStyleConstant.regular18(
                                color: ColorConstant.orange),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.500,
                                bottom: Get.height * 0.010,
                                top: Get.height * 0.020),
                            child: const HorizontalDottedLine(),
                          ),
                          Text(
                            "Sub Total: ${double.parse('${double.parse('${orderController.getOrderListModel.value.orderList?[widget.index]?.total}') + double.parse('${orderController.getOrderListModel.value.orderList?[widget.index]?.packagingPrice}') + double.parse('${orderController.getOrderListModel.value.orderList?[widget.index]?.packagingPrice}')}').toStringAsFixed(0)}",
                            style: TextStyleConstant.regular18(
                                color: ColorConstant.orange),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
