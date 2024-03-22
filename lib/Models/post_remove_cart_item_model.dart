import 'dart:convert';

PostRemoveCartItemModel postRemoveCartItemModelFromJson(String str) =>
    PostRemoveCartItemModel.fromJson(json.decode(str));

String postRemoveCartItemModelToJson(PostRemoveCartItemModel data) =>
    json.encode(data.toJson());

class PostRemoveCartItemModel {
  String? statusCode;
  String? status;
  String? message;

  PostRemoveCartItemModel({
    this.statusCode,
    this.status,
    this.message,
  });

  factory PostRemoveCartItemModel.fromJson(Map<String, dynamic> json) =>
      PostRemoveCartItemModel(
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
