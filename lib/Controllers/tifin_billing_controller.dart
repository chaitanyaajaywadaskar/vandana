import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Controllers/get_packaging_list_model.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Models/get_delivery_charges_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/thank_you_view.dart';
import '../Models/get_address_list_typewise_model.dart';
import '../Models/get_sabjilist_daywise.dart';
import '../Models/get_time_slot_model.dart';
import '../Models/post_coupon_model.dart.dart';
import '../Models/post_tiffin_order_model.dart';

class TifinBillingController extends GetxController {
  PostTIffinOrderModel postOrderModel = PostTIffinOrderModel();
  final getPackagingListModel = GetPackagingListModel().obs;
  final getSabjiListDaywiseLunchModel = GetSabjiListDaywiseModel().obs;
  final getSabjiListDaywiseDinnerModel = GetSabjiListDaywiseModel().obs;

  RxList orderItemList = [].obs;
  RxList<DateTime> next7Days = <DateTime>[].obs;
  RxList<String> daysName = <String>[].obs;
  PostCouponModel postCouponModel = PostCouponModel();

//Day wise list for lunch
  RxList<Map<String, String>> lunchSubjiList1 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> lunchSubjiList2 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> lunchSubjiList3 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> lunchSubjiList4 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> lunchSubjiList5 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> lunchSubjiList6 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> lunchSubjiList7 = <Map<String, String>>[].obs;

  //Day wise list for Dinner
  RxList<Map<String, String>> dinnerSubjiList1 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> dinnerSubjiList2 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> dinnerSubjiList3 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> dinnerSubjiList4 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> dinnerSubjiList5 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> dinnerSubjiList6 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> dinnerSubjiList7 = <Map<String, String>>[].obs;

  clearAllSubjiListFeilds({bool isLunch = true}) {
    if (isLunch) {
      lunchSubjiList1.clear();
      lunchSubjiList2.clear();
      lunchSubjiList3.clear();
      lunchSubjiList4.clear();
      lunchSubjiList5.clear();
      lunchSubjiList6.clear();
      lunchSubjiList7.clear();
    } else {
      dinnerSubjiList1.clear();
      dinnerSubjiList2.clear();
      dinnerSubjiList3.clear();
      dinnerSubjiList4.clear();
      dinnerSubjiList5.clear();
      dinnerSubjiList6.clear();
      dinnerSubjiList7.clear();
    }
  }

  void addLunchSubjiLists() {
    lunchSubjiList.addAll(lunchSubjiList1);
    lunchSubjiList.addAll(lunchSubjiList2);
    lunchSubjiList.addAll(lunchSubjiList3);
    lunchSubjiList.addAll(lunchSubjiList4);
    lunchSubjiList.addAll(lunchSubjiList5);
    lunchSubjiList.addAll(lunchSubjiList6);
    lunchSubjiList.addAll(lunchSubjiList7);
    log('Lunch $lunchSubjiList');
  }

  void addDinnerSubjiLists() {
    dinnerSubjiList.addAll(dinnerSubjiList1);
    dinnerSubjiList.addAll(dinnerSubjiList2);
    dinnerSubjiList.addAll(dinnerSubjiList3);
    dinnerSubjiList.addAll(dinnerSubjiList4);
    dinnerSubjiList.addAll(dinnerSubjiList5);
    dinnerSubjiList.addAll(dinnerSubjiList6);
    dinnerSubjiList.addAll(dinnerSubjiList7);
    log('Dinner $dinnerSubjiList');
  }

  RxList<Map<String, String>> lunchSubjiList = <Map<String, String>>[].obs;
  RxList<Map<String, String>> dinnerSubjiList = <Map<String, String>>[].obs;

  RxString userCode = "".obs;
  RxString userPhone = "".obs;
  RxString userName = "".obs;
  RxString userType = "".obs;
  RxString addressType = "".obs;
  RxString address = "".obs;
  RxString latLng = "".obs;
  RxString state = "".obs;
  RxString city = "".obs;
  RxString pinCode = "".obs;
  RxString branchName = "".obs;
  RxString currentDate = "".obs;

