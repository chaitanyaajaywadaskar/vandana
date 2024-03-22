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

class ProfileController extends GetxController {
  GetAddressListModel getAddressListModel = GetAddressListModel();
  PostRemoveAddressModel postRemoveAddressModel = PostRemoveAddressModel();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxString userType = "".obs;
  RxString userCode = "".obs;

  @override
  void onInit() {
    super.onInit();
    initialFunctioun();
  }

  initialFunctioun() async {
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

    await getAddressList();
  }

  setAddressDetail({required int index}) async {
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.address,
        stringData: getAddressListModel.addressList?[index].address);
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.addressType,
        stringData: getAddressListModel.addressList?[index].addressType);
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.city,
        stringData: getAddressListModel.addressList?[index].city);
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.state,
        stringData: getAddressListModel.addressList?[index].state);
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.latLng,
        stringData: getAddressListModel.addressList?[index].latLong);
    await StorageServices.setData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.pinCode,
        stringData: getAddressListModel.addressList?[index].pincode);
  }

  Future getAddressList() async {
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value
      };

      log("Get address list payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addressList, payload: payload);

      log("Get address list response ::: $response");

      getAddressListModel = getAddressListModelFromJson(response["body"]);

      if (getAddressListModel.statusCode == "200" ||
          getAddressListModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting address list ::: ${getAddressListModel.message}");
      }
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
