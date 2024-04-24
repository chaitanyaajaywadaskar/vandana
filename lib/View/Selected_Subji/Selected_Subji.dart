import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constant/color_constant.dart';
import '../../Constant/layout_constant.dart';
import '../../Constant/static_decoration.dart';
import '../../Constant/textstyle_constant.dart';
import '../../Controllers/tiffin_subji_controller.dart';
import '../../Custom_Widgets/custom_appbar.dart';
import '../../Custom_Widgets/custom_dotted_line.dart';
import '../Bottombar_Section/Home_Section/Tifin_Section/tifin_billing_view.dart';

class SelectedSubjiView extends StatefulWidget {
  const SelectedSubjiView(
      {super.key, required this.subjiCount, required this.soNumber});

  final int subjiCount;
  final String soNumber;
  @override
  State<SelectedSubjiView> createState() => _SelectedSubjiViewState();
}

class _SelectedSubjiViewState extends State<SelectedSubjiView>
    with TickerProviderStateMixin {
  TabController? tabController;
  TabController? tabController2;
  TifinSubjiController controller = Get.put(TifinSubjiController());
  @override
  void initState() {
    super.initState();
    controller.subjiCount.value = widget.subjiCount;
    controller.initialFunctioun();
    controller.getOrderPlaceSubjiList(
      soNo: widget.soNumber,
    );
    tabController = TabController(length: 7, vsync: this);
    tabController2 = TabController(length: 7, vsync: this);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGround,
      appBar: const CustomAppBar(title: "Update Subji"),
      body: Padding(
        padding: screenPadding,
        child: SingleChildScrollView(
          child: Column(
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
                  GestureDetector(
                      onTap: () {
                        controller.tiffinTypeLunch.value =
                            !controller.tiffinTypeLunch.value;
                        controller.tiffinType.value = 'Lunch';
                      },
                      child: CustomRadioButton(
                          buttonName: "Lunch",
                          isSelected: controller.tiffinTypeLunch)),
                  height10,
                  GestureDetector(
                      onTap: () {
                        controller.tiffinTypeDinner.value =
                            !controller.tiffinTypeDinner.value;
                        controller.tiffinType.value = 'Dinner';
                        controller.getOrderPlaceSubjiList(
                            soNo: widget.soNumber, tiffinType: 'Dinner');
                      },
                      child: CustomRadioButton(
                          buttonName: "Dinner",
                          isSelected: controller.tiffinTypeDinner)),
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
                                        Text("${controller.next7Days[0].day}"),
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
                                        Text("${controller.next7Days[1].day}"),
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
                                        Text("${controller.next7Days[2].day}"),
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
                                        Text("${controller.next7Days[3].day}"),
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
                                        Text("${controller.next7Days[4].day}"),
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
                                        Text("${controller.next7Days[5].day}"),
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
                                        Text("${controller.next7Days[6].day}"),
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
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseLunchModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.lunchSubjiList1,
                                  date: formatDate(
                                      controller.next7Days[0].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseLunchModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.lunchSubjiList2,
                                  date: formatDate(
                                      controller.next7Days[1].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseLunchModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.lunchSubjiList3,
                                  date: formatDate(
                                      controller.next7Days[2].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseLunchModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.lunchSubjiList4,
                                  date: formatDate(
                                      controller.next7Days[3].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseLunchModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.lunchSubjiList5,
                                  date: formatDate(
                                      controller.next7Days[4].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseLunchModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.lunchSubjiList6,
                                  date: formatDate(
                                      controller.next7Days[5].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseLunchModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.lunchSubjiList7,
                                  date: formatDate(
                                      controller.next7Days[6].toString()),
                                  subjiCount: widget.subjiCount,
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
                                        Text("${controller.next7Days[0].day}"),
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
                                        Text("${controller.next7Days[1].day}"),
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
                                        Text("${controller.next7Days[2].day}"),
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
                                        Text("${controller.next7Days[3].day}"),
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
                                        Text("${controller.next7Days[4].day}"),
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
                                        Text("${controller.next7Days[5].day}"),
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
                                        Text("${controller.next7Days[6].day}"),
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
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseDinnerModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.dinnerSubjiList1,
                                  date: formatDate(
                                      controller.next7Days[0].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseDinnerModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.dinnerSubjiList2,
                                  date: formatDate(
                                      controller.next7Days[1].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseDinnerModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.dinnerSubjiList3,
                                  date: formatDate(
                                      controller.next7Days[2].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseDinnerModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.dinnerSubjiList4,
                                  date: formatDate(
                                      controller.next7Days[3].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseDinnerModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.dinnerSubjiList5,
                                  date: formatDate(
                                      controller.next7Days[4].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseDinnerModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.dinnerSubjiList6,
                                  date: formatDate(
                                      controller.next7Days[5].toString()),
                                  subjiCount: widget.subjiCount,
                                ),
                                SelectVegetablesCard(
                                  vegeTableList: controller
                                          .getSabjiListDaywiseDinnerModel
                                          .value
                                          .sabjiList ??
                                      [],
                                  storageList: controller.dinnerSubjiList7,
                                  date: formatDate(
                                      controller.next7Days[6].toString()),
                                  subjiCount: widget.subjiCount,
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
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: Get.width * 0.45,
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
                  child: Text(
                    "Update",
                    style: TextStyleConstant.regular18(
                        color: ColorConstant.orange),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectVegetablesCard extends StatefulWidget {
  SelectVegetablesCard(
      {super.key,
      required this.vegeTableList,
      required this.storageList,
      required this.subjiCount,
      this.date});
  List vegeTableList;
  RxList<Map<String, String>> storageList;
  String? date;
  int subjiCount;
  @override
  State<SelectVegetablesCard> createState() => _SelectVegetableWidgetState();
}

class _SelectVegetableWidgetState extends State<SelectVegetablesCard> {
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
    print('Contains:- $containsData');
    if (containsData) {
      widget.storageList.removeWhere((element) => element["sId"] == sId);
    } else {
      if (widget.storageList.length < widget.subjiCount) {
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
