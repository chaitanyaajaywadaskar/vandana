import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vandana/Models/post_coupon_model.dart.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Models/post_order_model.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Models/get_card_items_list_model.dart';
import 'package:vandana/Models/post_remove_cart_item_model.dart';
import 'package:vandana/Models/post_update_cart_item_model.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/thank_you_view.dart';

class CartController extends GetxController {
  GetCartItemsListModel getCartItemsListModel = GetCartItemsListModel();
  PostOrderModel postOrderModel = PostOrderModel();
  PostCouponModel postCouponModel = PostCouponModel();
  PostRemoveCartItemModel postRemoveCartItemModel = PostRemoveCartItemModel();
  PostUpdateCartItemModel postUpdateCartItemModel = PostUpdateCartItemModel();
  var coupon = TextEditingController();
  RxString userCode = "".obs;
  RxString userPhone = "".obs;
  RxString userName = "".obs;
  RxString userType = "".obs;
  RxString addressType = "".obs;
  RxString address = "".obs;
  RxString latLng = "".obs;
  RxString state = "".obs;
  RxString city = "".obs;
  RxString pinCode = "".obs;
  RxString branchName = "".obs;
  RxString currentDate = "".obs;
  RxString totalPriceInCart = "0".obs;
  RxString discountInCart = "0".obs;

  @override
  void onInit() {
    super.onInit();
    initialFunctioun();
  }

  initialFunctioun() async {
    totalPriceInCart.value = '0';
    discountInCart.value = '0';
    coupon.clear();
    userCode.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userCode);
    userPhone.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userPhone);
    userName.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userName);
    userType.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userType);
    addressType.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.addressType);
    address.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.address);
    latLng.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.latLng);
    state.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.state);
    city.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.city);
    pinCode.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.pinCode);
    branchName.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.branch) ??
        "";

    currentDate.value = "${DateTime.now()}";
    currentDate.value = currentDate.value.split(" ")[0];
    await getCartItemsList().whenComplete(() => update());
  }

  Future getCartItemsList() async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value,
        "phone": userPhone.value,
      };

      log("Get cart items list payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.cartItemList, payload: payload);

      log("Get cart items list response ::: $response");

      getCartItemsListModel = getCartItemsListModelFromJson(response["body"]);

      if (getCartItemsListModel.statusCode == "200" ||
          getCartItemsListModel.statusCode == "201") {
        double total = 0;
        getCartItemsListModel.cartItemList?.forEach((element) {
          var singleTotal = double.parse(
                  '${element.price != 'null' ? element.price ?? 0 : 0}') *
              double.parse('${element.quantity ?? 0}');
          total += singleTotal;
        });
        totalPriceInCart.value = '$total';
        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting cart items list ::: ${getCartItemsListModel.message}");
        update();
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting cart items list ::: $error");
    }
  }

  manageCartItems({required int index, required bool isAdd}) {
    int quantity = (isAdd)
        ? int.parse(getCartItemsListModel.cartItemList![index].quantity!) + 1
        : int.parse(getCartItemsListModel.cartItemList![index].quantity!) - 1;

    num total = (isAdd)
        ? int.parse(getCartItemsListModel.cartItemList![index].price!) *
            quantity
        : int.parse(getCartItemsListModel.cartItemList![index].total!) -
            int.parse(getCartItemsListModel.cartItemList![index].price!);
    if (quantity < 1) {
      removeCartItem(
          cartId: "${getCartItemsListModel.cartItemList?[index].id}");
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
            getCartItemsListModel.cartItemList?[index].categoryName,
        "subcategory_name":
            getCartItemsListModel.cartItemList?[index].subcategoryName,
        "product_name": getCartItemsListModel.cartItemList?[index].productName,
        "product_code": getCartItemsListModel.cartItemList?[index].productCode,
        "unit": "nos",
        "quantity": quantity,
        "price": getCartItemsListModel.cartItemList?[index].price,
        "total": total,
        "tax": getCartItemsListModel.cartItemList?[index].tax,
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
        getCartItemsList();
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
        customToast(message: "${postRemoveCartItemModel.message}");
        getCartItemsList();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during posting remove cart item ::: ${postRemoveCartItemModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting remove cart item ::: $error");
    }
  }

  Future postOrder({required List orderItems}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "customer_code": userCode.value,
        "customer_name": userName.value,
        "user_type": userType.value,
        "phone": userPhone.value,
        "order_dt": currentDate.value,
        "address_type": addressType.value,
        "address": address.value,
        "lat_long": latLng.value,
        "state": state.value,
        "city": city.value,
        "pincode": pinCode.value,
        "order_item": "$orderItems",
        "receivers_name": "monika gite",
        "billto_phone": "9090909090",
        "delivery_charges": "0",
        "branch": branchName.value,
        "order_category": "Food"
      };

      log("Post order payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.saleOrderPlace, payload: payload);

      log("Post order response ::: $response");

      postOrderModel = postOrderModelFromJson(response["body"]);

      if (postOrderModel.statusCode == "200" ||
          postOrderModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postOrderModel.message}");
        Get.offAll(() => const ThankYouView(isCancelOrder: false, ));
      } else {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postOrderModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting order ::: $error");
    }
  }

  Future postCoupon() async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "customer_code": userCode.value,
        "total": totalPriceInCart.value,
        "coupon_code": coupon.text,
      };

      log("Post coupon payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.coupon, payload: payload);

      log("Post coupon response ::: $response");

      postCouponModel = postCouponModelFromJson(response["body"]);

      if (postCouponModel.statusCode == "200" ||
          postCouponModel.statusCode == "201") {
        coupon.clear();
        totalPriceInCart.value = '${postCouponModel.finalPrice ?? 0}';
        discountInCart.value = '${postCouponModel.couponPrice ?? 0}';
        CustomLoader.closeCustomLoader();
        customToast(message: "${postCouponModel.message}");
        Get.back();
      } else {
        coupon.clear();
        CustomLoader.closeCustomLoader();
        customToast(message: "${postCouponModel.message}");
      }
    } catch (error) {
      coupon.clear();

      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting coupon ::: $error");
    }
  }
}
