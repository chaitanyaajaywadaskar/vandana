import 'dart:developer';

import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Models/get_address_list_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';

class SelectAddressController extends GetxController {
  GetAddressListModel getAddressListModel = GetAddressListModel();

  RxString userType = "".obs;
  RxString userCode = "".obs;

  @override
  void onInit() {
    super.onInit();
    initialFunctioun();
  }

  initialFunctioun() async {
    userType.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userType);
    userCode.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userCode);

    await getAddressList();
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
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting address list ::: ${getAddressListModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting address list ::: $error");
    }
  }
}
