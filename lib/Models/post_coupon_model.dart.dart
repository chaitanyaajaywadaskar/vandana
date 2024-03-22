import 'dart:convert';

PostCouponModel postCouponModelFromJson(String str) =>
    PostCouponModel.fromJson(json.decode(str));

String postCouponModelToJson(PostCouponModel data) =>
    json.encode(data.toJson());

class PostCouponModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Coupon Apply successfully",
  "coupon_code": "VKCOP2",
  "coupon_price": "50",
  "final_price": 450
} 
*/

  String? statusCode;
  String? status;
  String? message;
  String? couponCode;
  String? couponPrice;
  int? finalPrice;

  PostCouponModel({
    this.statusCode,
    this.status,
    this.message,
    this.couponCode,
    this.couponPrice,
    this.finalPrice,
  });
  PostCouponModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    couponCode = json['coupon_code']?.toString();
    couponPrice = json['coupon_price']?.toString();
    finalPrice = json['final_price']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    data['coupon_code'] = couponCode;
    data['coupon_price'] = couponPrice;
    data['final_price'] = finalPrice;
    return data;
  }
}
