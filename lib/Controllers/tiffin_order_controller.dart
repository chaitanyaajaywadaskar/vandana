import 'dart:developer';

import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Services/http_services.dart';

import '../Constant/storage_key_constant.dart';
import '../Models/get_tiffin_order_list_model.dart';
import '../Services/storage_services.dart';

class TiffinOrderController extends GetxController {
  var getTifinOrderModel = GetTiffinOrderListModel().obs;

  Future getTiffinOrderList() async {
    CustomLoader.openCustomLoader();

    try {
      var code = await StorageServices.getData(
          dataType: StorageKeyConstant.stringType,
          prefKey: StorageKeyConstant.userCode);
      var phone = await StorageServices.getData(
          dataType: StorageKeyConstant.stringType,
          prefKey: StorageKeyConstant.userPhone);
      Map<String, String> payload = {
        "customer_code": code,
        "phone": phone,
      };

      log("Get subcategory payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.tiffinOrderList, payload: payload);

      log("Get subcategory response ::: $response");

      getTifinOrderModel.value =
          getTiffinOrderListModelFromJson(response["body"]);

      if (getTifinOrderModel.value.statusCode == "200" ||
          getTifinOrderModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting subcategory ::: ${getTifinOrderModel.value.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting subcategory ::: $error");
    }
  }
}
