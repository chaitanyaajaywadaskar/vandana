import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/tifin_billing_controller.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import '../../../../Constant/static_decoration.dart';
import '../../../../Custom_Widgets/custom_button.dart';
import '../../../../Custom_Widgets/custom_textfield.dart';
import '../../../../Custom_Widgets/time_slote_widget.dart';
import '../../../../Models/get_add_on_item_cart_model.dart';

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
  final String satSunTiffinCount;

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
      required this.tifinCount,
      required this.subjiCount,
      required this.satSunTiffinCount});

  @override
  State<TifinBillingView> createState() => _TifinBillingViewState();
}

class _TifinBillingViewState extends State<TifinBillingView>
    with TickerProviderStateMixin {
  TabController? tabController;
  TabController? tabController2;

  TifinBillingController controller = Get.put(TifinBillingController());
  @override
  void initState() {
    super.initState();
    controller.satSunTiffinCount.value = int.parse(widget.satSunTiffinCount);
    controller.subjiCount.value = int.parse(widget.subjiCount);
    tabController = TabController(length: 7, vsync: this);
    tabController2 = TabController(length: 7, vsync: this);
    controller.initialFunctioun(
        weekendPrice: double.parse(widget.weekendPrice),
        tifinCount: widget.tifinCount,
        tifinPrice: widget.price,
        category: widget.categoryName);

    tabController?.addListener(() {
      controller.getSabjiListDaywiseForLunch(
        day: controller.daysName[int.parse('${tabController?.index}')],
      );
    });
    tabController2?.addListener(() {
      controller.getSabjiListDaywiseForDinner(
        day: controller.daysName[int.parse('${tabController2?.index}')],
      );
    });
  }

  calculateAddOn(GetAddOnItemCartModelAddonItemList? data) {
    bool isContain = controller.orderItemList.value.any((element) =>
        element['\"product_code\"'].toString() == '\"${data?.productCode}\"');
    if (!isContain) {
      print('Not contain');
      controller.orderItemList.value.add({
        '\"cartId\"': '\"${data?.itemAddCartid}\"',
        '\"category_name\"': '\"${data?.categoryName}\"',
        '\"subcategory_name\"': '\"${data?.subcategoryName}\"',
        '\"product_name\"': '\"${data?.productName}\"',
        '\"product_code\"': '\"${data?.productCode}\"',
        '\"quantity\"': '\"1\"',
        '\"price\"': '\"${data?.mrp}\"',
        '\"amount\"': '\"${data?.price}\"',
        '\"tax\"': '\"${int.parse(data?.tax ?? '0') / 2}\"',
        '\"tax_sgst\"': '\"${int.parse(data?.tax ?? '0') / 2}\"',
        '\"tax_igst\"': '\"\"',
        '\"total\"': '\"${data?.price}\"',
        '\"unit\"': '\"nos\"',
      });
      double totalCost = 0;
      if (controller.orderItemList.isNotEmpty) {
        for (var item in controller.orderItemList) {
          double price =
              double.parse(item['\"amount\"'].toString().replaceAll('"', ''));
          totalCost += price * 22;
        }
        controller.addOnPrice.value = '$totalCost';
      }
      if (controller.onSaturday.value == true &&
          controller.onSunday.value == true) {
      } else if (controller.onSaturday.value == true) {
      } else if (controller.onSunday.value == true) {}
      controller.packagingPrice.value =
          "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * (int.parse(widget.tifinCount) * (controller.orderItemList.length + 1))}";
      controller.calculateTotal(widget.price);
      // print(
      //     'pp:-${controller.packagingPrice.value} ${}');
    } else {
      controller.orderItemList.value.removeWhere((element) =>
          element['\"product_code\"'].toString() == '\"${data?.productCode}\"');
      double totalCost = 0;

      if (controller.orderItemList.isNotEmpty) {
        for (var item in controller.orderItemList) {
          double price =
              double.parse(item['\"amount\"'].toString().replaceAll('"', ''));
          totalCost += price * 22;
        }
        controller.addOnPrice.value = '$totalCost';
      } else {
        controller.addOnPrice.value = '0';
      }

      controller.packagingPrice.value =
          "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * (int.parse(widget.tifinCount) * (controller.orderItemList.length + 1))}";
      controller.calculateTotal(widget.price);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGround,
      appBar: const CustomAppBar(title: "Tiffin Billing"),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.productName,
                              style: TextStyleConstant.semiBold26(
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
                                controller
                                    .getAddressListTypewise('Home')
                                    .then((val) {
                                  val != null && val.statusCode == '200'
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: Get.height,
                                              width: Get.width,
                                              child: AlertDialog(
                                                backgroundColor:
                                                    ColorConstant.backGround,
                                                title: Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        icon: const Icon(
                                                            Icons.arrow_back)),
                                                    const Text(
                                                        "Select Address"),
                                                  ],
                                                ),
                                                content: SizedBox(
                                                  height: Get.height,
                                                  width: Get.width,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Obx(() {
                                                        return SizedBox(
                                                          height:
                                                              Get.height * 0.65,
                                                          child:
                                                              ListView.builder(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            itemCount: controller
                                                                .getAddressListTypeModel
                                                                .value
                                                                .typewiseAddressList
                                                                ?.length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Card(
                                                                child: ListTile(
                                                                  onTap:
                                                                      () async {
                                                                    controller
                                                                        .isLunchOfficeSelected
                                                                        .value = false;
                                                                    controller
                                                                        .isLunchHomeSelected
                                                                        .value = true;
                                                                    controller
                                                                            .addressLunchId
                                                                            .value =
                                                                        "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.id}";
                                                                    print(
                                                                        "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.id}");
                                                                    Get.back();
                                                                  },
                                                                  title: Text(
                                                                      "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.address}"),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : customToast(
                                          message: 'No address found');
                                });
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
                                controller
                                    .getAddressListTypewise('Office')
                                    .then((val) {
                                  val != null && val.statusCode == '200'
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: Get.height,
                                              width: Get.width,
                                              child: AlertDialog(
                                                backgroundColor:
                                                    ColorConstant.backGround,
                                                title: Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        icon: const Icon(
                                                            Icons.arrow_back)),
                                                    const Text(
                                                        "Select Address"),
                                                  ],
                                                ),
                                                content: SizedBox(
                                                  height: Get.height,
                                                  width: Get.width,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Obx(() {
                                                        return SizedBox(
                                                          height:
                                                              Get.height * 0.65,
                                                          child:
                                                              ListView.builder(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            itemCount: controller
                                                                .getAddressListTypeModel
                                                                .value
                                                                .typewiseAddressList
                                                                ?.length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Card(
                                                                child: ListTile(
                                                                  onTap:
                                                                      () async {
                                                                    controller
                                                                        .isLunchOfficeSelected
                                                                        .value = true;
                                                                    controller
                                                                        .isLunchHomeSelected
                                                                        .value = false;
                                                                    controller
                                                                            .addressLunchId
                                                                            .value =
                                                                        "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.id}";
                                                                    Get.back();
                                                                  },
                                                                  title: Text(
                                                                      "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.address}"),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : customToast(
                                          message: 'No address found');
                                });
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
                                controller
                                    .getAddressListTypewise('Home')
                                    .then((val) {
                                  val != null && val.statusCode == '200'
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: Get.height,
                                              width: Get.width,
                                              child: AlertDialog(
                                                backgroundColor:
                                                    ColorConstant.backGround,
                                                title: Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        icon: const Icon(
                                                            Icons.arrow_back)),
                                                    const Text(
                                                        "Select Address"),
                                                  ],
                                                ),
                                                content: SizedBox(
                                                  height: Get.height,
                                                  width: Get.width,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Obx(() {
                                                        return SizedBox(
                                                          height:
                                                              Get.height * 0.65,
                                                          child:
                                                              ListView.builder(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            itemCount: controller
                                                                .getAddressListTypeModel
                                                                .value
                                                                .typewiseAddressList
                                                                ?.length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Card(
                                                                child: ListTile(
                                                                  onTap:
                                                                      () async {
                                                                    controller
                                                                        .isDinnerHomeSelected
                                                                        .value = true;
                                                                    controller
                                                                        .isDinnerOfficeSelected
                                                                        .value = false;
                                                                    controller
                                                                            .addressDinnerId
                                                                            .value =
                                                                        "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.id}";
                                                                    print(
                                                                        "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.id}");
                                                                    Get.back();
                                                                  },
                                                                  title: Text(
                                                                      "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.address}"),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : customToast(
                                          message: 'No address found');
                                });
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
                                controller
                                    .getAddressListTypewise('Office')
                                    .then((val) {
                                  val != null && val.statusCode == '200'
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: Get.height,
                                              width: Get.width,
                                              child: AlertDialog(
                                                backgroundColor:
                                                    ColorConstant.backGround,
                                                title: Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        icon: const Icon(
                                                            Icons.arrow_back)),
                                                    const Text(
                                                        "Select Address"),
                                                  ],
                                                ),
                                                content: SizedBox(
                                                  height: Get.height,
                                                  width: Get.width,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Obx(() {
                                                        return SizedBox(
                                                          height:
                                                              Get.height * 0.65,
                                                          child:
                                                              ListView.builder(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            itemCount: controller
                                                                .getAddressListTypeModel
                                                                .value
                                                                .typewiseAddressList
                                                                ?.length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Card(
                                                                child: ListTile(
                                                                  onTap:
                                                                      () async {
                                                                    controller
                                                                        .isDinnerHomeSelected
                                                                        .value = false;
                                                                    controller
                                                                        .isDinnerOfficeSelected
                                                                        .value = true;
                                                                    controller
                                                                            .addressDinnerId
                                                                            .value =
                                                                        "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.id}";
                                                                    print(
                                                                        "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.id}");
                                                                    Get.back();
                                                                  },
                                                                  title: Text(
                                                                      "${controller.getAddressListTypeModel.value.typewiseAddressList?[index]?.address}"),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : customToast(
                                          message: 'No address found');
                                });
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
                Obx(() {
                  if (controller.tiffinTypeLunch.value) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height20,
                        const HorizontalDottedLine(),
                        height20,
                        Text(
                          "Please Select Subji For Lunch",
                          style: TextStyleConstant.regular22(
                              color: ColorConstant.orange),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.010,
                              bottom: Get.height * 0.020),
                          child: DefaultTabController(
                            length: 7,
                            child: TabBar(
                              controller: tabController,
                              labelColor: ColorConstant.orange,
                              isScrollable: true,
                              tabs: [
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForLunch(
                                      day: controller.daysName[0],
                                    );
                                    tabController?.animateTo(0);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[0].day}"),
                                          Text(
                                              " - ${controller.next7Days[0].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[0]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForLunch(
                                      day: controller.daysName[1],
                                    );
                                    tabController?.animateTo(1);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[1].day}"),
                                          Text(
                                              " - ${controller.next7Days[1].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[1]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForLunch(
                                      day: controller.daysName[2],
                                    );
                                    tabController?.animateTo(2);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[2].day}"),
                                          Text(
                                              " - ${controller.next7Days[2].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[2]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForLunch(
                                      day: controller.daysName[3],
                                    );
                                    tabController?.animateTo(3);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[3].day}"),
                                          Text(
                                              " - ${controller.next7Days[3].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[3]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForLunch(
                                      day: controller.daysName[4],
                                    );
                                    tabController?.animateTo(4);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[4].day}"),
                                          Text(
                                              " - ${controller.next7Days[4].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[4]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForLunch(
                                      day: controller.daysName[5],
                                    );
                                    tabController?.animateTo(5);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[5].day}"),
                                          Text(
                                              " - ${controller.next7Days[5].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[5]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForLunch(
                                      day: controller.daysName[6],
                                    );
                                    tabController?.animateTo(6);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[6].day}"),
                                          Text(
                                              " - ${controller.next7Days[6].month}"),
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
                            return TabBarView(
                                controller: tabController,
                                children: [
                                  // Content for Monday
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseLunchModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.lunchSubjiList1,
                                    date: formatDate(
                                        controller.next7Days[0].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseLunchModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.lunchSubjiList2,
                                    date: formatDate(
                                        controller.next7Days[1].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseLunchModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.lunchSubjiList3,
                                    date: formatDate(
                                        controller.next7Days[2].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseLunchModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.lunchSubjiList4,
                                    date: formatDate(
                                        controller.next7Days[3].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseLunchModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.lunchSubjiList5,
                                    date: formatDate(
                                        controller.next7Days[4].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseLunchModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.lunchSubjiList6,
                                    date: formatDate(
                                        controller.next7Days[5].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseLunchModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.lunchSubjiList7,
                                    date: formatDate(
                                        controller.next7Days[6].toString()),
                                  ),
                                ]);
                          }),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
                //Dinner lunch
                Obx(() {
                  if (controller.tiffinTypeDinner.value) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height20,
                        const HorizontalDottedLine(),
                        height20,
                        Text(
                          "Please Select Subji For Dinner",
                          style: TextStyleConstant.regular22(
                              color: ColorConstant.orange),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.010,
                              bottom: Get.height * 0.020),
                          child: DefaultTabController(
                            length: 7,
                            child: TabBar(
                              controller: tabController2,
                              labelColor: ColorConstant.orange,
                              isScrollable: true,
                              tabs: [
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForDinner(
                                      day: controller.daysName[0],
                                    );
                                    tabController2?.animateTo(0);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[0].day}"),
                                          Text(
                                              " - ${controller.next7Days[0].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[0]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForDinner(
                                      day: controller.daysName[1],
                                    );
                                    tabController2?.animateTo(1);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[1].day}"),
                                          Text(
                                              " - ${controller.next7Days[1].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[1]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForDinner(
                                      day: controller.daysName[2],
                                    );
                                    tabController2?.animateTo(2);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[2].day}"),
                                          Text(
                                              " - ${controller.next7Days[2].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[2]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForDinner(
                                      day: controller.daysName[3],
                                    );
                                    tabController2?.animateTo(3);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[3].day}"),
                                          Text(
                                              " - ${controller.next7Days[3].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[3]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForDinner(
                                      day: controller.daysName[4],
                                    );
                                    tabController2?.animateTo(4);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[4].day}"),
                                          Text(
                                              " - ${controller.next7Days[4].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[4]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForDinner(
                                      day: controller.daysName[5],
                                    );
                                    tabController2?.animateTo(5);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[5].day}"),
                                          Text(
                                              " - ${controller.next7Days[5].month}"),
                                        ],
                                      ),
                                      Tab(text: controller.daysName[5]),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getSabjiListDaywiseForDinner(
                                      day: controller.daysName[6],
                                    );
                                    tabController2?.animateTo(6);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${controller.next7Days[6].day}"),
                                          Text(
                                              " - ${controller.next7Days[6].month}"),
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
                            return TabBarView(
                                controller: tabController2,
                                children: [
                                  // Content for Monday
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseDinnerModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.dinnerSubjiList1,
                                    date: formatDate(
                                        controller.next7Days[0].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseDinnerModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.dinnerSubjiList2,
                                    date: formatDate(
                                        controller.next7Days[1].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseDinnerModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.dinnerSubjiList3,
                                    date: formatDate(
                                        controller.next7Days[2].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseDinnerModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.dinnerSubjiList4,
                                    date: formatDate(
                                        controller.next7Days[3].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseDinnerModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.dinnerSubjiList5,
                                    date: formatDate(
                                        controller.next7Days[4].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseDinnerModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.dinnerSubjiList6,
                                    date: formatDate(
                                        controller.next7Days[5].toString()),
                                  ),
                                  SelectVegetableWidget(
                                    vegeTableList: controller
                                            .getSabjiListDaywiseDinnerModel
                                            .value
                                            .sabjiList ??
                                        [],
                                    storageList: controller.dinnerSubjiList7,
                                    date: formatDate(
                                        controller.next7Days[6].toString()),
                                  ),
                                ]);
                          }),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),

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
                            price: int.parse(widget.weekendPrice.toString()),
                            tiffinCount: widget.tifinCount);
                        controller.calculateTotal(widget.price);

                        print(
                            "Count check ==> ${controller.weekendTiffinCalculatedPrice.toString()}");
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
                              price: int.parse(widget.weekendPrice.toString()),
                              tiffinCount: widget.tifinCount);
                          controller.calculateTotal(widget.price);

                          // controller.getTotalCount(
                          //     tiffinCount: widget.tifinCount,
                          //     tiffinPrice: widget.price,
                          //     ecoFriendly: controller.getPackagingListModel
                          //             .value.packagingList?[1].packagingPrice ??
                          //         '0',
                          //     regular: controller.getPackagingListModel.value
                          //             .packagingList?[0].packagingPrice ??
                          //         '0');
                          print(
                              "Count check ==> ${controller.weekendTiffinCalculatedPrice.toString()}");
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

                      controller.packagingPrice.value = controller
                                  .packEcoFriendly.value ==
                              true
                          ? "${int.parse(controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * int.parse(widget.tifinCount)}"
                          : "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * int.parse(widget.tifinCount)}";
                      controller.calculateTotal(widget.price);
                      // controller.getTotalCount(
                      //     tiffinCount: widget.tifinCount,
                      //     tiffinPrice: widget.price,
                      //     ecoFriendly: controller.getPackagingListModel.value
                      //             .packagingList?[1].packagingPrice ??
                      //         '0',
                      //     regular: controller.packagingPrice.value);
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
                          ? "${int.parse(controller.getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * int.parse(widget.tifinCount)}"
                          : "${int.parse(controller.getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * int.parse(widget.tifinCount)}";
                      controller.calculateTotal(widget.price);

                      // controller.getTotalCount(
                      //     tiffinCount: widget.tifinCount,
                      //     tiffinPrice: widget.price,
                      //     ecoFriendly: controller.packagingPrice.value,
                      //     regular: controller.getPackagingListModel.value
                      //             .packagingList?[0].packagingPrice ??
                      //         '0');
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
                      itemCount: controller
                          .getAddOnItemModel.value.addonItemList?.length,
                      itemBuilder: (context, index) {
                        var data = controller
                            .getAddOnItemModel.value.addonItemList?[index];
                        return Padding(
                          padding: contentVerticalPadding,
                          child: Container(
                            padding: contentPadding,
                            width: 150,
                            margin: const EdgeInsets.only(right: 15),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  maxRadius: 30,
                                  backgroundImage:
                                      NetworkImage("${data?.productImage1}"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: contentWidthPadding),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.37,
                                        child: Text(
                                          data?.productName ?? '',
                                          style: TextStyleConstant.semiBold18(
                                              color: ColorConstant.orange),
                                        ),
                                      ),
                                      Text(
                                        "Price: ₹${data?.price ?? ''}",
                                        style: TextStyleConstant.semiBold14(
                                            color: ColorConstant.orange),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: Get.height * 0.020),
                                  child: CustomButton(
                                    onTap: () {
                                      calculateAddOn(data);
                                    },
                                    title: controller.orderItemList.value.any(
                                            (element) =>
                                                element['\"product_code\"']
                                                    .toString() ==
                                                '\"${data?.productCode}\"')
                                        ? "Added"
                                        : "Add on Item",
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
                height20,
                SizedBox(
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        fillColor: Colors.grey.withOpacity(0.4),
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
                      Text(
                        "Coupon: ${controller.discountInCart.value}",
                        style: TextStyleConstant.regular18(
                            color: ColorConstant.orange),
                      ),
                      Text(
                        "Tax: ${widget.tax}%",
                        style: TextStyleConstant.regular18(
                            color: ColorConstant.orange),
                      ),
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
                          "Dilivery: ${controller.getDeliveryChargesModel.value.dcList?[0]?.deliveryChargesAmt ?? '0'}",
                          style: TextStyleConstant.regular18().copyWith(
                              color: ColorConstant.appMainColor,
                              fontWeight: FontWeight.w400),
                        );
                      }),
                      Obx(() => controller.onSaturday.value == true ||
                              controller.onSunday.value == true
                          ? Text(
                              "Weekend Tiffins: ${controller.weekendTiffinCalculatedPrice.toString()}",
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
                          if (controller.selectedLunchTime.value
                              .contains("Select Time")) {
                            customToast(message: 'Please select a lunch time');
                          } else if (controller.addressLunchId.value.isEmpty) {
                            customToast(message: 'Please select a address');
                          } else {
                            controller.postOrder(
                                cartId: widget.cartId,
                                categoryName: widget.categoryName,
                                subCategoryName: widget.subCategoryName,
                                productName: widget.productName,
                                productCode: widget.productCode,
                                price: widget.price,
                                amount: widget.price,
                                tax: widget.taxjGst,
                                taxsGst: widget.taxsGst,
                                taxjGst: widget.taxjGst,
                                total: widget.total,
                                unit: widget.unit,
                                tiffinCount: widget.tifinCount);
                          }
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

  // Widget priceWidget({required TifinBillingController controller}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: [
  //       Text(
  //         "Food Price: ${widget.mrp}",
  //         style: TextStyleConstant.regular18(color: ColorConstant.orange),
  //       ),
  //       Text(
  //         "Discount: ${int.parse(widget.mrp) - int.parse(widget.price)}",
  //         style: TextStyleConstant.regular18(color: ColorConstant.orange),
  //       ),
  //       Obx(() {
  //         return Text(
  //           "Delivery: ${controller.getDeliveryChargesModel.value.dcList?[0]?.deliveryChargesAmt}",
  //           style: TextStyleConstant.regular18(color: ColorConstant.orange),
  //         );
  //       }),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             left: Get.width * 0.500,
  //             bottom: Get.height * 0.010,
  //             top: Get.height * 0.020),
  //         child: const HorizontalDottedLine(),
  //       ),
  //       Text(
  //         "Sub Total: ${widget.price}",
  //         style: TextStyleConstant.regular18(color: ColorConstant.orange),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             left: Get.width * 0.500,
  //             top: Get.height * 0.010,
  //             bottom: Get.height * 0.020),
  //         child: const HorizontalDottedLine(),
  //       ),
  //       CustomButton(
  //         title: "Place Order",
  //         width: Get.width * 0.400,
  //         onTap: () {
  //           controller.postOrder(
  //               cartId: widget.cartId,
  //               categoryName: widget.categoryName,
  //               subCategoryName: widget.subCategoryName,
  //               productName: widget.productName,
  //               productCode: widget.productCode,
  //               price: widget.price,
  //               amount: widget.mrp,
  //               tax: widget.tax,
  //               taxsGst: widget.taxsGst,
  //               taxjGst: widget.taxjGst,
  //               total: widget.total,
  //               unit: widget.unit);
  //         },
  //       ),
  //     ],
  //   );
  // }

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
class SelectVegetableWidget extends StatefulWidget {
  SelectVegetableWidget(
      {super.key,
      required this.vegeTableList,
      required this.storageList,
      this.date});
  List vegeTableList;
  RxList<Map<String, String>> storageList;
  String? date;

  @override
  State<SelectVegetableWidget> createState() => _SelectVegetableWidgetState();
}

class _SelectVegetableWidgetState extends State<SelectVegetableWidget> {
  TifinBillingController controller = Get.find<TifinBillingController>();

  Color getColor(int index) {
    return widget.storageList.any(
                (item) => item['sId'] == "${widget.vegeTableList[index].id}") !=
            true
        ? ColorConstant.orange.withOpacity(0.3)
        : ColorConstant.orange;
  }

  void addToStorageList(int index) {
    String sId = widget.vegeTableList[index].id;

    bool containsData =
        widget.storageList.any((element) => element["sId"] == sId);

    if (containsData) {
      widget.storageList.removeWhere((element) => element["sId"] == sId);
    } else {
      if (widget.storageList.length < controller.subjiCount.value) {
        widget.storageList.add({
          "sId": widget.vegeTableList[index].id,
          "day": widget.vegeTableList[index].day,
          "sabji": widget.vegeTableList[index].sabji,
          "tiffin_type": widget.vegeTableList[index].tiffinType,
          "date": widget.date ?? ''
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
              widget.vegeTableList.length,
              (index) => Obx(
                    () => GestureDetector(
                      onTap: () {
                        addToStorageList(index);

                        setState(() {});
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
                                border: Border.all(color: getColor(index)),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: getColor(index)),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.vegeTableList[index].sabji,
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

// ignore: must_be_immutable
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

String formatDate(String date) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  return formattedDate;
}
