import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Controllers/get_packaging_list_model.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Models/post_order_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/thank_you_view.dart';

import '../Models/get_delivery_charges_model.dart';
import '../Models/post_coupon_model.dart.dart';

class FoodBillingController extends GetxController {
  PostOrderModel postOrderModel = PostOrderModel();
  final getPackagingListModel = GetPackagingListModel().obs;
  RxList orderItemList = [].obs;

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
  RxBool packRegular = true.obs;
  RxBool packEcoFriendly = false.obs;
  RxString packagingName = "Regular".obs;
  var coupon = TextEditingController();
  PostCouponModel postCouponModel = PostCouponModel();
  RxString totalPriceInCart = "0".obs;
  RxString discountInCart = "0".obs;
  final getDeliveryChargesModel = DeliveryChargesModel().obs;
  RxInt totalCount = 0.obs;
  RxDouble count = 0.0.obs;

  initialFunctioun({ required String tifinPrice,}) async {
    getTotalCount(
        tiffinPrice: tifinPrice,
        ecoFriendly:
            getPackagingListModel.value.packagingList?[1].packagingPrice ?? '0',
        regular: getPackagingListModel.value.packagingList?[0].packagingPrice ??
            '0');
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
        prefKey: StorageKeyConstant.branch);
    currentDate.value = DateTime.now().toString().split(" ")[0];
    getPackagingList();
  }

  ifRegularSelected() {
    packRegular.value = true;
    packEcoFriendly.value = false;
  }

  isEcoFriendly() {
    packRegular.value = false;
    packEcoFriendly.value = true;
  }

  Future getPackagingList() async {
    CustomLoader.openCustomLoader();
    try {
      var data = <String, String>{};
      data['packaging_category'] = 'Other';
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.packagingList, payload: data);
      log("payload $data \n, response $response");

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
 getTotalCount(
      {String? tiffinPrice,
      required String ecoFriendly,
      required String regular,
      }) {
    int tiffinPrice1 = int.parse(tiffinPrice.toString());
    int ecoFriendly1 = packEcoFriendly.value == true
        ? int.parse(ecoFriendly)
        : int.parse(regular);

    totalCount.value = tiffinPrice1 + ecoFriendly1 + count.toInt();
  }
  Future postOrder(
      {required String cartId,
      required String categoryName,
      required String subCategoryName,
      required String productName,
      required String productCode,
      required String price,
      required String amount,
      required tax,
      required taxsGst,
      required String taxjGst,
      required String total,
      required String unit}) async {
    CustomLoader.openCustomLoader();
    try {
      orderItemList.value = [
        {
          '\"cartId\"': '\"$cartId\"',
          '\"category_name\"': '\"$categoryName\"',
          '\"subcategory_name\"': '\"$subCategoryName\"',
          '\"product_name\"': '\"$productName\"',
          '\"product_code\"': '\"$productCode\"',
          '\"quantity\"': '\"1\"',
          '\"price\"': '\"$price\"',
          '\"amount\"': '\"$amount\"',
          '\"tax\"': '\"$tax\"',
          '\"tax_sgst\"': '\"$taxsGst\"',
          '\"tax_igst\"': '\"$taxjGst\"',
          '\"total\"': '\"$total\"',
          '\"unit\"': '\"$unit\"',
        },
      ];

      Map<String, dynamic> payload = {
        "customer_code": userCode.value,
        "customer_name": userName.value,
        "user_type": userType.value,
        "phone": userPhone.value,
        "order_dt": DateTime.now().toString().split(" ")[0],
        "address_type": addressType.value,
        "address": address.value,
        "lat_long": latLng.value,
        "state": state.value,
        "city": city.value,
        "pincode": pinCode.value,
        "order_item": "$orderItemList",
        "receivers_name": "monika gite",
        "billto_phone": "9090909090",
        "delivery_charges": "0",
        "branch": branchName.value,
        "order_category": categoryName,
        "coupon_code": 'FOODABC1232',
        "coupon_amount": '50',
        "packaging_type": packagingName.value,
        "total_bill_amount": total
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
        Get.offAll(() => const ThankYouView(isCancelOrder: false));
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

  Future getDeliveryCharges({String category = ''}) async {
    // CustomLoader.openCustomLoader();
    try {
      var data = <String, String>{};
      data['delivery_charges_category'] = category;
      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.deliveryChargesList, payload: data);

      getDeliveryChargesModel.value =
          getDeliveryChargesModelFromJson(response["body"]);
      totalCount.value += int.parse(
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
}
