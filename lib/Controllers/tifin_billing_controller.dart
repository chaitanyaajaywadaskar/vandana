import 'dart:developer';
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
import '../Models/post_tiffin_order_model.dart';

class TifinBillingController extends GetxController {
  PostTIffinOrderModel postOrderModel = PostTIffinOrderModel();
  final getPackagingListModel = GetPackagingListModel().obs;
  final getSabjiListDaywiseModel = GetSabjiListDaywiseModel().obs;

  RxList orderItemList = [].obs;
  RxList<DateTime> next7Days = <DateTime>[].obs;
  RxList<String> daysName = <String>[].obs;
  RxList<String> lunchSubjiList = <String>[].obs;
  RxList<String> dinnerSubjiList = <String>[].obs;

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

  RxDouble count = 0.0.obs;
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
  initialFunctioun(
      {required double weekendPrice,
      required String tifinCount,
      required String tifinPrice,
      required String category}) async {
    getNext7Days();
    getTotalCount(
        tiffinCount: tifinCount,
        tiffinPrice: tifinPrice,
        ecoFriendly:
            getPackagingListModel.value.packagingList?[1].packagingPrice ?? '0',
        regular: getPackagingListModel.value.packagingList?[0].packagingPrice ??
            '0');
    getWeekendCount(price: weekendPrice);
    getPackagingList(category: category);
    getDeliveryCharges(category: category);
    getSabjiListDaywise(day: daysName[0]);
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
    currentDate.value = currentDate.value.split(" ")[0];
  }

  getTotalCount(
      {String? tiffinPrice,
      required String ecoFriendly,
      required String regular,
      String? tiffinCount}) {
    int tiffinPrice1 = int.parse(tiffinPrice.toString());
    int ecoFriendly1 = packEcoFriendly.value == true
        ? int.parse(ecoFriendly)
        : int.parse(regular);

    totalCount.value = tiffinPrice1 + ecoFriendly1 + count.toInt();
  }

  getWeekendCount({required double price}) {
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

  Future getSabjiListDaywise({day = ''}) async {
    CustomLoader.openCustomLoader();
    try {
      var map = <String, String>{};
      map['tiffin_type'] = tiffinType.value;
      map['day'] = day.toString().substring(0, 3);
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.sabjiListDaywise, payload: map);
      log("Get sabji list payload ::: $map");
      log("Get sabji list response ::: $response");

      getSabjiListDaywiseModel.value =
          getSabjiListDaywiseModelFromJson(response["body"]);

      if (getSabjiListDaywiseModel.value.statusCode == "200" ||
          getSabjiListDaywiseModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting sabji list ::: ${getSabjiListDaywiseModel.value.message}");
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
      totalCount.value += int.parse(
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

  Future postOrder(
      {required String cartId,
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
      required String unit}) async {
    CustomLoader.openCustomLoader();
    try {
      orderItemList.value = [
        {
          "cartId": cartId,
          "category_name": categoryName,
          "subcategory_name": subCategoryName,
          "product_name": productName,
          "product_code": productCode,
          "quantity": "1",
          "price": price,
          "amount": amount,
          "tax": tax,
          "tax_sgst": taxsGst,
          "tax_igst": taxjGst,
          "total": total,
          "unit": unit,
        },
      ];

      Map<String, dynamic> payload = {
        "customer_code": userCode.value,
        "customer_name": userName.value,
        "user_type": userType.value,
        "phone": userPhone.value,
        "order_dt": currentDate.value,
        "address_type": addressType.value,
        "address": address.value,
        "lat_long": latLng.value,
        "state": state.value,
        "city": city.value,
        "pincode": pinCode.value,
        "order_item": "$orderItemList",
        "receivers_name": "monika gite",
        "billto_phone": "9090909090",
        "delivery_charges": "0",
        "branch": branchName.value,
        "order_category": "Tiffin",
        "coupon_code": '',
        "coupon_amount": '',
        "tiffin_count": '22',
        "weekend_sat": onSaturday.value ? 'Yes' : 'no',
        "weekend_sun": onSunday.value ? 'Yes' : 'no',
        "satsun_tiffin_count": '4',
        "tiffin_start_dt": '${DateTime.now()}',
        "packaging_type": packagingName.value,
        "tiffintype_lunch": tiffinType.value,
        "lunch_time": selectedLunchTime.value,
        "lunch_address_type": isLunchHomeSelected.value ? 'Home' : 'Office',
        "lunch_address_id": addressLunchId.value,
        "tiffintype_dinner": tiffinType.value,
        "dinner_time": selectedDinnerTime.value,
        "dinner_address_type": isLunchHomeSelected.value ? 'Home' : 'Office',
        "dinner_address_id": addressDinnerId.value,
        "subji_list_lunch": '''{[
          {
            "sId": 1,
            "day": "Fri",
            "sabji": "Panner palak,methi",
            "tiffin_type": "Lunch"
          },
          {
            "sId": 2,
            "day": "Fri",
            "sabji": "Mix veg",
            "tiffin_type": "Lunch"
          }
        ]}''',
        "subji_list_dinner": '''[
          {"sId": 1, "day": "Fri", "sabji": "Panner", "tiffin_type": "Dinner"},
          {
            "sId": 2,
            "day": "Fri",
            "sabji": "Aloo Matar",
            "tiffin_type": "Dinner"
          }
        ]''',
        "subji_count": "2"
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
}
