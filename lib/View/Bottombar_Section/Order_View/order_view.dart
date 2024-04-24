import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/thank_you_view.dart';
import 'package:vandana/View/Bottombar_Section/Tifin_Section/select_vegetable_view.dart';

import '../../../Controllers/order_controller.dart';
import '../../../Controllers/tiffin_order_controller.dart';
import '../Home_Section/Food_Section/food_billing_view.dart';
import '../Home_Section/Tifin_Section/tifin_billing_view.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
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
        body: Stack(
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
                  top: Get.height * 0.045,
                  left: screenWidthPadding,
                  right: screenWidthPadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      if (orderController.getOrderListModel.value.orderList !=
                              null &&
                          orderController.getOrderListModel.value.orderList
                                  ?.isNotEmpty ==
                              true) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            var data = orderController
                                .getOrderListModel.value.orderList?[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: Get.height * 0.050),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (data?.itemList?.isNotEmpty == true)
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => FoodBillingView(
                                                  productImage:
                                                      "${data?.itemList?.first?.productImage}",
                                                  productName:
                                                      "${data?.itemList?.first?.prodName}",
                                                  productDescription:
                                                      "${data?.itemList?.first?.description}",
                                                  mrp:
                                                      "${data?.itemList?.first?.mrp}",
                                                  price:
                                                      "${data?.itemList?.first?.price}",
                                                  categoryName:
                                                      "${data?.itemList?.first?.categoryName}",
                                                  subCategoryName:
                                                      "${data?.itemList?.first?.subcategoryName}",
                                                  cartId: "1",
                                                  productCode:
                                                      "${data?.itemList?.first?.productCode}",
                                                  tax:
                                                      "${int.parse('${data?.itemList?.first?.taxPercent}') / 2}",
                                                  total:
                                                      "${data?.itemList?.first?.total}",
                                                  unit: "nos",
                                                  taxjGst:
                                                      "${int.parse('${data?.itemList?.first?.taxPercent}') / 2}",
                                                  taxsGst:
                                                      "${int.parse('${data?.itemList?.first?.taxPercent}') / 2}",
                                                ));
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${data?.itemList?.first?.productImage}",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: Get.height * 0.172,
                                              width: Get.width * 0.364,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill)),
                                            ),
                                            placeholder: (context, url) =>
                                                SizedBox(
                                              width: Get.width * 0.364,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: ColorConstant
                                                      .orangeAccent,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    SizedBox(
                                              width: Get.width * 0.364,
                                              child: const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Main Course Menu",
                                              style:
                                                  TextStyleConstant.regular22(
                                                      color: ColorConstant
                                                          .orange)),
                                          if (data?.itemList?.isNotEmpty ==
                                              true) ...[
                                            SizedBox(
                                              width: 135,
                                              child: Text(
                                                "${data?.itemList?.first?.productName}",
                                                style:
                                                    TextStyleConstant.regular18(
                                                        color: ColorConstant
                                                            .orangeAccent),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 135,
                                              child: Text(
                                                "${data?.itemList?.first?.description}",
                                                style:
                                                    TextStyleConstant.regular18(
                                                        color: ColorConstant
                                                            .orangeAccent),
                                              ),
                                            ),
                                          ]
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          _launchCaller(
                                              '${data?.branchContactno}');
                                        },
                                        child: const Icon(Icons.call)),
                                    GestureDetector(
                                      onTap: () {
                                        _launchCaller(
                                            '${data?.branchContactno}');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: Get.width * 0.45,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          "Call Delivery Partner",
                                          style: TextStyleConstant.regular18(
                                              color: ColorConstant.orange),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: screenVerticalPadding,
                                  child: const HorizontalDottedLine(),
                                ),
                              ],
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderController
                              .getOrderListModel.value.orderList?.length,
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
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
