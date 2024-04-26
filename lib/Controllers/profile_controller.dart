import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Models/get_address_list_model.dart';
import 'package:vandana/Models/post_remove_address_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';

import '../Models/post_selected_address_model.dart';

class ProfileController extends GetxController {
  var getAddressListModel = GetAddressListModel().obs;
  PostRemoveAddressModel postRemoveAddressModel = PostRemoveAddressModel();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxString userType = "".obs;
  RxString userCode = "".obs;
  PostSelectedAddressModel postSelectedAddressModel =
      PostSelectedAddressModel();
  @override
  void onInit() {
    super.onInit();
    initialFunctioun();
  }

 Future initialFunctioun() async {
    nameController.text = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userName);
    phoneController.text = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userPhone);
    emailController.text = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userEmail);
    addressController.text = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.address);
    userType.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userType);
    userCode.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userCode);
    getAddressList();
  }

  Future updateSelectedAddress(String id) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "id": id,
        "customer_code": userCode.value,
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

  Future setAddressDetail({required int index}) async {
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.address,
        stringData: getAddressListModel.value.addressList?[index]?.address);
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.addressType,
        stringData: getAddressListModel.value.addressList?[index]?.addressType ?? '');
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.city,
        stringData: getAddressListModel.value.addressList?[index]?.city ?? '');
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.state,
        stringData: getAddressListModel.value.addressList?[index]?.state ?? '');
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.latLng,
        stringData: getAddressListModel.value.addressList?[index]?.latLong ?? '');
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.pinCode,
        stringData: getAddressListModel.value.addressList?[index]?.pincode ?? '');
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.branch,
        stringData: getAddressListModel.value.addressList?[index]?.branch ?? '');
    updateSelectedAddress('${getAddressListModel.value.addressList?[index]?.id}');
  }

  Future getAddressList() async {
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value
      };

      // log("Get address list payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addressList, payload: payload);

      // log("Get address list response ::: $response");

      getAddressListModel.value = getAddressListModelFromJson(response["body"]);

      if (getAddressListModel.value.statusCode == "200" ||
          getAddressListModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
      }
      log('url: ${EndPointConstant.addressList},\npayload: $payload,\nstatus-code :${getAddressListModel.value.statusCode},\nresponse: ${response["body"]}');
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting address list ::: $error");
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
}
