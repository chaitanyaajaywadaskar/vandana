import 'dart:developer';
import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Models/get_food_detail_list_model.dart';
import 'package:vandana/Models/post_to_cart_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';

class TifinDetailListController extends GetxController {
  GetFoodDetailListModel getFoodDetailListModel = GetFoodDetailListModel();
  PostToCartModel postToCartModel = PostToCartModel();

  RxString userType = "".obs;
  RxString userCode = "".obs;
  RxString userPhone = "".obs;

  initialFunctioun() async {
    userType.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userType);
    userCode.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userCode);
    userPhone.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userPhone);
  }

  Future getTifinDetail(
      {required String categoryName, required String subCategoryName}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, String> payload = {
        "category_name": categoryName.toString(),
        "subcategory_name": subCategoryName.toString()
      };

      log("Get tifin detail payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.itemList, payload: payload);

      log("Get tifin detail response ::: $response");

      getFoodDetailListModel = getFoodDetailListModelFromJson(response['body']);

      if (getFoodDetailListModel.statusCode == "200" ||
          getFoodDetailListModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting tifin detail list ::: ${getFoodDetailListModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting tifin detail list ::: $error");
    }
  }

  Future postToCart({required int index}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, String> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value,
        "phone": userPhone.value,
        "category_name":
            "${getFoodDetailListModel.productList?[index]?.categoryName}",
        "subcategory_name":
            "${getFoodDetailListModel.productList?[index]?.subcategoryName}",
        "product_name":
            "${getFoodDetailListModel.productList?[index]?.productName}",
        "product_code":
            "${getFoodDetailListModel.productList?[index]?.productCode}",
        "unit": "nos",
        "quantity": "1",
        "price": "${getFoodDetailListModel.productList?[index]?.price}",
        "total": "1",
        "tax": "${getFoodDetailListModel.productList?[index]?.tax}",
      };

      log("Post to cart payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addCart, payload: payload);

      log("Post to cart response ::: $response");

      postToCartModel = postToCartModelFromJson(response['body']);

      if (postToCartModel.statusCode == "200" ||
          postToCartModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postToCartModel.message}");
      } else {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postToCartModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting product to cart ::: $error");
    }
  }
}
