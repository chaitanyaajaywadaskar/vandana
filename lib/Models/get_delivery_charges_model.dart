import 'dart:convert';

DeliveryChargesModel getDeliveryChargesModelFromJson(String str) =>
    DeliveryChargesModel.fromJson(json.decode(str));

String getDeliveryChargesModelToJson(DeliveryChargesModel data) =>
    json.encode(data.toJson());

class DeliveryChargesModelDcList {
/*
{
  "id": "1",
  "delivery_charges_category": "Tiffin",
  "delivery_charges_amt": "50"
} 
*/

  String? id;
  String? deliveryChargesCategory;
  String? deliveryChargesAmt;

  DeliveryChargesModelDcList({
    this.id,
    this.deliveryChargesCategory,
    this.deliveryChargesAmt,
  });
  DeliveryChargesModelDcList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    deliveryChargesCategory = json['delivery_charges_category']?.toString();
    deliveryChargesAmt = json['delivery_charges_amt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['delivery_charges_category'] = deliveryChargesCategory;
    data['delivery_charges_amt'] = deliveryChargesAmt;
    return data;
  }
}

class DeliveryChargesModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Success",
  "dc_list": [
    {
      "id": "1",
      "delivery_charges_category": "Tiffin",
      "delivery_charges_amt": "50"
    }
  ]
} 
*/

  String? statusCode;
  String? status;
  String? message;
  List<DeliveryChargesModelDcList?>? dcList;

  DeliveryChargesModel({
    this.statusCode,
    this.status,
    this.message,
    this.dcList,
  });
  DeliveryChargesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['dc_list'] != null) {
      final v = json['dc_list'];
      final arr0 = <DeliveryChargesModelDcList>[];
      v.forEach((v) {
        arr0.add(DeliveryChargesModelDcList.fromJson(v));
      });
      dcList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (dcList != null) {
      final v = dcList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['dc_list'] = arr0;
    }
    return data;
  }
}
