import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/tifin_billing_controller.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';

import '../../../../Constant/static_decoration.dart';
import '../../../../Custom_Widgets/text_widgets/input_text_field_widget.dart';
import '../../../../Custom_Widgets/time_slote_widget.dart';

class TifinBillingView extends StatefulWidget {
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
  final String weekendPrice;
  final String tifinCount;
  final String subjiCount;

  const TifinBillingView(
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
      required this.unit,
      required this.weekendPrice,
      required this.tifinCount, required this.subjiCount});

  @override
  State<TifinBillingView> createState() => _TifinBillingViewState();
}

class _TifinBillingViewState extends State<TifinBillingView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  TifinBillingController controller = Get.put(TifinBillingController());
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
    controller.initialFunctioun(
        weekendPrice: double.parse(widget.weekendPrice),
        tifinCount: widget.tifinCount,
        tifinPrice: widget.price);
    tabController?.addListener(() {
      controller.getSabjiListDaywise(
        day: controller.daysName[int.parse('${tabController?.index}')],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGround,
      appBar: const CustomAppBar(title: "Tifin Billing"),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productName,
                    style: TextStyleConstant.semiBold26(
                        color: ColorConstant.orange)),
                Padding(
                  padding: EdgeInsets.only(bottom: Get.height * 0.050),
                  child: Text(widget.productDescription,
                      style: TextStyleConstant.semiBold18(
                          color: ColorConstant.orangeAccent)),
                ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              controller.tiffinTypeLunch.value =
                                  !controller.tiffinTypeLunch.value;
                              controller.tiffinType.value = 'Lunch';
                            },
                            child: CustomRadioButton(
                                buttonName: "Lunch",
                                isSelected: controller.tiffinTypeLunch)),
                        width10,
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await controller.getTimeSlot(true);
                                showTimeSlotePopUP(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    controller
                                        .getTimeSlotModel.value.timeslotList!,
                                    true);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: primaryWhite,
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
                                child: Obx(
                                  () => Text(
                                    controller.selectedLunchTime.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyleConstant.regular14()
                                        .copyWith(
                                            color: ColorConstant.appMainColor,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: ColorConstant.appMainColor,
                            ),
                            width05,
                            GestureDetector(
                              onTap: () async {
                                controller.isLunchOfficeSelected.value = false;
                                controller.isLunchHomeSelected.value = true;
                                print(
                                    "check data ==> ${controller.isLunchOfficeSelected.value}");
                              },
                              child: Obx(
                                () => Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: controller
                                                  .isLunchHomeSelected.value ==
                                              true
                                          ? ColorConstant.appMainColor
                                          : ColorConstant.appMainColorLite,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.home,
                                    color: ColorConstant.appBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            width05,
                            GestureDetector(
                              onTap: () async {
                                controller.isLunchOfficeSelected.value = true;
                                controller.isLunchHomeSelected.value = false;
                              },
                              child: Obx(
                                () => Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: controller.isLunchOfficeSelected
                                                  .value ==
                                              true
                                          ? ColorConstant.appMainColor
                                          : ColorConstant.appMainColorLite,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.location_city,
                                    color: ColorConstant.appBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              controller.tiffinTypeDinner.value =
                                  !controller.tiffinTypeDinner.value;
                              controller.tiffinType.value = 'Dinner';
                            },
                            child: CustomRadioButton(
                                buttonName: "Dinner",
                                isSelected: controller.tiffinTypeDinner)),
                        width10,
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await controller.getTimeSlot(false);
                                showTimeSlotePopUP(
                                    context,
                                    controller
                                        .getTimeSlotModel.value.timeslotList!,
                                    false);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: primaryWhite,
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
                                child: Obx(
                                  () => Text(
                                    controller.selectedDinnerTime.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyleConstant.regular14()
                                        .copyWith(
                                            color: ColorConstant.appMainColor,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: ColorConstant.appMainColor,
                            ),
                            width05,
                            GestureDetector(
                              onTap: () {
                                controller.isDinnerHomeSelected.value = true;
                                controller.isDinnerOfficeSelected.value = false;
                              },
                              child: Obx(
                                () => Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: controller
                                                  .isDinnerHomeSelected.value ==
                                              true
                                          ? ColorConstant.appMainColor
                                          : ColorConstant.appMainColorLite,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.home,
                                    color: ColorConstant.appBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            width05,
                            GestureDetector(
                              onTap: () {
                                controller.isDinnerHomeSelected.value = false;
                                controller.isDinnerOfficeSelected.value = true;
                              },
                              child: Obx(
                                () => Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: controller.isDinnerOfficeSelected
                                                  .value ==
                                              true
                                          ? ColorConstant.appMainColor
                                          : ColorConstant.appMainColorLite,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.location_city,
                                    color: ColorConstant.appBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                height20,
                const HorizontalDottedLine(),
                height20,

                Text(
                  "Please Select",
                  style:
                      TextStyleConstant.regular22(color: ColorConstant.orange),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.010, bottom: Get.height * 0.020),
                  child: DefaultTabController(
                    length: 7,
                    child: TabBar(
                      controller: tabController,
                      labelColor: ColorConstant.orange,
                      isScrollable: true,
                      tabs: [
                        InkWell(
                          onTap: () {
                            controller.getSabjiListDaywise(
                              day: controller.daysName[0],
                            );
                            tabController?.animateTo(0);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("${controller.next7Days[0].day}"),
                                  Text(" - ${controller.next7Days[0].month}"),
                                ],
                              ),
                              Tab(text: controller.daysName[0]),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.getSabjiListDaywise(
                              day: controller.daysName[1],
                            );
                            tabController?.animateTo(1);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("${controller.next7Days[1].day}"),
                                  Text(" - ${controller.next7Days[1].month}"),
                                ],
                              ),
                              Tab(text: controller.daysName[1]),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.getSabjiListDaywise(
                              day: controller.daysName[2],
                            );
                            tabController?.animateTo(2);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("${controller.next7Days[2].day}"),
                                  Text(" - ${controller.next7Days[2].month}"),
                                ],
                              ),
                              Tab(text: controller.daysName[2]),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.getSabjiListDaywise(
                              day: controller.daysName[3],
                            );
                            tabController?.animateTo(3);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("${controller.next7Days[3].day}"),
                                  Text(" - ${controller.next7Days[3].month}"),
                                ],
                              ),
                              Tab(text: controller.daysName[3]),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.getSabjiListDaywise(
                              day: controller.daysName[4],
                            );
                            tabController?.animateTo(4);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("${controller.next7Days[4].day}"),
                                  Text(" - ${controller.next7Days[4].month}"),
                                ],
                              ),
                              Tab(text: controller.daysName[4]),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.getSabjiListDaywise(
                              day: controller.daysName[5],
                            );
                            tabController?.animateTo(5);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("${controller.next7Days[5].day}"),
                                  Text(" - ${controller.next7Days[5].month}"),
                                ],
                              ),
                              Tab(text: controller.daysName[5]),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.getSabjiListDaywise(
                              day: controller.daysName[6],
                            );
                            tabController?.animateTo(6);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("${controller.next7Days[6].day}"),
                                  Text(" - ${controller.next7Days[6].month}"),
                                ],
                              ),
                              Tab(text: controller.daysName[6]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.34,
                  child: Obx(() {
                    return TabBarView(controller: tabController, children: [
                      // Content for Monday
                      SelectVegetableWidget(
                          vegeTableList: controller
                                  .getSabjiListDaywiseModel.value.sabjiList ??
                              []),
                      SelectVegetableWidget(
                          vegeTableList: controller
                                  .getSabjiListDaywiseModel.value.sabjiList ??
                              []),
                      SelectVegetableWidget(
                          vegeTableList: controller
                                  .getSabjiListDaywiseModel.value.sabjiList ??
                              []),
                      SelectVegetableWidget(
                          vegeTableList: controller
                                  .getSabjiListDaywiseModel.value.sabjiList ??
                              []),
                      SelectVegetableWidget(
                          vegeTableList: controller
                                  .getSabjiListDaywiseModel.value.sabjiList ??
                              []),
                      SelectVegetableWidget(
                          vegeTableList: controller
                                  .getSabjiListDaywiseModel.value.sabjiList ??
                              []),
                      SelectVegetableWidget(
                          vegeTableList: controller
                                  .getSabjiListDaywiseModel.value.sabjiList ??
                              []),
                    ]);
                  }),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height20,
                    const HorizontalDottedLine(),
                    height20,
                    Text(
                      "Weekend Choice",
                      style: TextStyleConstant.semiBold22().copyWith(
                          color: ColorConstant.appMainColor,
                          fontWeight: FontWeight.w400),
                    ),
                    height20,
                    GestureDetector(
                      onTap: () {
                        controller.onSaturday.value =
                            !controller.onSaturday.value;
                        controller.getWeekendCount(
                            price:
                                double.parse(widget.weekendPrice.toString()));
                        controller.getTotalCount(
                            tiffinCount: widget.tifinCount,
                            tiffinPrice: widget.price,
                            ecoFriendly: controller.getPackagingListModel.value
                                    .packagingList?[1].packagingPrice ??
                                '0',
                            regular: controller.getPackagingListModel.value
                                    .packagingList?[0].packagingPrice ??
                                '0');
                        print("Count check ==> ${controller.count.toString()}");
                      },
                      child: CustomRadioButton(
                          buttonName: "Saturday",
                          isSelected: controller.onSaturday),
                    ),
                    height10,
                    GestureDetector(
                        onTap: () {
                          controller.onSunday.value =
                              !controller.onSunday.value;
                          controller.getWeekendCount(
                              price:
                                  double.parse(widget.weekendPrice.toString()));
                          controller.getTotalCount(
                              tiffinCount: widget.tifinCount,
                              tiffinPrice: widget.price,
                              ecoFriendly: controller.getPackagingListModel
                                      .value.packagingList?[1].packagingPrice ??
                                  '0',
                              regular: controller.getPackagingListModel.value
                                      .packagingList?[0].packagingPrice ??
                                  '0');
                          print(
                              "Count check ==> ${controller.count.toString()}");
                        },
                        child: CustomRadioButton(
                            buttonName: "Sunday",
                            isSelected: controller.onSunday)),
                  ],
                ),
                height20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HorizontalDottedLine(),
                    height10,
                    Text(
                      "Start Date",
                      style: TextStyleConstant.regular22(
                          color: ColorConstant.orange),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectDate(context: context, controller: controller);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.date_range_outlined,
                            color: ColorConstant.orange,
                          ),
                          width10,
                          Obx(
                            () => Text(controller.convertedDate.value,
                                textAlign: TextAlign.start,
                                style: TextStyleConstant.regular18(
                                    color: ColorConstant.orange)),
                          )
                        ],
                      ),
                    ),
                    height10,
                  ],
                ),
                const HorizontalDottedLine(),
                height10,
                Text(
                  "Packaging",
                  style:
                      TextStyleConstant.regular22(color: ColorConstant.orange),
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
                    },
                    child: CustomRadioButton(
                        buttonName:
                            "${controller.getPackagingListModel.value.packagingList?[0].packagingName ?? ""}  \u{20B9}${controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? ""}",
                        isSelected: controller.packRegular),
                  );
                }),
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
                height10,
                const HorizontalDottedLine(),
                height20,
                SizedBox(
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Tiffin Price: ${widget.mrp}",
                        style: TextStyleConstant.regular18().copyWith(
                          color: ColorConstant.appMainColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Discount: ${int.parse(widget.mrp.toString()) - int.parse(widget.price.toString())}",
                        style: TextStyleConstant.regular18().copyWith(
                            color: ColorConstant.appMainColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Obx(
                        () => Text(
                          "Packaging: ${controller.packEcoFriendly.value == true ? "${int.parse(controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * 22}" : "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * 22}"}",
                          style: TextStyleConstant.regular18().copyWith(
                              color: ColorConstant.appMainColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        "Dilivery: 0",
                        style: TextStyleConstant.regular18().copyWith(
                            color: ColorConstant.appMainColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Obx(() => controller.onSaturday.value == true ||
                              controller.onSunday.value == true
                          ? Text(
                              "Weekend Tiffins: ${controller.count.toString()}",
                              style: TextStyleConstant.regular18().copyWith(
                                  color: ColorConstant.appMainColor,
                                  fontWeight: FontWeight.w400),
                            )
                          : const SizedBox()),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.4, top: 10, bottom: 10),
                        child: const HorizontalDottedLine(),
                      ),
                      Obx(
                        () => Text(
                          "Sub Total: ${controller.totalCount.value}",
                          style: TextStyleConstant.regular18().copyWith(
                              color: ColorConstant.appMainColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.4, top: 10, bottom: 10),
                        child: const HorizontalDottedLine(),
                      ),
                      height10,
                      GestureDetector(
                        onTap: () {
                          controller.postOrder(
                              cartId: widget.cartId,
                              categoryName: widget.categoryName,
                              subCategoryName: widget.subCategoryName,
                              productName: widget.productName,
                              productCode: widget.productCode,
                              price: widget.price,
                              amount: widget.price,
                              tax: widget.tax,
                              taxsGst: widget.taxsGst,
                              taxjGst: widget.taxjGst,
                              total: widget.total,
                              unit: widget.unit);
                          // Get.to(() => const ThankYouView(
                          //       isCancelOrder: false,
                          //     ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: Get.width * 0.5,
                          decoration: BoxDecoration(
                            color: primaryWhite,
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
                          child: Text(
                            "Place Order",
                            style: TextStyleConstant.regular16().copyWith(
                                color: ColorConstant.appMainColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      height20,
                    ],
                  ),
                )
                // priceWidget(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget priceWidget({required TifinBillingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Food Price: ${widget.mrp}",
          style: TextStyleConstant.regular18(color: ColorConstant.orange),
        ),
        Text(
          "Discount: ${int.parse(widget.mrp) - int.parse(widget.price)}",
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
          "Sub Total: ${widget.price}",
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
                total: widget.total,
                unit: widget.unit);
          },
        ),
      ],
    );
  }

  Future<void> selectDate(
      {required BuildContext context,
      required TifinBillingController controller}) async {
    controller.picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (controller.picked != null &&
        controller.picked != controller.selectedDate) {
      controller.selectedDate = controller.picked!;
      controller.convertedDate.value =
          DateFormat('yyyy-MM-dd').format(controller.selectedDate);
      controller.isSelected.value = true;
    }
  }
}

// ignore: must_be_immutable
class SelectVegetableWidget extends StatelessWidget {
  SelectVegetableWidget({super.key, required this.vegeTableList});

  RxInt selectedSabji = 0.obs;
  List vegeTableList;

  // BillingController controller = Get.find<BillingController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
              vegeTableList.length,
              (index) => Obx(
                    () => GestureDetector(
                      onTap: () {
                        selectedSabji.value = index;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: (selectedSabji != index)
                                        ? ColorConstant.orange.withOpacity(0.3)
                                        : ColorConstant.orange),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (selectedSabji != index)
                                      ? ColorConstant.orange.withOpacity(0.3)
                                      : ColorConstant.orange,
                                ),
                              ),
                            ),
                            Text(
                              vegeTableList[index].sabji,
                              style: TextStyleConstant.bold18(
                                  color: ColorConstant.orange),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  CustomRadioButton(
      {super.key, required this.buttonName, required this.isSelected});

  String? buttonName;
  RxBool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Container(
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
                color: isSelected!.value
                    ? ColorConstant.orange
                    : ColorConstant.orangeAccent,
              ),
            ),
          ),
        ),
        width10,
        Text(
          buttonName!,
          style: TextStyleConstant.regular16(color: ColorConstant.orangeAccent),
        )
      ],
    );
  }
}
