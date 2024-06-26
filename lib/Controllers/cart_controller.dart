import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
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

import '../Models/get_add_on_item_cart_model.dart';
import '../Models/get_delivery_charges_model.dart';
import '../Models/post_to_cart_model.dart';
import 'get_packaging_list_model.dart';

class CartController extends GetxController {
  final getCartItemsListModel = GetCartItemsListModel().obs;
  final getDeliveryChargesModel = DeliveryChargesModel().obs;
  final getAddOnItemModel = GetAddOnItemCartModel().obs;
  PostToCartModel postToCartModel = PostToCartModel();
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
  RxString totalQuantityInCart = "0".obs;
  RxString discountInCart = "0".obs;
  RxBool packRegular = true.obs;
  RxBool packEcoFriendly = false.obs;
  final getPackagingListModel = GetPackagingListModel().obs;
  RxString packagingPrice = "0".obs;
  RxString packagingName = "Regular".obs;
  RxInt deliveryPrice = 0.obs;
  RxInt totalCount = 0.obs;
  RxBool isAddOnCartLoading = false.obs;
  RxString singlePackagingCost = "0".obs;

  initialFunctioun() async {
    totalPriceInCart.value = '0';
    totalCount.value = 0;
    totalQuantityInCart.value = "0";
    packagingPrice.value = '0';
    discountInCart.value = '0';
    deliveryPrice.value = 0;
    coupon.clear();
    userCode.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userCode) ??
        '';
    userPhone.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userPhone) ??
        '';
    userName.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userName) ??
        '';
    userType.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userType) ??
        '';
    addressType.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.addressType) ??
        '';
    address.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.address) ??
        '';
    latLng.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.latLng) ??
        '';
    state.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.state) ??
        '';
    city.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.city) ??
        '';
    pinCode.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.pinCode) ??
        '';
    branchName.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.branch) ??
        "";
    currentDate.value = "${DateTime.now()}";
    currentDate.value = currentDate.value.split(" ")[0];
    getCartItemsList().whenComplete(() {
      update();
      getPackagingList().then((value) {
        singlePackagingCost.value =
            '${getPackagingListModel.value.packagingList?[0].packagingPrice}';
        packagingPrice.value =
            "${int.parse(getPackagingListModel.value.packagingList?[0].packagingPrice ?? "0") * int.parse(totalQuantityInCart.value)}";
        packagingName.value = getPackagingListModel
                .value.packagingList?[0].packagingName
                .toString() ??
            '';
        calculateTotal(totalPriceInCart.value);
      });
    });
    getDeliveryCharges();
    getAddOnItemList();
  }

  Future postToCart({required int index}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, String> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value,
        "phone": userPhone.value,
        "category_name":
            "${getAddOnItemModel.value.addonItemList?[index]?.categoryName}",
        "subcategory_name":
            "${getAddOnItemModel.value.addonItemList?[index]?.subcategoryName}",
        "product_name":
            "${getAddOnItemModel.value.addonItemList?[index]?.productName}",
        "product_code":
            "${getAddOnItemModel.value.addonItemList?[index]?.productCode}",
        "unit": "nos",
        "quantity": "1",
        "price": "${getAddOnItemModel.value.addonItemList?[index]?.price}",
        "total": "1",
        "tax": "${getAddOnItemModel.value.addonItemList?[index]?.tax}",
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

  calculateTotal(String total) {
    double tempTotal =
        double.parse(total) + double.parse(deliveryPrice.value.toString());

    tempTotal += double.parse(packagingPrice.value);
    double tax = 5;
    double taxPrice = 0;
    taxPrice = tempTotal * tax / 100;
    totalCount.value = tempTotal.toInt() + taxPrice.toInt();
  }

  Future getDeliveryCharges() async {
    // CustomLoader.openCustomLoader();
    try {
      var data = <String, String>{};
      data['delivery_charges_category'] = 'Other';
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.deliveryChargesList, payload: data);

      getDeliveryChargesModel.value =
          getDeliveryChargesModelFromJson(response["body"]);
      deliveryPrice.value += int.parse(
          getDeliveryChargesModel.value.dcList?[0]?.deliveryChargesAmt ?? '0');
      if (getDeliveryChargesModel.value.statusCode == "200" ||
          getDeliveryChargesModel.value.statusCode == "201") {
        // CustomLoader.closeCustomLoader();
      } else {
        // CustomLoader.closeCustomLoader();
      }
      log("Something went wrong during getting delivery charges list ::: ${getDeliveryChargesModel.value.message}");
    } catch (error) {
      // CustomLoader.closeCustomLoader();
      log("Something went wrong during getting delivery charges list ::: $error");
    }
  }

  Future getAddOnItemList() async {
    // CustomLoader.openCustomLoader();
    try {
      isAddOnCartLoading.value = true;
      var payload = <String, String>{
        "category_name": "Food",
        "customer_code": userCode.value
      };
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addOnItemList, payload: payload);

      getAddOnItemModel.value = getAddOnCartModelFromJson(response["body"]);
      isAddOnCartLoading.value = false;
      log('url: ${EndPointConstant.addOnItemList},\npayload: $payload,\nstatus-code :${getAddOnItemModel.value.statusCode},\nresponse: ${response["body"]}');
    } catch (error) {
      isAddOnCartLoading.value = false;

      log("Something went wrong during getting add on item list ::: $error");
    }
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

      getCartItemsListModel.value =
          getCartItemsListModelFromJson(response["body"]);

      if (getCartItemsListModel.value.statusCode == "200" ||
          getCartItemsListModel.value.statusCode == "201") {
        double total = 0;
        double quantity = 0;
        getCartItemsListModel.value.cartItemList?.forEach((element) {
          var singleTotal = double.parse(
                  '${element.price != 'null' ? element.price ?? 0 : 0}') *
              double.parse('${element.quantity ?? 0}');
          total += singleTotal;
          quantity += int.parse('${element.quantity ?? 0}');
        });
        totalPriceInCart.value = '$total';

        totalCount.value = int.parse(total.toStringAsFixed(0));
        totalQuantityInCart.value = quantity.toStringAsFixed(0);
        // packagingPrice.value =
        //     "${int.parse(singlePackagingCost.value) * int.parse(totalQuantityInCart.value)}";

        CustomLoader.closeCustomLoader();
        update();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting cart items list ::: ${getCartItemsListModel.value.message}");
        update();
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting cart items list ::: $error");
    }
  }

  Future getPackagingList() async {
    CustomLoader.openCustomLoader();
    try {
      var data = <String, String>{};
      data['packaging_category'] = 'Other';
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.packagingList, payload: data);

      getPackagingListModel.value =
          getPackagingListModelFromJson(response["body"]);

      if (getPackagingListModel.value.statusCode == "200" ||
          getPackagingListModel.value.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
      }
      log("Something went wrong during getting packaging list ::: ${getPackagingListModel.value.message}");
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting packaging list ::: $error");
    }
  }

  manageCartItems({required int index, required bool isAdd}) {
    int quantity = (isAdd)
        ? int.parse(
                getCartItemsListModel.value.cartItemList![index].quantity!) +
            1
        : int.parse(
                getCartItemsListModel.value.cartItemList![index].quantity!) -
            1;

    num total = (isAdd)
        ? int.parse(getCartItemsListModel.value.cartItemList![index].price!) *
            quantity
        : int.parse(getCartItemsListModel.value.cartItemList![index].total!) -
            int.parse(getCartItemsListModel.value.cartItemList![index].price!);
    if (quantity < 1) {
      removeCartItem(
              cartId: "${getCartItemsListModel.value.cartItemList?[index].id}")
          .then((value) {
        getCartItemsList()
            .then((value) => calculateTotal(totalPriceInCart.value));
        getAddOnItemList();
      });
    } else {
      updateCartItems(
              index: index,
              isAdd: isAdd,
              quantity: "$quantity",
              total: "$total")
          .then((value) {
        getCartItemsList()
            .then((value) => calculateTotal(totalPriceInCart.value));
        getAddOnItemList();
      });
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
            getCartItemsListModel.value.cartItemList?[index].categoryName,
        "subcategory_name":
            getCartItemsListModel.value.cartItemList?[index].subcategoryName,
        "product_name":
            getCartItemsListModel.value.cartItemList?[index].productName,
        "product_code":
            getCartItemsListModel.value.cartItemList?[index].productCode,
        "unit": "nos",
        "quantity": quantity,
        "price": getCartItemsListModel.value.cartItemList?[index].price,
        "total": total,
        "tax": getCartItemsListModel.value.cartItemList?[index].tax,
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
        "receivers_name": userName.value,
        "billto_phone": userPhone.value,
        "branch": branchName.value,
        "order_category": "Food",
        "coupon_code": coupon.text,
        "coupon_amount": discountInCart.value,
        "packaging_type": packagingName.value,
        "delivery_charges":
            getDeliveryChargesModel.value.dcList?[0]?.deliveryChargesAmt ?? '0',
        "total_bill_amount": '${totalCount.value}'
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
        Get.offAll(() => const ThankYouView(
              isCancelOrder: false,
            ));
      } else {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postOrderModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting order ::: $error");
    }
  }

  manageCartItemsForAddOn({required int index, required bool isAdd}) {
    int quantity = (isAdd)
        ? int.parse(getAddOnItemModel
                    .value.addonItemList![index]?.itemAddQuantity ??
                '0') +
            1
        : int.parse(getAddOnItemModel
                    .value.addonItemList![index]?.itemAddQuantity ??
                '0') -
            1;

    num total = (isAdd)
        ? int.parse(
                getAddOnItemModel.value.addonItemList![index]?.price ?? '0') *
            quantity
        : int.parse(
                getAddOnItemModel.value.addonItemList![index]?.price ?? '0') -
            int.parse(
                getAddOnItemModel.value.addonItemList![index]?.price ?? '0');
    if (quantity < 1) {
      removeCartItem(
              cartId:
                  "${getAddOnItemModel.value.addonItemList?[index]?.itemAddCartid}")
          .then((value) {
        getCartItemsList()
            .then((value) => calculateTotal(totalPriceInCart.value));
        getAddOnItemList();
      });
    } else {
      updateCartItemsForAddOn(
              index: index,
              isAdd: isAdd,
              quantity: "$quantity",
              total: "$total")
          .then((value) {
        getCartItemsList()
            .then((value) => calculateTotal(totalPriceInCart.value));
        getAddOnItemList();
      });
    }
  }

  Future updateCartItemsForAddOn(
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
            getAddOnItemModel.value.addonItemList?[index]?.categoryName,
        "subcategory_name":
            getAddOnItemModel.value.addonItemList?[index]?.subcategoryName,
        "product_name":
            getAddOnItemModel.value.addonItemList?[index]?.productName,
        "product_code":
            getAddOnItemModel.value.addonItemList?[index]?.productCode,
        "unit": "nos",
        "quantity": quantity,
        "price": getAddOnItemModel.value.addonItemList?[index]?.price,
        "total": total,
        "tax": getAddOnItemModel.value.addonItemList?[index]?.tax,
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

  Future removeCartItemForAddOn({required String cartId}) async {
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
        totalPriceInCart.value = '${postCouponModel.finalPrice ?? 0}';
        discountInCart.value = '${postCouponModel.couponPrice ?? 0}';
        totalCount.value = int.parse('${postCouponModel.finalPrice ?? 0}');
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
