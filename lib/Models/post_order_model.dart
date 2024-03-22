import 'dart:convert';

PostOrderModel postOrderModelFromJson(String str) =>
    PostOrderModel.fromJson(json.decode(str));

String postOrderModelToJson(PostOrderModel data) => json.encode(data.toJson());

class PostOrderModel {
  String? statusCode;
  String? status;
  String? message;
  SaleOrderDetails? saleOrderDetails;

  PostOrderModel({
    this.statusCode,
    this.status,
    this.message,
    this.saleOrderDetails,
  });

  factory PostOrderModel.fromJson(Map<String, dynamic> json) => PostOrderModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        saleOrderDetails: SaleOrderDetails.fromJson(json["Sale_Order_Details"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "Sale_Order_Details": saleOrderDetails?.toJson(),
      };
}

class SaleOrderDetails {
  String? id;
  String? customerName;
  String? customerCode;
  String? soNumber;
  String? phone;
  String? address;
  DateTime? orderDt;
  String? orderTime;
  String? deliveryCharges;
  String? receiversName;
  String? billtoPhone;
  String? branch;
  String? username;
  String? userType;

  SaleOrderDetails({
    this.id,
    this.customerName,
    this.customerCode,
    this.soNumber,
    this.phone,
    this.address,
    this.orderDt,
    this.orderTime,
    this.deliveryCharges,
    this.receiversName,
    this.billtoPhone,
    this.branch,
    this.username,
    this.userType,
  });

  factory SaleOrderDetails.fromJson(Map<String, dynamic> json) =>
      SaleOrderDetails(
        id: json["id"],
        customerName: json["customer_name"],
        customerCode: json["customer_code"],
        soNumber: json["so_number"],
        phone: json["phone"],
        address: json["address"],
        orderDt: DateTime.parse(json["order_dt"]),
        orderTime: json["order_time"],
        deliveryCharges: json["delivery_charges"],
        receiversName: json["receivers_name"],
        billtoPhone: json["billto_phone"],
        branch: json["branch"],
        username: json["username"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "customer_code": customerCode,
        "so_number": soNumber,
        "phone": phone,
        "address": address,
        "order_dt":
            "${orderDt?.year.toString().padLeft(4, '0')}-${orderDt?.month.toString().padLeft(2, '0')}-${orderDt?.day.toString().padLeft(2, '0')}",
        "order_time": orderTime,
        "delivery_charges": deliveryCharges,
        "receivers_name": receiversName,
        "billto_phone": billtoPhone,
        "branch": branch,
        "username": username,
        "user_type": userType,
      };
}
