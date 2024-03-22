import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_no_data_found.dart';

import '../../../Controllers/tiffin_order_controller.dart';

class TiffinOrderView extends StatefulWidget {
  const TiffinOrderView({
    super.key,
  });

  @override
  State<TiffinOrderView> createState() => _TiffinOrderViewState();
}

class _TiffinOrderViewState extends State<TiffinOrderView> {
  final tiffinOrderController = Get.put(TiffinOrderController());
  @override
  void initState() {
    super.initState();
    tiffinOrderController.getTiffinOrderList();
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
      backgroundColor: ColorConstant.orange,
      appBar: CustomAppBar(
        title: 'Tiffin Order',
        backGroundColor: ColorConstant.orange,
        // action: [
        //   IconButton(
        //       onPressed: () {
        //         Get.to(() => const BottomBarView(index: 1));
        //       },
        //       icon: const Icon(Icons.shopping_cart, color: ColorConstant.white))
        // ],
      ),
      body: Obx(
        () {
          return Stack(
            children: [
              // Positioned(
              //     right: 0,
              //     top: Get.height * 0.116,
              //     bottom: Get.height * 0.346,
              //     child: Image.asset(ImagePathConstant.rightShaeBg)),
              Positioned(
                  left: 0,
                  top: Get.height * 0.700,
                  bottom: Get.height * 0.100,
                  child: Image.asset(
                    ImagePathConstant.leftShapeBg,
                  )),
              (tiffinOrderController.getTifinOrderModel.value.orderList !=
                          null &&
                      tiffinOrderController
                              .getTifinOrderModel.value.orderList?.isNotEmpty ==
                          true)
                  ? Padding(
                      padding: screenPadding,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: tiffinOrderController
                                .getTifinOrderModel.value.orderList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          var data = tiffinOrderController
                              .getTifinOrderModel.value.orderList;
                          return ListTile(
                            tileColor: ColorConstant.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            trailing: InkWell(
                              onTap: () {
                                _launchCaller(
                                    data?[index]?.branchContactno ?? '');
                              },
                              child: const CircleAvatar(
                                backgroundColor: ColorConstant.greenColor,
                                child: Icon(
                                  Icons.call,
                                  color: ColorConstant.white,
                                ),
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Branch Name:- ${data?[index]?.branchName ?? ''}',
                                  style: TextStyleConstant.bold18(
                                      color: ColorConstant.orange),
                                ),
                                Text(
                                  'Packaging Type:- ${data?[index]?.packagingType ?? ''}',
                                  style: TextStyleConstant.bold16(
                                      color: ColorConstant.orange),
                                ),
                                Text(
                                  'Price: ${data?[index]?.total}',
                                  style: TextStyleConstant.bold14(
                                      color: ColorConstant.orangeAccent),
                                )
                              ],
                            ),
                          );
                          // return GestureDetector(
                          //   onTap: () => Get.to(() => FoodDetailListView(
                          //       categoryName:
                          //           "${tiffinOrderController.getTifinOrderModel.value.orderList?[index]?.orderCategory}",
                          //       subCategoryName:
                          //           "${tiffinOrderController.getTifinOrderModel.value.orderList?[index]?.orderCompletedStatus}")),
                          //   child: Padding(
                          //     padding: contentVerticalPadding,
                          //     child: CustomTypeSelecionButton(
                          //         isTrue: true,
                          //         imageIcon:
                          //             "${tiffinOrderController.getTifinOrderModel.value.orderList?[index]?.orderPackagingStatus}",
                          //         tabName:
                          //             "${tiffinOrderController.getTifinOrderModel.value.orderList?[index]?.tiffinStartDate}"),
                          //   ),
                          // );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                      ),
                    )
                  : const CustomNoDataFound(),
            ],
          );
        },
      ),
    );
  }
}
