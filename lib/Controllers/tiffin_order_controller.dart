import 'dart:developer';

import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/thank_you_view.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Tifin_Section/tifin_billing_view.dart';

import '../Constant/storage_key_constant.dart';
import '../Custom_Widgets/custom_toast.dart';
import '../Models/get_tiffin_order_list_model.dart';
import '../Models/post_cancel_tiffin_model.dart';
import '../Services/storage_services.dart';

class TiffinOrderController extends GetxController {
  var getTifinOrderListModel = GetTiffinOrderListModel().obs;
  PostCancelTiffinModel postCancelModel = PostCancelTiffinModel();
  RxString branchCode = "".obs;
  RxString userCode = "".obs;
  RxString userPhone = "".obs;
  RxString userName = "".obs;
  RxBool tiffinTypeLunch = true.obs;
  RxBool tiffinTypeDinner = false.obs;
  initialFunction() async {
    userName.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userName) ??
        "";
    userCode.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userCode);
    userPhone.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userPhone);
    branchCode.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.branch);
  }

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

      getTifinOrderListModel.value =
          getTiffinOrderListModelFromJson(response["body"]);

      if (getTifinOrderListModel.value.statusCode == "200" ||
          getTifinOrderListModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting subcategory ::: ${getTifinOrderListModel.value.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting subcategory ::: $error");
    }
  }

  Future cancelOrder({String soNumber = '', date = ''}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "customer_code": userCode.value,
        "phone": userPhone.value,
        "so_number": soNumber,
        "branch_name": branchCode.value,
        "tiffintype_lunch": tiffinTypeLunch.value ? 'Lunch' : '',
        "tiffintype_dinner": tiffinTypeDinner.value ? 'Dinner' : '',
        "tiffin_cancel_date": date,
      };

      log("Post order cancel payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.cancelTiffin, payload: payload);

      log("Post order cancel response ::: $response");

      postCancelModel = postCancelModelFromJson(response["body"]);

      if (postCancelModel.statusCode == "200" ||
          postCancelModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postCancelModel.message}");
        Get.to(() => const ThankYouView(
              isCancelOrder: true,
            ));
      } else {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postCancelModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting order cancel ::: $error");
    }
  }
}
