import 'dart:developer';
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

class FoodBillingController extends GetxController {
  PostOrderModel postOrderModel = PostOrderModel();
  GetPackagingListModel getPackagingListModel = GetPackagingListModel();

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

  @override
  void onInit() {
    super.onInit();
    initialFunctioun();
  }

  initialFunctioun() async {
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
  }

  Future getPackagingList() async {
    CustomLoader.openCustomLoader();
    try {
      var response =
          await HttpServices.getHttpMethod(url: EndPointConstant.packagingList);

      log("Get packaging list response ::: $response");

      getPackagingListModel = getPackagingListModelFromJson(response["body"]);

      if (getPackagingListModel.statusCode == "200" ||
          getPackagingListModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting packaging list ::: ${getPackagingListModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting packaging list ::: $error");
    }
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
        // "coupon_code": 'FOODABC1232',
        // "coupon_amount": '50',
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
}
