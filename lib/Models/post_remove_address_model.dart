import 'dart:convert';

PostRemoveAddressModel postRemoveAddressModelFromJson(String str) =>
    PostRemoveAddressModel.fromJson(json.decode(str));

String postRemoveAddressModelToJson(PostRemoveAddressModel data) =>
    json.encode(data.toJson());

class PostRemoveAddressModel {
  String? statusCode;
  String? status;
  String? message;

  PostRemoveAddressModel({
    this.statusCode,
    this.status,
    this.message,
  });

  factory PostRemoveAddressModel.fromJson(Map<String, dynamic> json) =>
      PostRemoveAddressModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
      };
}