  RxBool onSaturday = false.obs;
  RxBool onSunday = false.obs;
  RxBool packRegular = true.obs;
  RxBool packEcoFriendly = false.obs;

  RxInt totalCount = 0.obs;
  RxInt deliveryPrice = 0.obs;
  RxInt subjiCount = 0.obs;

  RxInt weekendTiffinCalculatedPrice = 0.obs;
  RxInt weekendTiffinCount = 0.obs;
  RxString packagingName = "Regular".obs;

  DateTime? picked;
  DateTime selectedDate = DateTime.now();
  RxBool isSelected = false.obs;
  RxString convertedDate = "Tap to select Date".obs;
  RxBool isLunchHomeSelected = true.obs;
  RxBool isLunchOfficeSelected = false.obs;
  RxBool isDinnerHomeSelected = true.obs;
  RxBool isDinnerOfficeSelected = false.obs;

  final getAddressListTypeModel = AddressListTypewiseModel().obs;
  final getDeliveryChargesModel = DeliveryChargesModel().obs;

  Rx<GetTimeSlotModel> getTimeSlotModel = GetTimeSlotModel().obs;
  RxString selectedLunchTime = "Select Time".obs;
  RxString selectedDinnerTime = "Select Time".obs;
  RxString addressLunchId = "".obs;
  RxString addressDinnerId = "".obs;
  // TIFFIN TYPE
  RxString tiffinType = "Lunch".obs;
  RxBool tiffinTypeLunch = true.obs;
  RxBool tiffinTypeDinner = false.obs;
  RxString discountInCart = "0".obs;
  var coupon = TextEditingController();
  RxString totalPriceInCart = "0".obs;
  RxString packagingPrice = "0".obs;
  RxInt satSunTiffinCount = 0.obs;
  initialFunctioun(
      {required double weekendPrice,
      required String tifinCount,
      required String tifinPrice,
      required String category}) async {
    getNext7Days();
    getDeliveryCharges(category: category);
    getWeekendCount(price: weekendPrice.toInt(), tiffinCount: tifinCount);
    getPackagingList(category: category).then((value) {
      packagingPrice.value =
          "${int.parse(getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * int.parse(tifinCount)}";

      calculateTotal(tifinPrice);
    });
    // getTotalCount(
    //     tiffinCount: tifinCount,
    //     tiffinPrice: tifinPrice,
    //     ecoFriendly:
    //         getPackagingListModel.value.packagingList?[1].packagingPrice ?? '0',
    //     regular: getPackagingListModel.value.packagingList?[0].packagingPrice ??
    //         '0');

    getSabjiListDaywiseForLunch(day: daysName[0]);
    getSabjiListDaywiseForDinner(day: daysName[0]);
    userCode.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userCode);
    userPhone.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userPhone);
    userName.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userName);
    userType.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userType);
    addressType.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.addressType);
    address.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.address);
    latLng.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.latLng);
    state.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.state);
    city.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.city);
    pinCode.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.pinCode);
    branchName.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.branch);
    currentDate.value = "${DateTime.now()}";
  }

  calculateTotal(String total) {
    double tempTotal = double.parse(total) +
        double.parse(deliveryPrice.value.toString()) +
        weekendTiffinCalculatedPrice.value;

    tempTotal += double.parse(packagingPrice.value);
    totalCount.value = tempTotal.toInt();
  }

  // getTotalCount(
  //     {String? tiffinPrice,
  //     required String ecoFriendly,
  //     required String regular,
  //     String? tiffinCount}) {
  //   int tiffinPrice1 = int.parse(tiffinPrice.toString());
  //   int ecoFriendly1 = packEcoFriendly.value == true
  //       ? int.parse(ecoFriendly)
  //       : int.parse(regular);

  //   totalCount.value = tiffinPrice1 + ecoFriendly1 + weekendTiffinCount.toInt();
  // }

  getWeekendCount({required int price, required String tiffinCount}) {
    if (onSaturday.value == true && onSunday.value == true) {
      weekendTiffinCalculatedPrice.value =
          price * (satSunTiffinCount.value * 2);
      weekendTiffinCount.value = (satSunTiffinCount.value * 2);
      if (packRegular.value) {
        packagingPrice.value =
            "${int.parse(getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * (int.parse(tiffinCount) + (satSunTiffinCount.value * 2))}";
      } else {
        packagingPrice.value =
            "${int.parse(getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * (int.parse(tiffinCount) + (satSunTiffinCount.value * 2))}";
      }
    } else if (onSaturday.value == true) {
      weekendTiffinCalculatedPrice.value = price * satSunTiffinCount.value;
      weekendTiffinCount.value = satSunTiffinCount.value;
      if (packRegular.value) {
        packagingPrice.value =
            "${int.parse(getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * (int.parse(tiffinCount) + satSunTiffinCount.value)}";
      } else {
        packagingPrice.value =
            "${int.parse(getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * (int.parse(tiffinCount) + satSunTiffinCount.value)}";
      }
    } else if (onSunday.value == true) {
      weekendTiffinCalculatedPrice.value = price * satSunTiffinCount.value;
      weekendTiffinCount.value = satSunTiffinCount.value;

      if (packRegular.value) {
        packagingPrice.value =
            "${int.parse(getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * (int.parse(tiffinCount) + satSunTiffinCount.value)}";
      } else {
        packagingPrice.value =
            "${int.parse(getPackagingListModel.value.packagingList?[1].packagingPrice ?? "0") * (int.parse(tiffinCount) + satSunTiffinCount.value)}";
      }
    } else {
      weekendTiffinCalculatedPrice.value = 0;
      weekendTiffinCount.value = 0;

      packagingPrice.value =
          "${int.parse(getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * int.parse(tiffinCount)}";
    }
  }

  ifRegularSelected() {
    packRegular.value = true;
    packEcoFriendly.value = false;
  }

  isEcoFriendly() {
    packRegular.value = false;
    packEcoFriendly.value = true;
  }

  Future getAddressListTypewise(String type) async {
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value,
        "address_type": type
      };

      log("Get address list payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addressListTypewise, payload: payload);

      log("Get address list typewise response ::: $response");

      getAddressListTypeModel.value =
          getAddressListTypewiseModelFromJson(response["body"]);

      if (getAddressListTypeModel.value.statusCode == "200" ||
          getAddressListTypeModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting address list ::: ${getAddressListTypeModel.value.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting address list ::: $error");
    }
  }

  Future getTimeSlot(fromLunch) async {
    CustomLoader.openCustomLoader();
    Map<String, String> myPayload = {
      "tiffin_type": fromLunch ? "Lunch" : "Dinner"
    };

    var response = await HttpServices.postHttpMethod(
        url: EndPointConstant.timeslot, payload: myPayload);

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

  Future getSabjiListDaywiseForLunch({day = ''}) async {
    CustomLoader.openCustomLoader();
    try {
      var map = <String, String>{};
      map['tiffin_type'] = 'Lunch';
      map['day'] = day.toString().substring(0, 3);
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.sabjiListDaywise, payload: map);
      log("Get sabji list payload ::: $map");
      log("Get sabji list response ::: $response");

      getSabjiListDaywiseLunchModel.value =
          getSabjiListDaywiseModelFromJson(response["body"]);

      if (getSabjiListDaywiseLunchModel.value.statusCode == "200" ||
          getSabjiListDaywiseLunchModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting sabji list ::: ${getSabjiListDaywiseLunchModel.value.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting sabji list ::: $error");
    }
  }

  Future getSabjiListDaywiseForDinner({day = ''}) async {
    CustomLoader.openCustomLoader();
    try {
      var map = <String, String>{};
      map['tiffin_type'] = 'Dinner';
      map['day'] = day.toString().substring(0, 3);
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.sabjiListDaywise, payload: map);
      log("Get sabji list payload ::: $map");
      log("Get sabji list response ::: $response");

      getSabjiListDaywiseDinnerModel.value =
          getSabjiListDaywiseModelFromJson(response["body"]);

      if (getSabjiListDaywiseDinnerModel.value.statusCode == "200" ||
          getSabjiListDaywiseDinnerModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting sabji list ::: ${getSabjiListDaywiseDinnerModel.value.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting sabji list ::: $error");
    }
  }

  Future getPackagingList({String category = ''}) async {
    CustomLoader.openCustomLoader();
    try {
      var data = <String, String>{};
      data['packaging_category'] = category;
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.packagingList, payload: data);

      getPackagingListModel.value =
          getPackagingListModelFromJson(response["body"]);

      if (getPackagingListModel.value.statusCode == "200" ||
          getPackagingListModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
      }
      log("Something went wrong during getting packaging list ::: ${getPackagingListModel.value.message}");
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting packaging list ::: $error");
    }
  }

  Future getDeliveryCharges({String category = ''}) async {
    // CustomLoader.openCustomLoader();
    try {
      var data = <String, String>{};
      data['delivery_charges_category'] = category;
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.deliveryChargesList, payload: data);

      getDeliveryChargesModel.value =
          getDeliveryChargesModelFromJson(response["body"]);
      deliveryPrice.value += int.parse(
          getDeliveryChargesModel.value.dcList?[0]?.deliveryChargesAmt ?? '0');
      if (getDeliveryChargesModel.value.statusCode == "200" ||
          getDeliveryChargesModel.value.statusCode == "201") {
        // CustomLoader.closeCustomLoader();
      } else {
        // CustomLoader.closeCustomLoader();
      }
      log("Something went wrong during getting delivery charges list ::: ${getDeliveryChargesModel.value.message}");
    } catch (error) {
      // CustomLoader.closeCustomLoader();
      log("Something went wrong during getting delivery charges list ::: $error");
    }
  }

  Future postOrder({
    required String cartId,
    required String categoryName,
    required String subCategoryName,
    required String productName,
    required String productCode,
    required String price,
    required String amount,
    required String tax,
    required String taxsGst,
    required String taxjGst,
    required String total,
    required String unit,
    required String tiffinCount,
  }) async {
    CustomLoader.openCustomLoader();
    try {
      addDinnerSubjiLists();
      addLunchSubjiLists();
      orderItemList.value = [
        {
          '\"cartId\"': '\"$cartId\"',
          '\"category_name\"': '\"$categoryName\"',
          '\"subcategory_name\"': '\"$subCategoryName\"',
          '\"product_name\"': '\"$productName\"',
          '\"product_code\"': '\"$productCode\"',
          '\"quantity\"': '\"1\"',
          '\"price\"': '\"$price\"',
          '\"amount\"': '\"$amount\"',
          '\"tax\"': '\"$tax\"',
          '\"tax_sgst\"': '\"$taxsGst\"',
          '\"tax_igst\"': '\"\"',
          '\"total\"': '\"$total\"',
          '\"unit\"': '\"$unit\"',
        },
      ];

      Map<String, dynamic> payload = {
        "customer_code": userCode.value,
        "customer_name": userName.value,
        "user_type": userType.value,
        "phone": userPhone.value,
        "order_dt": "${DateTime.now()}",
        "address_type": addressType.value,
        "address": address.value,
        "lat_long": latLng.value,
        "state": state.value,
        "city": city.value,
        "pincode": pinCode.value,
        "order_item": "$orderItemList",
        "receivers_name": userName.value,
        "billto_phone": userPhone.value,
        "delivery_charges":
            getDeliveryChargesModel.value.dcList?[0]?.deliveryChargesAmt ?? '0',
        "branch": branchName.value,
        "order_category": "Tiffin",
        "coupon_code": coupon.text,
        "coupon_amount": discountInCart.value,
        "tiffin_count": tiffinCount,
        "weekend_sat": onSaturday.value ? 'Yes' : 'no',
        "weekend_sun": onSunday.value ? 'Yes' : 'no',
        "satsun_tiffin_count": '${weekendTiffinCount.value}',
        "tiffin_start_dt": convertedDate.value,
        "packaging_type": packagingName.value,
        "tiffintype_lunch": tiffinTypeLunch.value ? 'Lunch' : '',
        "lunch_time": selectedLunchTime.value,
        "lunch_address_type": isLunchHomeSelected.value ? 'Home' : 'Office',
        "lunch_address_id": addressLunchId.value,
        "tiffintype_dinner": tiffinTypeDinner.value ? 'Dinner' : '',
        "dinner_time": selectedDinnerTime.value,
        "dinner_address_type": isDinnerHomeSelected.value ? 'Home' : 'Office',
        "dinner_address_id": addressDinnerId.value,
        'subji_list_lunch': '${lunchSubjiList.map((element) {
          return {
            '\"sId\"': '\"${element['sId']}\"',
            '\"day\"': '\"${element['day']}\"',
            '\"sabji\"': '\"${element['sabji']}\"',
            '\"tiffin_type\"': '\"${element['tiffin_type']}\"',
            '\"date\"': '\"${element['date']}\"',
          };
        }).toList()}',
        'subji_list_dinner': '${dinnerSubjiList.map((element) {
          return {
            '\"sId\"': '\"${element['sId']}\"',
            '\"day\"': '\"${element['day']}\"',
            '\"sabji\"': '\"${element['sabji']}\"',
            '\"tiffin_type\"': '\"${element['tiffin_type']}\"',
            '\"date\"': '\"${element['date']}\"',
          };
        }).toList()}',
        "subji_count": '${subjiCount.value}',
        "total_bill_amount": '$totalCount'
      };

      log("Post order payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.tifinOrderPlace, payload: payload);

      log("Post order response ::: $response");

      postOrderModel = postTifinOrderModelFromJson(response["body"]);

      if (postOrderModel.statusCode == "200" ||
          postOrderModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postOrderModel.message}");
        Get.offAll(() => const ThankYouView(isCancelOrder: false));
      } else {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postOrderModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting order ::: $error");
    }
  }

  String getDayNameFromNumber(int weekdayNumber) {
    if (weekdayNumber >= 1 && weekdayNumber <= 7) {
      List<String> weekdays = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      log("Check day ==> ${weekdays[weekdayNumber - 1]}");
      return weekdays[weekdayNumber - 1];
    } else {
      return 'Invalid weekday number';
    }
  }

  List<DateTime> getNext7Days() {
    DateTime currentDate = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime nextDay = currentDate.add(Duration(days: i));
      next7Days.add(nextDay);
    }
    next7Days.map(
      (dateWithDay) {
        daysName.add(getDayNameFromNumber(dateWithDay.weekday));
        log(
          '${dateWithDay.day}: ${dateWithDay.weekday}',
        );
      },
    ).toList();

    daysName.map((e) => log(e.toString()));
    return next7Days;
  }

  Future postCoupon() async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "customer_code": userCode.value,
        "total": totalPriceInCart.value,
        "coupon_code": coupon.text,
      };

      log("Post coupon payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.coupon, payload: payload);

      log("Post coupon response ::: $response");

      postCouponModel = postCouponModelFromJson(response["body"]);

      if (postCouponModel.statusCode == "200" ||
          postCouponModel.statusCode == "201") {
        coupon.clear();
        totalPriceInCart.value = '${postCouponModel.finalPrice ?? 0}';
        discountInCart.value = '${postCouponModel.couponPrice ?? 0}';
        CustomLoader.closeCustomLoader();
        customToast(message: "${postCouponModel.message}");
        Get.back();
      } else {
        coupon.clear();
        CustomLoader.closeCustomLoader();
        customToast(message: "${postCouponModel.message}");
      }
    } catch (error) {
      coupon.clear();

      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting coupon ::: $error");
    }
  }
}
