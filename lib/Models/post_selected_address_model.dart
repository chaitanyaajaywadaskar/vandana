import 'dart:convert';

PostSelectedAddressModel postSelectedAddressModelFromJson(String str) =>
    PostSelectedAddressModel.fromJson(json.decode(str));

String postSelectedAddressModelToJson(PostSelectedAddressModel data) =>
    json.encode(data.toJson());

class PostSelectedAddressModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Address Selected Status Update successfully..."
} 
*/

  String? statusCode;
  String? status;
  String? message;

  PostSelectedAddressModel({
    this.statusCode,
    this.status,
    this.message,
  });
  PostSelectedAddressModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
