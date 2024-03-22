import 'dart:convert';
import 'package:get/get.dart';

GetTiffinOrderListModel getTiffinOrderListModelFromJson(String str) =>
    GetTiffinOrderListModel.fromJson(json.decode(str));

String getTiffinOrderListModelToJson(GetTiffinOrderListModel data) =>
    json.encode(data.toJson());

class GetTiffinOrderListModelOrderList {
/*
{
  "id": "73",
  "so_number": "72",
  "order_date": "15-03-2024",
  "customer_name": "Monika",
  "customer_code": "VK11",
  "phone": "9325612162",
  "order_packaging_status": "N",
  "order_shipping_status": "N",
  "order_completed_status": "N",
  "total": "2200.00",
  "branch_name": "sdd",
  "branch_contactno": "9822113577",
  "coupon_amount": 0,
  "final_amount": 2200,
  "order_category": "Tiffin",
  "tiffin_count": "22",
  "weekend_saturday": "yes",
  "weekend_sunday": "no",
  "satsun_tiffin_count": "4",
  "tiffin_start_date": "2024-03-19",
  "packaging_type": "Regular"
} 
*/

  String? id;
  String? soNumber;
  String? orderDate;
  String? customerName;
  String? customerCode;
  String? phone;
  String? orderPackagingStatus;
  String? orderShippingStatus;
  String? orderCompletedStatus;
  String? total;
  String? branchName;
  String? branchContactno;
  int? couponAmount;
  int? finalAmount;
  String? orderCategory;
  String? tiffinCount;
  String? weekendSaturday;
  String? weekendSunday;
  String? satsunTiffinCount;
  String? tiffinStartDate;
  String? packagingType;

  GetTiffinOrderListModelOrderList({
    this.id,
    this.soNumber,
    this.orderDate,
    this.customerName,
    this.customerCode,
    this.phone,
    this.orderPackagingStatus,
    this.orderShippingStatus,
    this.orderCompletedStatus,
    this.total,
    this.branchName,
    this.branchContactno,
    this.couponAmount,
    this.finalAmount,
    this.orderCategory,
    this.tiffinCount,
    this.weekendSaturday,
    this.weekendSunday,
    this.satsunTiffinCount,
    this.tiffinStartDate,
    this.packagingType,
  });
  GetTiffinOrderListModelOrderList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    soNumber = json['so_number']?.toString();
    orderDate = json['order_date']?.toString();
    customerName = json['customer_name']?.toString();
    customerCode = json['customer_code']?.toString();
    phone = json['phone']?.toString();
    orderPackagingStatus = json['order_packaging_status']?.toString();
    orderShippingStatus = json['order_shipping_status']?.toString();
    orderCompletedStatus = json['order_completed_status']?.toString();
    total = json['total']?.toString();
    branchName = json['branch_name']?.toString();
    branchContactno = json['branch_contactno']?.toString();
    couponAmount = json['coupon_amount']?.toInt();
    finalAmount = json['final_amount']?.toInt();
    orderCategory = json['order_category']?.toString();
    tiffinCount = json['tiffin_count']?.toString();
    weekendSaturday = json['weekend_saturday']?.toString();
    weekendSunday = json['weekend_sunday']?.toString();
    satsunTiffinCount = json['satsun_tiffin_count']?.toString();
    tiffinStartDate = json['tiffin_start_date']?.toString();
    packagingType = json['packaging_type']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['so_number'] = soNumber;
    data['order_date'] = orderDate;
    data['customer_name'] = customerName;
    data['customer_code'] = customerCode;
    data['phone'] = phone;
    data['order_packaging_status'] = orderPackagingStatus;
    data['order_shipping_status'] = orderShippingStatus;
    data['order_completed_status'] = orderCompletedStatus;
    data['total'] = total;
    data['branch_name'] = branchName;
    data['branch_contactno'] = branchContactno;
    data['coupon_amount'] = couponAmount;
    data['final_amount'] = finalAmount;
    data['order_category'] = orderCategory;
    data['tiffin_count'] = tiffinCount;
    data['weekend_saturday'] = weekendSaturday;
    data['weekend_sunday'] = weekendSunday;
    data['satsun_tiffin_count'] = satsunTiffinCount;
    data['tiffin_start_date'] = tiffinStartDate;
    data['packaging_type'] = packagingType;
    return data;
  }
}

class GetTiffinOrderListModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Order List",
  "order_list": [
    {
      "id": "73",
      "so_number": "72",
      "order_date": "15-03-2024",
      "customer_name": "Monika",
      "customer_code": "VK11",
      "phone": "9325612162",
      "order_packaging_status": "N",
      "order_shipping_status": "N",
      "order_completed_status": "N",
      "total": "2200.00",
      "branch_name": "sdd",
      "branch_contactno": "9822113577",
      "coupon_amount": 0,
      "final_amount": 2200,
      "order_category": "Tiffin",
      "tiffin_count": "22",
      "weekend_saturday": "yes",
      "weekend_sunday": "no",
      "satsun_tiffin_count": "4",
      "tiffin_start_date": "2024-03-19",
      "packaging_type": "Regular"
    }
  ]
} 
*/

  String? statusCode;
  String? status;
  String? message;
  List<GetTiffinOrderListModelOrderList?>? orderList;

  GetTiffinOrderListModel({
    this.statusCode,
    this.status,
    this.message,
    this.orderList,
  });
  GetTiffinOrderListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['order_list'] != null) {
      final v = json['order_list'];
      final arr0 = <GetTiffinOrderListModelOrderList>[];
      v.forEach((v) {
        arr0.add(GetTiffinOrderListModelOrderList.fromJson(v));
      });
      orderList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (orderList != null) {
      final v = orderList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['order_list'] = arr0;
    }
    return data;
  }
}
