import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vandana/Services/http_services.dart';

import '../Custom_Widgets/custom_loader.dart';
import '../Models/get_packaging_list_model.dart';
import '../Models/get_time_slot_model.dart';

class BillingController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    findRemainingWeekendDays();
  }

  ScrollController billingScrollController = ScrollController();
  RxDouble shrinkprogress = 0.0.obs;
  RxBool timeSloteTimeSlectionOne = false.obs;
  RxBool timeSloteTimeSlectionTow = false.obs;
  RxBool timeSloteTimeSlectionThree = false.obs;

  RxBool timeNightSloteTimeSlectionOne = false.obs;
  RxBool timeNightSloteTimeSlectionTow = false.obs;
  RxBool timeNightSloteTimeSlectionThree = false.obs;

  //! MAIN BILLING SCREEN

  // TIFFIN TYPE
  RxBool tiffinTypeLunch = false.obs;
  RxBool tiffinTypeDinner = false.obs;

  // WEEKEND CHOICE
  RxBool onSaturday = false.obs;
  RxBool onSunday = false.obs;

  //PACKAGING
  RxBool packRagular = true.obs;
  RxBool packEcoFrindly = false.obs;

  ifRegularSelected() {
    packRagular.value = true;
    packEcoFrindly.value = false;
  }

  isEcoFriendly() {
    packRagular.value = false;
    packEcoFrindly.value = true;
  }

  //ADDRESS
  RxBool atHome = false.obs;
  RxBool atOffice = false.obs;

  ifSelectHome() {
    atHome.value = true;
    atHome.value = false;
  }

  isSelectOffice() {
    atHome.value = false;
    atOffice.value = true;
  }

  ifFirstSelected() {
    timeSloteTimeSlectionOne.value = true;
    timeSloteTimeSlectionTow.value = false;
    timeSloteTimeSlectionThree.value = false;
    Get.back();
  }

  ifSecondSelected() {
    timeSloteTimeSlectionOne.value = false;
    timeSloteTimeSlectionTow.value = true;
    timeSloteTimeSlectionThree.value = false;
    Get.back();
  }

  ifThirdSeletcted() {
    timeSloteTimeSlectionOne.value = false;
    timeSloteTimeSlectionTow.value = false;
    timeSloteTimeSlectionThree.value = true;
    Get.back();
  }

  ifNightFirstSelected() {
    timeNightSloteTimeSlectionOne.value = true;
    timeNightSloteTimeSlectionTow.value = false;
    timeNightSloteTimeSlectionThree.value = false;
    Get.back();
  }

  ifNightSecondSelected() {
    timeNightSloteTimeSlectionOne.value = false;
    timeNightSloteTimeSlectionTow.value = true;
    timeNightSloteTimeSlectionThree.value = false;
    Get.back();
  }

  ifNightThirdSeletcted() {
    timeNightSloteTimeSlectionOne.value = false;
    timeNightSloteTimeSlectionTow.value = false;
    timeNightSloteTimeSlectionThree.value = true;
    Get.back();
  }

  RxBool isLunchHomeSelected = true.obs;
  RxBool isLunchOfficeSelected = false.obs;
  RxBool isDinnerHomeSelected = true.obs;
  RxBool isDinnerOfficeSelected = false.obs;

  //! SELCET VEGETABLE WIDGET
  RxList vegeTableList = [
    "Palak Paneer",
    "Palak Paneer Matar",
    "Paneer Methi Palak",
    "Matar Ki Sabzi",
    "Dry Aloo Matar",
    "Malay Kofta"
  ].obs;

  List saturdayList = [];
  List sundayList = [];

  RxDouble count = 0.0.obs;
  RxInt totalCount = 0.obs;

  getTotalCount(
      {String? tiffinPrice,
      String? ecoFriendly,
      String? regular,
      String? tiffinCount}) {
    int tiffinPrice1 = int.parse(tiffinPrice.toString());
    int ecoFriendly1 = packEcoFrindly.value == true
        ? int.parse(ecoFriendly!)
        : int.parse(regular!);

    totalCount.value = tiffinPrice1 + ecoFriendly1 + count.toInt();
    print("check all count ==> ${totalCount.value}");
  }

  getWeekendCount(price) {
    if (onSaturday.value == true && onSunday.value == true) {
      count.value = price * 4;
    } else if (onSaturday.value == true) {
      count.value = (price / 2) * 4;
    } else if (onSunday.value == true) {
      count.value = (price / 2) * 4;
    } else {
      count.value = (price / 2) * 4;
    }
  }

  void findRemainingWeekendDays() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    int remainingDays = lastDayOfMonth.day - now.day + 1;

    for (int i = 0; i < remainingDays; i++) {
      DateTime currentDate = firstDayOfMonth.add(Duration(days: i));
      if (currentDate.weekday == DateTime.saturday) {
        onSaturday.value == true ? saturdayList.add(currentDate) : null;
      }
    }

    for (int i = 0; i < remainingDays; i++) {
      DateTime currentDate = firstDayOfMonth.add(Duration(days: i));
      if (currentDate.weekday == DateTime.sunday) {
        onSunday.value == true ? sundayList.add(currentDate) : null;
      }
    }
    print("Get remaining Weekends ${saturdayList.length}");
    print("Get remaining Weekends ${sundayList.length}");
  }

  RxInt selectedSabji = 0.obs;

  Rx<GetPakagingDataModel> getpackagingDataModel = GetPakagingDataModel().obs;

  Future getpackagingData() async {
    // CustomLoader.openCustomLoader();

    var response = await HttpServices.getHttpMethod(
      url: "https://softhubtechno.com/cloud_kitchen/api/packaging_list.php",
    );

    log("Get PAChaging response ::: $response");

    getpackagingDataModel.value =
        getPakagingDataModelFromJson(response['body']);

    try {
      if (getpackagingDataModel.value.statusCode == "200" ||
          getpackagingDataModel.value.statusCode == "201") {
        // CustomLoader.closeCustomLoader();
        // Your Statement
      } else {
        // CustomLoader.closeCustomLoader();
        log("Something went wrong during getting category list ::: ${getpackagingDataModel.value.message}");
        // Your Message
      }
    } catch (e, st) {
      // CustomLoader.closeCustomLoader();
      log("Something went wrong during getting category list ::: $e");
      log("Error location during getting category list ::: $st");
    }
  }

  Rx<GetTimeSlotModel> getTimeSlotModel = GetTimeSlotModel().obs;
  RxString selectedLunchTime = "Select Time".obs;
  RxString selectedDinnerTime = "Select Time".obs;

  Future getTimeSlot(fromLunch) async {
    CustomLoader.openCustomLoader();
    Map<String, String> myPayload = {
      "tiffin_type": fromLunch ? "Lunch" : "Dinner"
    };

    var response = await HttpServices.postHttpMethod(
        url: "https://softhubtechno.com/cloud_kitchen/api/timeslot.php",
        payload: myPayload);

    log("Get Time slot response ::: $response");

    getTimeSlotModel.value = getTimeSlotModelFromJson(response['body']);

    try {
      if (getTimeSlotModel.value.statusCode == "200" ||
          getTimeSlotModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        // Your Statement
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting Time slote list ::: ${getTimeSlotModel.value.message}");
        // Your Message
      }
    } catch (e, st) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting category list ::: $e");
      log("Error location during getting category list ::: $st");
    }
  }
}
