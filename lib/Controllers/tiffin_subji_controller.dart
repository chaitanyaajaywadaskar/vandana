import 'dart:developer';
import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Models/update_subji_model.dart';
import 'package:vandana/Services/http_services.dart';
import '../Models/get_order_subji_list_model.dart';
import '../Models/get_sabjilist_daywise.dart';
import 'package:intl/intl.dart';

class TifinSubjiController extends GetxController {
  final getSabjiListDaywiseLunchModel = GetSabjiListDaywiseModel().obs;
  final getOrderSubjiListModel = GetOrderSubjiListModel().obs;
  final getSabjiListDaywiseDinnerModel = GetSabjiListDaywiseModel().obs;
  final updateSubjiModel = UpdateSubjiModel().obs;

  RxList orderItemList = [].obs;
  RxList<DateTime> next7Days = <DateTime>[].obs;
  RxList<String> daysName = <String>[].obs;
  RxInt subjiCount = 0.obs;
  var enableLunch = false.obs;
  var enableDinner = false.obs;
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

  void addToStorageList(int index, List<Map<String, String>> storageList) {
    storageList.add({
      "sId": '${getOrderSubjiListModel.value.orderplacedSubjiList?[index]?.id}',
      "day":
          '${getOrderSubjiListModel.value.orderplacedSubjiList?[index]?.day}',
      "sabji":
          '${getOrderSubjiListModel.value.orderplacedSubjiList?[index]?.sabji}',
      "tiffin_type":
          '${getOrderSubjiListModel.value.orderplacedSubjiList?[index]?.tiffinType}',
      "date":
          '${getOrderSubjiListModel.value.orderplacedSubjiList?[index]?.day}',
    });
  }

  RxList<Map<String, String>> lunchSubjiList = <Map<String, String>>[].obs;
  RxList<Map<String, String>> dinnerSubjiList = <Map<String, String>>[].obs;

  // TIFFIN TYPE
  RxString tiffinType = "Lunch".obs;
  RxBool tiffinTypeLunch = true.obs;
  RxBool tiffinTypeDinner = false.obs;
  initialFunctioun() async {
    getNext7Days();

    getSabjiListDaywiseForLunch(day: daysName[0]);
    getSabjiListDaywiseForDinner(day: daysName[0]);
  }

  Future updateSubjiList({String soNo = '', subjiCount = ''}) async {
    CustomLoader.openCustomLoader();
    try {
      addDinnerSubjiLists();
      addLunchSubjiLists();
      var map = <String, String>{
        'so_number': soNo,
        'subji_count': subjiCount,
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
      };

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.updateSubjiList, payload: map);
      // log("Get order placed sabji list payload ::: $map");
      // log("Get order placed sabji list response ::: $response");

      updateSubjiModel.value = updateSubjiModelFromJson(response["body"]);
      log('url: ${EndPointConstant.updateSubjiList},\npayload: $map,\nstatus-code :${updateSubjiModel.value.statusCode},\nresponse: ${response["body"]}');

      if (updateSubjiModel.value.statusCode == "200" ||
          updateSubjiModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        customToast(message: 'Subji list updated successfully');
      } else {
        CustomLoader.closeCustomLoader();
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during updating sabji list ::: $error");
    }
  }

  Future getOrderPlaceSubjiList(
      {String soNo = '', tiffinType = 'Lunch'}) async {
    CustomLoader.openCustomLoader();
    try {
      var map = <String, String>{};
      map['so_number'] = soNo;
      map['tiffin_type'] = tiffinType;
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.orderTiffinSubjiList, payload: map);
      log("Get order placed sabji list payload ::: $map");
      log("Get order placed sabji list response ::: $response");

      getOrderSubjiListModel.value =
          getOrderSubjiListModelFromJson(response["body"]);

      if (getOrderSubjiListModel.value.statusCode == "200" ||
          getOrderSubjiListModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        if (tiffinType == 'Lunch') {
          clearAllSubjiListFeilds();

          for (var day in daysName.value) {
            DateTime now = DateTime.now();
            DateTime date2 = DateTime.now().add(const Duration(days: 1));
            DateTime date3 = DateTime.now().add(const Duration(days: 2));
            DateTime date4 = DateTime.now().add(const Duration(days: 3));
            DateTime date5 = DateTime.now().add(const Duration(days: 4));
            DateTime date6 = DateTime.now().add(const Duration(days: 5));
            DateTime date7 = DateTime.now().add(const Duration(days: 6));
            String dayName1 = DateFormat('EEEE').format(now);
            String dayName2 = DateFormat('EEEE').format(date2);
            String dayName3 = DateFormat('EEEE').format(date3);
            String dayName4 = DateFormat('EEEE').format(date4);
            String dayName5 = DateFormat('EEEE').format(date5);
            String dayName6 = DateFormat('EEEE').format(date6);
            String dayName7 = DateFormat('EEEE').format(date7);
            if (day.toString().substring(0, 3) == dayName1.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                lunchSubjiList1.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName2.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                lunchSubjiList2.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName3.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                lunchSubjiList3.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName4.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                lunchSubjiList4.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName5.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                lunchSubjiList5.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName6.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                lunchSubjiList6.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName7.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                lunchSubjiList7.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            }
          }
        } else {
          clearAllSubjiListFeilds(isLunch: false);

          for (var day in daysName.value) {
            DateTime now = DateTime.now();
            DateTime date2 = DateTime.now().add(const Duration(days: 1));
            DateTime date3 = DateTime.now().add(const Duration(days: 2));
            DateTime date4 = DateTime.now().add(const Duration(days: 3));
            DateTime date5 = DateTime.now().add(const Duration(days: 4));
            DateTime date6 = DateTime.now().add(const Duration(days: 5));
            DateTime date7 = DateTime.now().add(const Duration(days: 6));
            String dayName1 = DateFormat('EEEE').format(now);
            String dayName2 = DateFormat('EEEE').format(date2);
            String dayName3 = DateFormat('EEEE').format(date3);
            String dayName4 = DateFormat('EEEE').format(date4);
            String dayName5 = DateFormat('EEEE').format(date5);
            String dayName6 = DateFormat('EEEE').format(date6);
            String dayName7 = DateFormat('EEEE').format(date7);
            if (day.toString().substring(0, 3) == dayName1.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                dinnerSubjiList1.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName2.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                dinnerSubjiList2.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName3.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                dinnerSubjiList3.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName4.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                dinnerSubjiList4.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName5.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                dinnerSubjiList5.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName6.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                dinnerSubjiList6.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            } else if (day.toString().substring(0, 3) ==
                dayName7.substring(0, 3)) {
              var list = getOrderSubjiListModel.value.orderplacedSubjiList
                  ?.where((element) =>
                      element?.day == day.toString().substring(0, 3))
                  .toList();
              list?.forEach((data) {
                dinnerSubjiList7.add({
                  "sId": '${data?.sId}',
                  "day": '${data?.day}',
                  "sabji": '${data?.sabji}',
                  "tiffin_type": '${data?.tiffinType}',
                  "date": '${data?.day}',
                });
              });
            }
          }
        }
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting order sabji list ::: ${getSabjiListDaywiseLunchModel.value.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting order sabji list ::: $error");
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
