import 'dart:developer';

import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Models/get_sub_category_model.dart';
import 'package:vandana/Services/http_services.dart';

class SelectFoodController extends GetxController {
  var getSubCategoryModel = GetSubCategoryModel().obs;

  Future getSubCategory({String categoryName = ''}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {"category_name": categoryName};

      log("Get subcategory payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.subcategoryList, payload: payload);

      log("Get subcategory response ::: $response");

      getSubCategoryModel.value = getSubCategoryModelFromJson(response["body"]);

      if (getSubCategoryModel.value.statusCode == "200" ||
          getSubCategoryModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting subcategory ::: ${getSubCategoryModel.value.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting subcategory ::: $error");
    }
  }
}
