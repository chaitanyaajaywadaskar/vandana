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

import '../Models/get_thali_chapati_list_model.dart.dart';
import '../Models/post_remove_cart_item_model.dart';
import '../Models/post_update_cart_item_model.dart';

class FoodDetailListController extends GetxController {
  var getFoodDetailListModel = GetFoodDetailListModel().obs;
  PostToCartModel postToCartModel = PostToCartModel();
  PostRemoveCartItemModel postRemoveCartItemModel = PostRemoveCartItemModel();
  PostUpdateCartItemModel postUpdateCartItemModel = PostUpdateCartItemModel();
  var getThaliChapatiListModel = GetThaliChapatiListModel().obs;
  // TodaysSabjiModel getTodaysSubjiListModel = TodaysSabjiModel();
  // List<String> sabjiNames = ["Methi", "Malay Kofta", "Kofta"];
  RxString userType = "".obs;
  RxString userCode = "".obs;
  RxString userPhone = "".obs;
  RxString categoryName = "".obs;
  RxString subCategoryName = "".obs;
  RxString tiffinType = "".obs;
  RxList<RxMap<String, dynamic>> probabilityList =
      <RxMap<String, dynamic>>[].obs;

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

  Future getFoodDetail() async {
    CustomLoader.openCustomLoader();
    try {
      var code = await StorageServices.getData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.userCode) ??
          '';
      Map<String, String> payload = {
        "category_name": categoryName.value,
        "subcategory_name": subCategoryName.value,
        "customer_code": code,
      };

      log("Get food detail payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.itemList, payload: payload);

      log("Get food detail response ::: $response");

      getFoodDetailListModel.value =
          getFoodDetailListModelFromJson(response['body']);

      if (getFoodDetailListModel.value.statusCode == "200" ||
          getFoodDetailListModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting food detail list ::: ${getFoodDetailListModel.value.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting food detail list ::: $error");
    }
  }

  Future getThaliChapatiList() async {
    try {
      CustomLoader.openCustomLoader();

      var code = await StorageServices.getData(
          dataType: StorageKeyConstant.stringType,
          prefKey: StorageKeyConstant.userCode);

      Map<String, String> payload = {
        "category_name": categoryName.value,
        "subcategory_name": subCategoryName.value,
        "customer_code": code,
      };

      log("Get thali chapati list payload ::: $payload");
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.thaliChapatiList, payload: payload);

      log("Get thali chapati list response ::: $response");

      getThaliChapatiListModel.value =
          getThaliChapatiModelFromJson(response["body"]);
      if (getThaliChapatiListModel.value.statusCode == "200" ||
          getThaliChapatiListModel.value.statusCode == "201") {
        // generateProbabilityList(getTodaysSubjiListModel.checkSabjiList
        //         ?.map((e) => '${e?.sabji}')
        //         .toList() ??
        //     []);

        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting todays sabji list ::: ${getThaliChapatiListModel.value.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting todays sabji list ::: $error");
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
            "${getFoodDetailListModel.value.productList?[index]?.categoryName}",
        "subcategory_name":
            "${getFoodDetailListModel.value.productList?[index]?.subcategoryName}",
        "product_name":
            "${getFoodDetailListModel.value.productList?[index]?.productName}",
        "product_code":
            "${getFoodDetailListModel.value.productList?[index]?.productCode}",
        "unit": "nos",
        "quantity": "1",
        "price": "${getFoodDetailListModel.value.productList?[index]?.price}",
        "total": "1",
        "tax": "${getFoodDetailListModel.value.productList?[index]?.tax}",
      };

      log("Post to cart payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addCart, payload: payload);

      log("Post to cart response ::: $response");

      postToCartModel = postToCartModelFromJson(response['body']);

      if (postToCartModel.statusCode == "200" ||
          postToCartModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        getFoodDetail();
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

  Future manageCartItems(
      {required int index, required bool isAdd, String type = 'Food'}) async {
    print(
        '${getFoodDetailListModel.value.productList?[index]?.itemAddQuantity ?? 0}');
    int quantity = (isAdd)
        ? int.parse(
                '${getFoodDetailListModel.value.productList?[index]?.itemAddQuantity ?? 0}') +
            1
        : int.parse(
                '${getFoodDetailListModel.value.productList![index]?.itemAddQuantity ?? 0}') -
            1;

    num total = (isAdd)
        ? int.parse(
                '${getFoodDetailListModel.value.productList?[index]?.price}') *
            quantity
        : int.parse(
                '${getFoodDetailListModel.value.productList?[index]?.price}') -
            int.parse(
                '${getFoodDetailListModel.value.productList?[index]?.price}');
    print('quantity:- $quantity');

    if (quantity < 1) {
      removeCartItem(
          cartId: "${getFoodDetailListModel.value.productList?[index]?.pid}");
    } else {
      updateCartItems(
          index: index, isAdd: isAdd, quantity: "$quantity", total: "$total");
    }
  }

  Future updateCartItems(
      {required int index,
      required bool isAdd,
      required String quantity,
      required String total}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value,
        "phone": userPhone.value,
        "category_name":
            getFoodDetailListModel.value.productList![index]?.categoryName,
        "subcategory_name":
            getFoodDetailListModel.value.productList![index]?.subcategoryName,
        "product_name":
            getFoodDetailListModel.value.productList![index]?.productName,
        "product_code":
            getFoodDetailListModel.value.productList![index]?.productCode,
        "unit": "nos",
        "quantity": quantity,
        "price": getFoodDetailListModel.value.productList![index]?.price,
        "total": total,
        "tax": getFoodDetailListModel.value.productList![index]?.tax,
      };

      log("Post update cart items payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.updateCartItem, payload: payload);

      log("Post update cart items response ::: $response");

      postUpdateCartItemModel =
          postUpdateCartItemModelFromJson(response["body"]);

      if (postUpdateCartItemModel.statusCode == "200" ||
          postUpdateCartItemModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        getFoodDetail();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during posting update cart items ::: ${postUpdateCartItemModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting update cart items ::: $error");
    }
  }

  Future removeCartItem({required String cartId}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {"id": cartId};

      log("Post remove cart payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.removeCartItem, payload: payload);

      log("Post remove cart response ::: $response");

      postRemoveCartItemModel =
          postRemoveCartItemModelFromJson(response["body"]);

      if (postRemoveCartItemModel.statusCode == "200" ||
          postRemoveCartItemModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        getFoodDetail();
        customToast(message: "${postRemoveCartItemModel.message}");
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during posting remove cart item ::: ${postRemoveCartItemModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting remove cart item ::: $error");
    }
  }

  Future postThaliToCart({required int index}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, String> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value,
        "phone": userPhone.value,
        "category_name":
            "${getThaliChapatiListModel.value.productList?[index]?.categoryName}",
        "subcategory_name":
            "${getThaliChapatiListModel.value.productList?[index]?.subcategoryName}",
        "product_name":
            "${getThaliChapatiListModel.value.productList?[index]?.productName}",
        "product_code":
            "${getThaliChapatiListModel.value.productList?[index]?.productCode}",
        "unit": "nos",
        "quantity": "1",
        "price": "${getThaliChapatiListModel.value.productList?[index]?.price}",
        "total": "1",
        "tax": "${getThaliChapatiListModel.value.productList?[index]?.tax}",
      };

      log("Post to cart payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addCart, payload: payload);

      log("Post to cart response ::: $response");

      postToCartModel = postToCartModelFromJson(response['body']);

      if (postToCartModel.statusCode == "200" ||
          postToCartModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        getThaliChapatiList();
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

  Future manageThaliCartItems(
      {required int index, required bool isAdd, String type = 'Food'}) async {
    int quantity = (isAdd)
        ? int.parse(getThaliChapatiListModel
                    .value.productList![index]?.itemAddQuantity ??
                '0') +
            1
        : int.parse(getThaliChapatiListModel
                    .value.productList![index]?.itemAddQuantity ??
                '0') -
            1;

    num total = (isAdd)
        ? int.parse(getThaliChapatiListModel.value.productList![index]?.price ??
                '0') *
            quantity
        : int.parse(getThaliChapatiListModel.value.productList![index]?.price ??
                '0') -
            int.parse(
                getThaliChapatiListModel.value.productList![index]?.price ??
                    '0');

    if (quantity < 1) {
      removeThaliCartItem(
          cartId:
              "${getThaliChapatiListModel.value.productList![index]?.itemAddCartid}");
    } else {
      updateThaliCartItems(
          index: index, isAdd: isAdd, quantity: "$quantity", total: "$total");
    }
  }

  Future updateThaliCartItems(
      {required int index,
      required bool isAdd,
      required String quantity,
      required String total}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value,
        "phone": userPhone.value,
        "category_name":
            getThaliChapatiListModel.value.productList![index]?.categoryName,
        "subcategory_name":
            getThaliChapatiListModel.value.productList![index]?.subcategoryName,
        "product_name":
            getThaliChapatiListModel.value.productList![index]?.productName,
        "product_code":
            getThaliChapatiListModel.value.productList![index]?.productCode,
        "unit": "nos",
        "quantity": quantity,
        "price": getThaliChapatiListModel.value.productList![index]?.price,
        "total": total,
        "tax": getThaliChapatiListModel.value.productList![index]?.tax,
      };

      log("Post update cart items payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.updateCartItem, payload: payload);

      log("Post update cart items response ::: $response");

      postUpdateCartItemModel =
          postUpdateCartItemModelFromJson(response["body"]);

      if (postUpdateCartItemModel.statusCode == "200" ||
          postUpdateCartItemModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        getThaliChapatiList();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during posting update cart items ::: ${postUpdateCartItemModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting update cart items ::: $error");
    }
  }

  Future removeThaliCartItem({required String cartId}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {"id": cartId};

      log("Post remove cart payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.removeCartItem, payload: payload);

      log("Post remove cart response ::: $response");

      postRemoveCartItemModel =
          postRemoveCartItemModelFromJson(response["body"]);

      if (postRemoveCartItemModel.statusCode == "200" ||
          postRemoveCartItemModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        getThaliChapatiList();
        customToast(message: "${postRemoveCartItemModel.message}");
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during posting remove cart item ::: ${postRemoveCartItemModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting remove cart item ::: $error");
    }
  }

  // Future getTodaysSabjiList() async {
  //   try {
  //     CustomLoader.openCustomLoader();

  //     var response =
  //         await HttpServices.getHttpMethod(url: EndPointConstant.todaysSabji);

  //     log("Get sabji list response ::: $response");

  //     getTodaysSubjiListModel = getTodaysSabjiModelFromJson(response["body"]);
  //     if (getTodaysSubjiListModel.statusCode == "200" ||
  //         getTodaysSubjiListModel.statusCode == "201") {
  //       tiffinType.value = getTodaysSubjiListModel.ttype.toString();
  //       // generateProbabilityList(getTodaysSubjiListModel.checkSabjiList
  //       //         ?.map((e) => '${e?.sabji}')
  //       //         .toList() ??
  //       //     []);

  //       CustomLoader.closeCustomLoader();
  //       update();
  //     } else {
  //       CustomLoader.closeCustomLoader();
  //       log("Something went wrong during getting todays sabji list ::: ${getTodaysSubjiListModel.message}");
  //     }
  //   } catch (error) {
  //     CustomLoader.closeCustomLoader();
  //     log("Something went wrong during getting todays sabji list ::: $error");
  //   }
  // }

  // void generateProbabilityList(List<String> sabjiNames) {
  //   List<List<String>> combinations = _generateCombinations(sabjiNames);
  //   int totalCombinations = combinations.length;
  //   double probability = 1 / totalCombinations;

  //   probabilityList.value = combinations.map((combo) {
  //     return {"combination": combo, "probability": probability}.obs;
  //   }).toList();
  // }

  // List<List<String>> _generateCombinations(List<String> elements) {
  //   List<List<String>> result = [];
  //   for (int i = 0; i < elements.length; i++) {
  //     for (int j = 0; j < elements.length; j++) {
  //       if (i != j) {
  //         result.add([elements[i], elements[j]]);
  //       }
  //     }
  //   }
  //   return result;
  // }
}
