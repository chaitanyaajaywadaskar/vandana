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
import 'package:vandana/View/Bottombar_Section/Order_View/order_list_view.dart';
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
                              return Card(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(10),
                                  onTap: () {
                                    Get.to(() => OrderViewList(
                                          index: index,
                                        ));
                                  },
                                  leading: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text.rich(TextSpan(
                                          text: 'Order ID. : ',
                                          style: TextStyleConstant.bold14(),
                                          children: [
                                            TextSpan(text: '${data?.soNumber}')
                                          ])),
                                      // Text.rich(TextSpan(
                                      //     text: 'Total Amount. : ',
                                      //     style: TextStyleConstant.bold14(),
                                      //     children: [
                                      //       TextSpan(
                                      //           text: '${data?.finalAmount}')
                                      //     ])),
                                    ],
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text.rich(TextSpan(
                                          text: 'Date : ',
                                          style: TextStyleConstant.bold14(),
                                          children: [
                                            TextSpan(text: '${data?.orderDate}')
                                          ])),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          _launchCaller(
                                              '${data?.branchContactno}');
                                        },
                                        child: const CircleAvatar(
                                            radius: 18,
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              Icons.call,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
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
          ),
        ));
  }
}
