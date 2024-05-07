import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/View/selected_subji_view/selected_subji_view.dart';
import 'package:intl/intl.dart';
import '../../../Constant/static_decoration.dart';
import '../../../Controllers/tiffin_order_controller.dart';
import '../Home_Section/Tifin_Section/tifin_billing_view.dart';

class TifinServicesView extends StatefulWidget {
  const TifinServicesView({super.key});

  @override
  State<TifinServicesView> createState() => _TifinServicesViewState();
}

class _TifinServicesViewState extends State<TifinServicesView> {
  final tiffinOrderController = Get.put(TiffinOrderController());

  @override
  void initState() {
    super.initState();
    tiffinOrderController.initialFunction();
    tiffinOrderController.getTiffinOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFEF3EB),
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
            // Positioned(
            //     bottom: 0,
            //     left: 0,
            //     right: 0,
            //     child: Image.asset(ImagePathConstant.bottomCurve)),
            Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.050,
                  left: screenWidthPadding,
                  right: screenWidthPadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        " Hi, ${tiffinOrderController.userName.value}",
                        style: TextStyleConstant.bold32(
                            color: ColorConstant.white),
                      );
                    }),
                    Obx(() {
                      if (tiffinOrderController
                                  .getTifinOrderListModel.value.orderList !=
                              null &&
                          tiffinOrderController.getTifinOrderListModel.value
                                  .orderList?.isNotEmpty ==
                              true) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            var data = tiffinOrderController
                                .getTifinOrderListModel.value.orderList?[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: Get.height * 0.05,
                                      bottom: Get.height * 0.050),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (data?.itemList?.isNotEmpty == true)
                                        CachedNetworkImage(
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
                                          placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(
                                            color: ColorConstant.orangeAccent,
                                          )),
                                          errorWidget: (context, url, error) =>
                                              SizedBox(
                                            width: Get.width * 0.364,
                                            child: const Icon(Icons.error),
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
                                            Text(
                                              "${data?.itemList?.first?.productName}",
                                              style:
                                                  TextStyleConstant.regular18(
                                                      color: ColorConstant
                                                          .orangeAccent),
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
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: ColorConstant.orange)),
                                      child: Text(
                                        "Total Count : ${data?.tiffinCount}",
                                        style: TextStyleConstant.regular18(
                                            color: ColorConstant.orange),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Get.to(() => SelectVegetableView());
                                        print(
                                            '${data?.tiffintypeLunch} ${data?.tiffintypeDinner}');
                                        data?.itemList?.first?.subjiCount
                                                    ?.isNotEmpty ==
                                                true
                                            ? Get.to(() => SelectedSubjiView(
                                                  subjiCount: int.parse(
                                                      '${data?.itemList?.first?.subjiCount}'),
                                                  soNumber: '${data?.soNumber}',
                                                  enableLunch: data
                                                          ?.tiffintypeLunch
                                                          ?.isNotEmpty ??
                                                      false,
                                                  enableDinner: data
                                                          ?.tiffintypeDinner
                                                          ?.isNotEmpty ??
                                                      false,
                                                ))
                                            : customToast(
                                                message: 'No subji list found');
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
                                          "Select Vegetable",
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () async {
                                      Get.dialog(
                                        TiffinTypeAlert(
                                          tiffinOrderController:
                                              tiffinOrderController,
                                          enableLunch: data?.tiffintypeLunch
                                                  ?.isNotEmpty ??
                                              false,
                                          enableDinner: data?.tiffintypeDinner
                                                  ?.isNotEmpty ??
                                              false,
                                          onTap: () async {
                                            // String? date = await selectDate(
                                            //     context: context);
                                            DateTimeRange? result =
                                                await showDateRangePicker(
                                              context: context,
                                              firstDate: DateTime(2022, 1,
                                                  1), // the earliest allowable
                                              lastDate: DateTime(2030, 12,
                                                  31), // the latest allowable
                                              currentDate: DateTime.now(),
                                              saveText: 'Done',
                                            );
                                            if (result != null) {
                                              tiffinOrderController.cancelOrder(
                                                  soNumber: '${data?.soNumber}',
                                                  date: '${result.start}');
                                            } else {
                                              customToast(
                                                  message:
                                                      'Plese select date to cancel order');
                                            }
                                          },
                                        ),
                                      );

                                      //Old Code
                                      // Get.dialog(
                                      //   TiffinTypeAlert(
                                      //     tiffinOrderController:
                                      //         tiffinOrderController,
                                      //     enableLunch: data?.tiffintypeLunch
                                      //             ?.isNotEmpty ??
                                      //         false,
                                      //     enableDinner: data?.tiffintypeDinner
                                      //             ?.isNotEmpty ??
                                      //         false,
                                      //     onTap: () async {
                                      //       String? date = await selectDate(
                                      //           context: context);

                                      //       if (date != null) {
                                      //         tiffinOrderController.cancelOrder(
                                      //             soNumber: '${data?.soNumber}',
                                      //             date: date);
                                      //       } else {
                                      //         customToast(
                                      //             message:
                                      //                 'Plese select date to cancel order');
                                      //       }
                                      //     },
                                      //   ),
                                      // );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: Get.width * 0.3,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text("Cancel Tiffin",
                                          style: TextStyleConstant.regular18(
                                              color: ColorConstant.orange)),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tiffinOrderController
                              .getTifinOrderListModel.value.orderList?.length,
                        );
                      } else {
                        return Center(
                          child: Text(
                            'No Data Available',
                            style: TextStyleConstant.bold20(
                                color: ColorConstant.black),
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

class TiffinTypeAlert extends StatelessWidget {
  const TiffinTypeAlert({
    super.key,
    required this.tiffinOrderController,
    required this.onTap,
    this.enableLunch = false,
    this.enableDinner = false,
  });

  final TiffinOrderController tiffinOrderController;
  final VoidCallback onTap;
  final bool enableLunch;
  final bool enableDinner;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tiffin Type",
                      style: TextStyleConstant.semiBold22().copyWith(
                          color: ColorConstant.appMainColor,
                          fontWeight: FontWeight.w400),
                    ),
                    height20,
                    Visibility(
                      visible: enableLunch,
                      child: GestureDetector(
                          onTap: () {
                            tiffinOrderController.tiffinTypeLunch.value =
                                !tiffinOrderController.tiffinTypeLunch.value;
                          },
                          child: CustomRadioButton(
                              buttonName: "Lunch",
                              isSelected:
                                  tiffinOrderController.tiffinTypeLunch)),
                    ),
                    height10,
                    Visibility(
                      visible: enableDinner,
                      child: GestureDetector(
                          onTap: () {
                            tiffinOrderController.tiffinTypeDinner.value =
                                !tiffinOrderController.tiffinTypeDinner.value;
                          },
                          child: CustomRadioButton(
                              buttonName: "Dinner",
                              isSelected:
                                  tiffinOrderController.tiffinTypeDinner)),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text("Cancel Tiffin",
                        style: TextStyleConstant.regular18(
                            color: ColorConstant.orange)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> selectDate({
  required BuildContext context,
}) async {
  DateTime? picked;
  String date;
  picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    date = DateFormat('yyyy-MM-dd').format(picked);
    return date;
  } else {
    return null;
  }
}
