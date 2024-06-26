// import 'dart:math';
import 'dart:developer';

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

import '../Custom_Widgets/custom_toast.dart';
import '../Models/get_address_list_model.dart';
import '../Models/get_item_list_model.dart';
import '../Models/get_sabji_list_model copy.dart';
import '../Models/get_selected_address_model.dart';
import '../Models/get_sub_category_data_model.dart';
import '../Models/post_remove_address_model.dart';
import '../Models/post_selected_address_model.dart';

class HomeController extends GetxController {
  var getBannerImagesModel = GetBannerImagesModel().obs;
  var getSelectedAddressModel = GetSelectedAddressModel().obs;
  var getCategoryListModel = GetCategoryListModel().obs;
  GetBranchListModel getBranchListModel = GetBranchListModel();
  Rx<SubCategoryDataModel> subCategoryDataModel = SubCategoryDataModel().obs;
  var getAddressListModel = GetAddressListModel().obs;
  PostSelectedAddressModel postSelectedAddressModel =
      PostSelectedAddressModel();
  PostRemoveAddressModel postRemoveAddressModel = PostRemoveAddressModel();

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
    getAddressList();
  }

  Future getAddressList() async {
    print('call huva');
    try {
      // CustomLoader.openCustomLoader();
      Map<String, String> payload = {
        "user_type": userType.value,
        "customer_code": customerCode.value
      };

      // log("Get address list payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addressList, payload: payload);

      // log("Get address list response ::: $response");

      getAddressListModel.value = getAddressListModelFromJson(response["body"]);

      // if (getAddressListModel.value.statusCode == "200" ||
      //     getAddressListModel.value.statusCode == "201") {
      //   CustomLoader.closeCustomLoader();
      // } else {
      //   CustomLoader.closeCustomLoader();
      // }
      log('url: ${EndPointConstant.addressList},\npayload: $payload,\nstatus-code :${getAddressListModel.value.statusCode},\nresponse: ${response["body"]}');
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting address list ::: $error");
    }
  }

  Future updateSelectedAddress(String id) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "id": id,
        "customer_code": customerCode.value,
        "address_status": "selected",
      };

      log("Post selected address payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.selectedAddressUpdate, payload: payload);

      log("Post selected address response ::: $response");

      postSelectedAddressModel =
          postSelectedAddressModelFromJson(response["body"]);

      if (postSelectedAddressModel.statusCode == "200" ||
          postSelectedAddressModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        getSelectedBranch();
        // customToast(message: "${postSelectedAddressModel.message}");
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during posting address ::: ${postSelectedAddressModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting address ::: $error");
    }
  }

  Future removeAddress({required String addressId}) async {
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {"id": addressId};

      log("Post remove address payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.removeAddress, payload: payload);

      log("Post remove address response ::: $response");

      postRemoveAddressModel = postRemoveAddressModelFromJson(response["body"]);

      if (postRemoveAddressModel.statusCode == "200" ||
          postRemoveAddressModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postRemoveAddressModel.message}");
        Get.back();
        getAddressList();
      } else {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postRemoveAddressModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting remove list ::: $error");
    }
  }

  Future getBannerImages() async {
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {"type": "Type1"};

      debugPrint("Get banner images payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.banner, payload: payload);

      debugPrint("Get banner images response ::: $response");

      getBannerImagesModel.value =
          getBannerImagesModelFromJson(response["body"]);

      if (getBannerImagesModel.value.statusCode == "200" ||
          getBannerImagesModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint(
            "Something went wrong during getting banner images ::: ${getBannerImagesModel.value.message}");
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

      getSelectedAddressModel.value =
          getSelectedAddressModelFromJson(response["body"]);

      if (getSelectedAddressModel.value.statusCode == "200" ||
          getSelectedAddressModel.value.statusCode == "201") {
        if (getSelectedAddressModel.value.UserSelectedAddress != null &&
            getSelectedAddressModel.value.UserSelectedAddress?.isNotEmpty ==
                true) {
          selectedBranch.value =
              getSelectedAddressModel.value.UserSelectedAddress?.first?.bname ??
                  '';
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.addressType,
              stringData: getSelectedAddressModel
                  .value.UserSelectedAddress?.first?.addressType);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.state,
              stringData: getSelectedAddressModel
                  .value.UserSelectedAddress?.first?.state);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.city,
              stringData: getSelectedAddressModel
                  .value.UserSelectedAddress?.first?.city);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.pinCode,
              stringData: getSelectedAddressModel
                  .value.UserSelectedAddress?.first?.pincode);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.address,
              stringData: getSelectedAddressModel
                  .value.UserSelectedAddress?.first?.address);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.latLng,
              stringData: getSelectedAddressModel
                  .value.UserSelectedAddress?.first?.latLong);
          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.branch,
              stringData: getSelectedAddressModel
                  .value.UserSelectedAddress?.first?.branch);
        }
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint(
            "Something went wrong during getting user selected  ::: ${getSelectedAddressModel.value.message}");
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

      getCategoryListModel.value = getCategoryListModelFromJson(response["body"]);

      if (getCategoryListModel.value.statusCode == "200" ||
          getCategoryListModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint(
            "Something went wrong during getting category list ::: ${getCategoryListModel.value.message}");
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
