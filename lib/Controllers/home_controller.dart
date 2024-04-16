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
import '../Models/get_selected_address_model.dart';
import '../Models/get_sub_category_data_model.dart';

class HomeController extends GetxController {
  GetBannerImagesModel getBannerImagesModel = GetBannerImagesModel();
  GetSelectedAddressModel getSelectedAddressModel = GetSelectedAddressModel();
  GetCategoryListModel getCategoryListModel = GetCategoryListModel();
  GetBranchListModel getBranchListModel = GetBranchListModel();
  Rx<SubCategoryDataModel> subCategoryDataModel = SubCategoryDataModel().obs;

  RxString userName = "".obs;
  RxString userType = "".obs;
  RxString customerCode = "".obs;
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
    if (latLng.value.isNotEmpty) {
      latitude.value = latLng.value.split(" ")[0];
      longitude.value = latLng.value.split(" ")[1];
    }

    userName.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userName) ??
        "";
    userType.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userType) ??
        "";
    customerCode.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userCode) ??
        "";
    selectedBranch.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.branch) ??
        "Not Available";
    getSelectedBranch();
    getBranchList();
    getBannerImages();
    getCategoryList();
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

  Future getSelectedBranch() async {
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {
        "user_type": userType.value,
        "customer_code": customerCode.value
      };

      debugPrint("Get user selected payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.userSelectedAddress, payload: payload);

      debugPrint("Get user selected response ::: $response");

      getSelectedAddressModel =
          getSelectedAddressModelFromJson(response["body"]);

      if (getSelectedAddressModel.statusCode == "200" ||
          getSelectedAddressModel.statusCode == "201") {
        if (getSelectedAddressModel.UserSelectedAddress != null &&
            getSelectedAddressModel.UserSelectedAddress?.isNotEmpty == true) {
          selectedBranch.value =
              getSelectedAddressModel.UserSelectedAddress?.first?.bname ?? '';
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.addressType,
              stringData: getSelectedAddressModel
                  .UserSelectedAddress?.first?.addressType);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.state,
              stringData:
                  getSelectedAddressModel.UserSelectedAddress?.first?.state);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.city,
              stringData:
                  getSelectedAddressModel.UserSelectedAddress?.first?.city);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.pinCode,
              stringData:
                  getSelectedAddressModel.UserSelectedAddress?.first?.pincode);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.address,
              stringData:
                  getSelectedAddressModel.UserSelectedAddress?.first?.address);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.latLng,
              stringData:
                  getSelectedAddressModel.UserSelectedAddress?.first?.latLong);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.branch,
              stringData:
                  getSelectedAddressModel.UserSelectedAddress?.first?.bname);
        }
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint(
            "Something went wrong during getting user selected  ::: ${getSelectedAddressModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      debugPrint(
          "Something went wrong during getting user selected  ::: $error");
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
        debugPrint(
            "Something went wrong during getting category list ::: ${getSabjiDataModel.value.message}");
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
        debugPrint(
            "Something went wrong during getting category list ::: ${getItemListModel.value.message}");
        // Your Message
      }
    } catch (e, st) {
      CustomLoader.closeCustomLoader();
      debugPrint("Something went wrong during getting category list ::: $e");
      debugPrint("Error location during getting category list ::: $st");
    }
  }
}
