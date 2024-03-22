import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Models/get_banner_images_model.dart';
import 'package:vandana/Models/get_branch_list_model.dart';
import 'package:vandana/Models/get_category_list_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';

import '../Models/get_item_list_model.dart';
import '../Models/get_sabji_list_model copy.dart';
import '../Models/get_sub_category_data_model.dart';

class HomeController extends GetxController {
  GetBannerImagesModel getBannerImagesModel = GetBannerImagesModel();
  GetCategoryListModel getCategoryListModel = GetCategoryListModel();
  GetBranchListModel getBranchListModel = GetBranchListModel();
  Rx<SubCategoryDataModel> subCategoryDataModel = SubCategoryDataModel().obs;

  RxString userName = "".obs;
  RxString selectedBranch = "".obs;
  RxString latLng = "".obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;

  RxDouble distance = 0.0.obs;

  static const earthRadius = 6371;
  RxBool monthly = true.obs;
  RxBool weekly = false.obs;
  RxBool daily = false.obs;

  onMonth() {
    monthly.value = true;
    weekly.value = false;
    daily.value = false;
  }

  onWeek() {
    monthly.value = false;
    weekly.value = true;
    daily.value = false;
  }

  onDay() {
    monthly.value = false;
    weekly.value = false;
    daily.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    initialFunctioun();
  }

  initialFunctioun() async {
    latLng.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.latLng) ??
        "";
    latitude.value = latLng.value.split(" ")[0];
    longitude.value = latLng.value.split(" ")[1];
    await getBranchList();
    userName.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userName) ??
        "";
    selectedBranch.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.branch) ??
        "Not Available";
    getBannerImages();
    getCategoryList();
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double dLat = degreesToRadians(lat2 - lat1);
    double dLon = degreesToRadians(lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) +
        cos(degreesToRadians(lat1)) *
            cos(degreesToRadians(lat2)) *
            pow(sin(dLon / 2), 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  Future getBannerImages() async {
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {"type": "Type1"};

      debugPrint("Get banner images payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.banner, payload: payload);

      debugPrint("Get banner images response ::: $response");

      getBannerImagesModel = getBannerImagesModelFromJson(response["body"]);

      if (getBannerImagesModel.statusCode == "200" ||
          getBannerImagesModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint(
            "Something went wrong during getting banner images ::: ${getBannerImagesModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      debugPrint(
          "Something went wrong during getting banner images ::: $error");
    }
  }

  Future getCategoryList() async {
    try {
      CustomLoader.openCustomLoader();

      var response =
          await HttpServices.getHttpMethod(url: EndPointConstant.categoryList);

      debugPrint("Get category list response ::: $response");

      getCategoryListModel = getCategoryListModelFromJson(response["body"]);

      if (getCategoryListModel.statusCode == "200" ||
          getCategoryListModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint(
            "Something went wrong during getting category list ::: ${getCategoryListModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      debugPrint(
          "Something went wrong during getting category list ::: $error");
    }
  }

  Future getBranchList() async {
    try {
      CustomLoader.openCustomLoader();

      var response =
          await HttpServices.getHttpMethod(url: EndPointConstant.branchList);

      debugPrint("Get branch list response ::: $response");

      getBranchListModel = getBranchListModelFromJson(response["body"]);

      if (getBranchListModel.statusCode == "200" ||
          getBranchListModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();

        for (int i = 1; i <= getBranchListModel.branchList!.length; i++) {
          distance.value = calculateDistance(
              double.parse(latitude.value),
              double.parse(longitude.value),
              double.parse(
                  "${getBranchListModel.branchList?[i].latLong?.split(", ")[0]}"),
              double.parse(
                  "${getBranchListModel.branchList?[i].latLong?.split(", ")[1]}"));

          if (distance.value <= 7) {
            selectedBranch.value = "${distance.value}";
          }
        }
        await StorageServices.setData(
          dataType: StorageKeyConstant.stringType,
          prefKey: StorageKeyConstant.branch,
          stringData: selectedBranch.value,
        );
        update();
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint(
            "Something went wrong during getting branch list ::: ${getBranchListModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      debugPrint("Something went wrong during getting branch list ::: $error");
    }
  }

  Future getSubCategory(String? categoryName) async {
    print("Passing Name ==> $categoryName");
    CustomLoader.openCustomLoader();
    Map<String, String> myPayload = {
      "category_name": categoryName.toString(),
    };
    var response = await HttpServices.postHttpMethod(
        url: "https://softhubtechno.com/cloud_kitchen/api/subcategory_list.php",
        payload: myPayload);

    debugPrint("Get category response ::: $response");

    subCategoryDataModel.value = subCategoryDataModelFromJson(response['body']);

    try {
      if (subCategoryDataModel.value.statusCode == "200" ||
          subCategoryDataModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        // Your Statement
      } else {
        CustomLoader.closeCustomLoader();

        debugPrint(
            "Something went wrong during getting category list ::: ${subCategoryDataModel.value.message}");
        // Your Message
      }
    } catch (e, st) {
      CustomLoader.closeCustomLoader();
      debugPrint("Something went wrong during getting category list ::: $e");
      debugPrint("Error location during getting category list ::: $st");
    }
  }
  Rx<GetSabjiDataModel> getSabjiDataModel = GetSabjiDataModel().obs;

  Future getSabjiList() async {
    CustomLoader.openCustomLoader();

    var response = await HttpServices.getHttpMethod(
      url: "https://softhubtechno.com/cloud_kitchen/api/sabji_list.php",
    );

    debugPrint("Get sABJI response ::: $response");

    getSabjiDataModel.value = getSabjiDataModelFromJson(response['body']);

    try {
      if (getSabjiDataModel.value.statusCode == "200" ||
          getSabjiDataModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        // Your Statement
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint("Something went wrong during getting category list ::: ${getSabjiDataModel.value.message}");
        // Your Message
      }
    } catch (e, st) {
      CustomLoader.closeCustomLoader();
      debugPrint("Something went wrong during getting category list ::: $e");
      debugPrint("Error location during getting category list ::: $st");
    }
  }

  Rx<GetItemListModel> getItemListModel = GetItemListModel().obs;

  Future getTiffinDetailBySubCategory(
      String? categoryName, String? subCategoryName) async {
    print("pasing Name ==> $categoryName");
    CustomLoader.openCustomLoader();
    Map<String, String> myPayload = {
      "category_name": categoryName.toString(),
      "subcategory_name": subCategoryName.toString()
    };
    var response = await HttpServices.postHttpMethod(
        url: "https://softhubtechno.com/cloud_kitchen/api/item_list.php",
        payload: myPayload);

    debugPrint("Get category response ::: $response");

    getItemListModel.value = getItemListModelFromJson(response['body']);

    try {
      if (getItemListModel.value.statusCode == "200" ||
          getItemListModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        // Your Statement
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint("Something went wrong during getting category list ::: ${getItemListModel.value.message}");
        // Your Message
      }
    } catch (e, st) {
      CustomLoader.closeCustomLoader();
      debugPrint("Something went wrong during getting category list ::: $e");
      debugPrint("Error location during getting category list ::: $st");
    }
  }

}
