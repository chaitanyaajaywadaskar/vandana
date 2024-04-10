import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Models/get_address_list_model.dart';
import 'package:vandana/Models/get_branch_list_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';

class SelectAddressController extends GetxController {
  GetAddressListModel getAddressListModel = GetAddressListModel();
  GetBranchListModel getBranchListModel = GetBranchListModel();

  RxString userType = "".obs;
  RxString userCode = "".obs;
  RxDouble distance = 0.0.obs;

  RxString latitude = "".obs;
  RxString longitude = "".obs;
  Position? position;
  Placemark placeMark = const Placemark();
  LatLng coordinates = const LatLng(0.0, 0.0);
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

  Future<Position> getCurrentLocation() async {
    CustomLoader.openCustomLoader();
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      coordinates = LatLng(position!.latitude, position!.longitude);

      latitude.value = coordinates.latitude.toString();
      longitude.value = coordinates.longitude.toString();
      log("Current coordinates ::: $coordinates");

      List<Placemark> placeMarkList = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);

      log("Place mark based on current coordinates ::: $placeMark");
      placeMark = placeMarkList[0];
      log("Place is :- $placeMark");
      log('locality:- ${placeMark.locality} sublocality:- ${placeMark.subLocality}');
      await StorageServices.setData(
          dataType: StorageKeyConstant.stringType,
          prefKey: StorageKeyConstant.branch,
          stringData: placeMark.subLocality?.isEmpty == true
              ? placeMark.locality
              : placeMark.subLocality);

      update();
      CustomLoader.closeCustomLoader();

      return await Geolocator.getCurrentPosition();
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting current location and address ::: $error");
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> getBranchList() async {
    try {
      CustomLoader.openCustomLoader();

      var response =
          await HttpServices.getHttpMethod(url: EndPointConstant.branchList);

      debugPrint("Get branch list response ::: $response");

      getBranchListModel = getBranchListModelFromJson(response["body"]);

      if (getBranchListModel.statusCode == "200" ||
          getBranchListModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        for (int i = 0;
            i < int.parse('${getBranchListModel.branchList?.length ?? 0}');
            i++) {
          distance.value = calculateDistance(
              double.parse(latitude.value),
              double.parse(longitude.value),
              double.parse(
                  "${getBranchListModel.branchList?[i]?.latLong?.split(", ")[0]}"),
              double.parse(
                  "${getBranchListModel.branchList?[i]?.latLong?.split(", ")[1]}"));

          if (distance.value <= 7) {
            await StorageServices.setData(
                dataType: StorageKeyConstant.stringType,
                prefKey: StorageKeyConstant.branch,
                stringData: getBranchListModel.branchList?[i]?.branchName);
            return true;
          } else {
            debugPrint('not contain');
            return false;
          }
        }
        update();
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint(
            "Something went wrong during getting branch list ::: ${getBranchListModel.message}");
      }
      return false;
    } catch (error) {
      CustomLoader.closeCustomLoader();
      debugPrint("Something went wrong during getting branch list ::: $error");
      return false;
    }
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double dLat = degreesToRadians(lat2 - lat1);
    double dLon = degreesToRadians(lon2 - lon1);

    double a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(degreesToRadians(lat1)) *
            math.cos(degreesToRadians(lat2)) *
            math.pow(math.sin(dLon / 2), 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }
}
